Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289068AbSAGBf0>; Sun, 6 Jan 2002 20:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289069AbSAGBfR>; Sun, 6 Jan 2002 20:35:17 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:19977 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289068AbSAGBfC>;
	Sun, 6 Jan 2002 20:35:02 -0500
Date: Sun, 6 Jan 2002 17:33:12 -0800
From: Greg KH <greg@kroah.com>
To: Dylan Egan <crack_me@bigpond.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 - hanging due to usb
Message-ID: <20020107013311.GA4064@kroah.com>
In-Reply-To: <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 09 Dec 2001 23:27:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 12:13:55PM +1100, Dylan Egan wrote:
> Hi,
> 
> I am currently trying to install my usb-storage device to use with 2.4.17.

Which kind of usb-storage device?

> I have my usb device connected and switched on so when i do insmod usb-uhci 
> or insmod uhci it automatically picks it up and goes to install it but a 
> few seconds after its done that, linux just freezes up and i can't do 
> anything except reboot via the reboot switch (keyboard does not work). My 
> usb is using a shared irq with onboard sound so i disabled sound in the 
> BIOS and retried, only to find it failed again. I dont have enough time to 
> check for any errors so i can't figure out the problem and when i check the 
> logs there seems to be nothing out of the ordinary.

There is no oops message?
Has this usb-storage device ever worked on any previous kernel version?
Do any other types of USB devices work with Linux on this machine?

thanks,

greg k-h
