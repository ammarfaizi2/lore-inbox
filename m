Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWERWRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWERWRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWERWRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:17:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41619 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750819AbWERWRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:17:00 -0400
Date: Thu, 18 May 2006 15:14:55 -0700
From: Greg KH <greg@kroah.com>
To: Eduard Warkentin <eduard.warkentin@gmx.de>
Cc: Phil Chang <pchang23@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] added support for ASIX 88178 chipset USB Gigabit Ethernet adaptor
Message-ID: <20060518221455.GA32549@kroah.com>
References: <e4gbbs$d37$1@sea.gmane.org> <20060517235902.GA8060@kroah.com> <446CEC8B.5070809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446CEC8B.5070809@gmx.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 11:52:11PM +0200, Eduard Warkentin wrote:
> Hi Greg!
> 
> First of all, i hope you arent angry about having me sent this reply
> as CC to the current maintainer and to the mailing list. If so, I
> apologize, and it wont happen in future.
> 
> > Hm, your tabs and spaces are messed up :(
> I reviewed the original file again, and the lines just above mine
> indeed have spare leading whitespaces. Shall  I include changing them
> in my patch?

No, your tabs got eaten by your email client, and it happened again:

> --- ./drivers/usb/net/asix.c.orig 2006-03-20 06:53:29.000000000 +0100
> +++ ./drivers/usb/net/asix.c  2006-05-18 01:18:52.000000000 +0200
> @@ -913,6 +913,10 @@ static const struct usb_device_id  produc
>          USB_DEVICE (0x0b95, 0x7720),
>          .driver_info = (unsigned long) &ax88772_info,
>  }, {
> +  // ASIX AX88178 10/100/1000
> +  USB_DEVICE (0x0b95, 0x1780),
> +  .driver_info = (unsigned long) &ax88772_info,
> +}, {
>   // Linksys USB200M Rev 2
>   USB_DEVICE (0x13b1, 0x0018),
>   .driver_info = (unsigned long) &ax88772_info,

See, tabs converted to spaces, not good :(

Care for a third try?

thanks,

greg k-h
