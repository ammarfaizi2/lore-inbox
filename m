Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265778AbSKAVrT>; Fri, 1 Nov 2002 16:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265772AbSKAVrT>; Fri, 1 Nov 2002 16:47:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13062 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265778AbSKAVrS>;
	Fri, 1 Nov 2002 16:47:18 -0500
Date: Fri, 1 Nov 2002 13:50:38 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Harrell 
	<mharrell-dated-1036592872.f6edc2@bittwiddlers.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4[3-5] usb problems
Message-ID: <20021101215038.GB18015@kroah.com>
References: <20021101142751.GA908@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101142751.GA908@bittwiddlers.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 09:27:51AM -0500, Matthew Harrell wrote:
> 
> A few different problems.  First, when I use my USB hub then I get this 
> 
>   drivers/usb/core/hub.c: new USB device 00:11.2-1, assigned address 2
>   drivers/usb/core/hub.c: USB hub found at 1
>   drivers/usb/core/hub.c: 9 ports detected
>   drivers/usb/core/hub.c: new USB device 00:11.2-1.4, assigned address 3
>   drivers/usb/core/hub.c: USB hub found at 1.4
>   drivers/usb/core/hub.c: 3 ports detected
>   drivers/usb/core/hub.c: new USB device 00:11.2-1.7, assigned address 4
>   drivers/usb/core/hub.c: new USB device 00:11.2-1.8, assigned address 5
>   drivers/usb/input/hid-core.c: ctrl urb status -32 received
>   drivers/usb/input/hid-core.c: usb_submit_urb(ctrl) failed
> 
> and none of the USB devices show up at all.  But, when I plug the keyboard
> and mouse in without the hub they work fine.

I'm seeing some strange USB hub issues here too (hubs that work fine on
2.4, not working on 2.5, hubs that only work on boot, but not attaching
later), so you aren't alone.

It's time now for some serious USB debugging to get on, now that we have
the main feature freeze done.

thanks,

greg k-h
