Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318747AbSHLRFH>; Mon, 12 Aug 2002 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSHLRFH>; Mon, 12 Aug 2002 13:05:07 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:59662 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318747AbSHLRFG>;
	Mon, 12 Aug 2002 13:05:06 -0400
Date: Mon, 12 Aug 2002 10:05:11 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Harrell 
	<mharrell-dated-1029513433.43d927@bittwiddlers.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: USB problem with 2.5.3[0-1]?
Message-ID: <20020812170511.GD15249@kroah.com>
References: <20020811155713.GA8319@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811155713.GA8319@bittwiddlers.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 15 Jul 2002 14:49:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 11:57:13AM -0400, Matthew Harrell wrote:
>   hid-core.c: ctrl urb status -32 received
>   hid-core.c: usb_submit_urb(ctrl) failed

Do you have 'usbmodules' on your system?  If so, try renaming it to
something else (like 'usbmodules.save') and see if that fixes your
problem.

Also, can you send the difference between /proc/bus/usb/devices on both
kernels?

thanks,

greg k-h
