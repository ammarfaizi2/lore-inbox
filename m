Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283555AbRK3IRX>; Fri, 30 Nov 2001 03:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283557AbRK3IRO>; Fri, 30 Nov 2001 03:17:14 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:9480 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S283555AbRK3IQ4>;
	Fri, 30 Nov 2001 03:16:56 -0500
Date: Fri, 30 Nov 2001 00:16:40 -0800
From: Greg KH <greg@kroah.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org, ziegler@informatik.hu-berlin.de
Subject: Re: IDE controller detection 2.4 +devfs
Message-ID: <20011130001640.D9596@kroah.com>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net> <200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca> <20011130012752.0fd5380a.rene.rebe@gmx.net> <20011129215855.C8914@kroah.com> <20011130085620.24abaf84.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130085620.24abaf84.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 02 Nov 2001 05:43:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 08:56:20AM +0100, Rene Rebe wrote:
> On Thu, 29 Nov 2001 21:58:55 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > USBfs?  What's that?  I don't see that in the kernel, yet :)
> 
> Hu? 2.4.x:
> 
> USB support  ---> Preliminary USB device filesystem
> 
> ??? !!! - It is normally mounted to /proc/bus/usb ...

Ah, that's "usbdevfs".  But people keep thinking that it has something
to do with "devfs" so I want to rename it to "usbfs".  It will not be
until 2.7 that the old name can go away.

> (But it is not that great (except it works for using a Canon IXUS
> digital camera via gphoto2 ... - but controlling the permissions
> really sucks (or I do not know how to do this correctly ... ?)

It's a load time option when you load the usbcore module.

thanks,

greg k-h
