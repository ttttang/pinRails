class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

def index
   @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
end


  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create 
    @pin = current_user.pins.build(pin_params)
    @pin.save
    redirect_to @pin 
  end

  def update
    @pin.update(pin_params)
    redirect_to @pin
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
