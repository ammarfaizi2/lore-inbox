Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSKBWau>; Sat, 2 Nov 2002 17:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSKBWat>; Sat, 2 Nov 2002 17:30:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40712 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261476AbSKBWaa>;
	Sat, 2 Nov 2002 17:30:30 -0500
Date: Sat, 2 Nov 2002 12:44:19 -0800
From: Greg KH <greg@kroah.com>
To: Jochen Friedrich <jochen@scram.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] USB Kernel bug in 2.5.45
Message-ID: <20021102204419.GB22607@kroah.com>
References: <Pine.LNX.4.44.0211021933220.18761-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021933220.18761-100000@gfrw1044.bocc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 07:37:55PM +0100, Jochen Friedrich wrote:
> Hi,
> 
> when running "rmmod hid" while a USB HID device is still connected (but
> not used), i get this Oops messages:
> 
> drivers/usb/core/usb.c: deregistering driver hiddev
> drivers/usb/core/usb.c: deregistering driver hid
> devfs_put(fffffc0009393000): poisoned pointer

If you disable devfs does it work ok?

thanks,

greg k-h
