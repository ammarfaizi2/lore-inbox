Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSHDQTN>; Sun, 4 Aug 2002 12:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSHDQTN>; Sun, 4 Aug 2002 12:19:13 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:41996 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317944AbSHDQTM>;
	Sun, 4 Aug 2002 12:19:12 -0400
Date: Sun, 4 Aug 2002 09:20:31 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Message-ID: <20020804162030.GA22588@kroah.com>
References: <200208041656.21035.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208041656.21035.kiza@gmx.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 07 Jul 2002 15:12:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 04:56:19PM +0200, Oliver Feiler wrote:
> Hi,
> 
> Since 2.4.19 a usb mouse does not work anymore if
> 
> CONFIG_USB_HID=m
> and
> CONFIG_INPUT_MOUSEDEV=m
> 
> is set. It only works if both are compiled into the kernel. Yes, I have set
> CONFIG_USB_HIDINPUT=y.
> 
> I've also seen other complaints about usb mice not working in 2.4.19, I guess 
> that's the problem?
> 
> If the stuff is compiled as modules, everything seems to be fine. The kernel 
> messages are the same, everything is detected fine. Except that 'cat 
> /dev/input/mice' does not give any output if the driver is compiled as 
> module.

Are you sure the hid.o module is loaded?  :)

greg k-h
