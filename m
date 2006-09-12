Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWILOp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWILOp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWILOp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:45:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:30477 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030213AbWILOp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:45:27 -0400
Date: Tue, 12 Sep 2006 10:45:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Henne <henne@nachtwindheim.de>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [MM] fixes kerneldoc errors in usbcore-auto(susp/res)-patch
In-Reply-To: <4506A15B.1080006@nachtwindheim.de>
Message-ID: <Pine.LNX.4.44L0.0609121044570.6338-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Henne wrote:

> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Fixes kerneldoc errors on usb/core/driver.c, which occured in 2.6.18-rc6-mm2 
> gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> 
> ---
> 
> --- linux-2.6.18-rc6-mm2/drivers/usb/core/driver.c	2006-09-12 13:31:56.000000000 +0200
> +++ devel/drivers/usb/core/driver.c	2006-09-12 13:33:12.000000000 +0200
> @@ -1102,8 +1102,8 @@
>  
>  /**
>   * usb_autosuspend_device - delayed autosuspend of a USB device and its interfaces
> - * @udev - the usb_device to autosuspend
> - * @dec_usage_cnt - flag to decrement @udev's PM-usage counter
> + * @udev: the usb_device to autosuspend
> + * @dec_usage_cnt: flag to decrement @udev's PM-usage counter
>   *
>   * This routine should be called when a core subsystem is finished using
>   * @udev and wants to allow it to autosuspend.  Examples would be when
> @@ -1139,8 +1139,8 @@
>  
>  /**
>   * usb_autoresume_device - immediately autoresume a USB device and its interfaces
> - * @udev - the usb_device to autoresume
> - * @inc_usage_cnt - flag to increment @udev's PM-usage counter
> + * @udev: the usb_device to autoresume
> + * @inc_usage_cnt: flag to increment @udev's PM-usage counter
>   *
>   * This routine should be called when a core subsystem wants to use @udev
>   * and needs to guarantee that it is not suspended.  In addition, the
> @@ -1180,7 +1180,7 @@
>  
>  /**
>   * usb_autopm_put_interface - decrement a USB interface's PM-usage counter
> - * @intf - the usb_interface whose counter should be decremented
> + * @intf: the usb_interface whose counter should be decremented
>   *
>   * This routine should be called by an interface driver when it is
>   * finished using @intf and wants to allow it to autosuspend.  A typical
> @@ -1227,7 +1227,7 @@
>  
>  /**
>   * usb_autopm_get_interface - increment a USB interface's PM-usage counter
> - * @intf - the usb_interface whose counter should be incremented
> + * @intf: the usb_interface whose counter should be incremented
>   *
>   * This routine should be called by an interface driver when it wants to
>   * use @intf and needs to guarantee that it is not suspended.  In addition,
> 
> 
> 
> 

