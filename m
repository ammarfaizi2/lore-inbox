Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289889AbSBOQFT>; Fri, 15 Feb 2002 11:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSBOQE7>; Fri, 15 Feb 2002 11:04:59 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:29198 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289889AbSBOQEu>;
	Fri, 15 Feb 2002 11:04:50 -0500
Date: Fri, 15 Feb 2002 08:00:32 -0800
From: Greg KH <greg@kroah.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wrong priority reporting with new 0(1) scheduler;  USB changes to 2.4.18 pre/rc1 breaks HPOJ
Message-ID: <20020215160032.GC1695@kroah.com>
In-Reply-To: <20020215142941.79B12942@pc.kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020215142941.79B12942@pc.kolivas.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 18 Jan 2002 13:35:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 01:29:41AM +1100, Con Kolivas wrote:
> 
> The USB changes after 2.4.17 up to and including 2.4.18 rc1 cause the hp 
> officejet drivers to fail on my machine. While the usb mouse continues to 
> work, the hp ptal-init probe cannot find the device when scanning 
> /dev/usb/lp0. The device is still reported correctly in 
> /proc/bus/usb/devices. This is with both the usb-uhci and the uhci drivers.

There have been some "interesting" discussions about HP printers on the
linux-usb-devel mailing list :)

A very simple patch that might work for you is at:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101338636901219
while a more "correct" patch is at:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101366701613394

Please let me know if either of these patches fix your problem.

thanks,

greg k-h
