Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSGTR03>; Sat, 20 Jul 2002 13:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317450AbSGTR03>; Sat, 20 Jul 2002 13:26:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:63498 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317448AbSGTR02>;
	Sat, 20 Jul 2002 13:26:28 -0400
Date: Sat, 20 Jul 2002 10:27:45 -0700
From: Greg KH <greg@kroah.com>
To: Shane Nay <shane@minirl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020720172745.GD27411@kroah.com>
References: <3D361091.13618.16DC46FB@localhost> <20020718060841.GC12626@kroah.com> <20020718161429.GB15037@kroah.com> <200207200805.BAA20399@granite.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207200805.BAA20399@granite.he.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 22 Jun 2002 16:01:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2002 at 12:41:05AM -0700, Shane Nay wrote:
> So, Greg, you mean generic USB-Device support? instead USB-Host 
> support as is in the main tree.

Exactly.

> There is some nice work for this in the ARM-Linux kernel specific to 
> the Strong-ARM chip, but I was able to adapt it to another ARM chip I 
> was working on easily.  (Though not finished yet due to a bug in the 
> USB-D controller h/w)  It's got the s/w to act like a ethernet device 
> or a pure bit pipe.
> 
> Have you looked closely at arch/arm/mach-sa1100/usb* recently?  It's 
> not far from being generalized.  The Zaurus I believe already uses 
> this work to act like an ethernet USB device, and iPaq folks on 
> handhelds.org have been using it for quite some time.

Yes, the arm code is nice.  But the Zarus uses the code from Lineo,
which I have merged into the main tree at:
	bk://linuxusb.bkbits.net/usbd-2.5

I really want to merge the arm and Lineo code together, so people don't
have to maintain two different trees which work on the same devices,
doing much the same thing.  That's the goal at least :)

The code also needs some serious cleanups, which is why I am asking for
help from people with one of these devices.

thanks,

greg k-h
