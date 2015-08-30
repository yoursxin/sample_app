class UsersController < ApplicationController
  def show
	@user = User.find(params[:id])
  end
  def new
	@user = User.new
  end
  def create
	@user = User.new(user_params) # Not the final implementation!
	if @user.save
	  flash[:success] = "Welcome to the Sample App!"
	  redirect_to @user
	else
	  render 'new'
	end
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
    :password_confirmation)
  end
end