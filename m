Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030620AbWBODd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030620AbWBODd2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWBODd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:33:28 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4582 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030620AbWBODd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:33:27 -0500
Date: Tue, 14 Feb 2006 19:33:11 -0800
From: Greg KH <gregkh@suse.de>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 7/9] isdn4linux: Siemens Gigaset drivers - direct USB connection
Message-ID: <20060215033310.GD5099@suse.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.7@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.11.001.7@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 03:52:28PM +0100, Hansjoerg Lipp wrote:
> +/* table of devices that work with this driver */
> +static struct usb_device_id gigaset_table [] = {
> +	{ USB_DEVICE(USB_GIGA_VENDOR_ID, USB_GIGA_PRODUCT_ID) },
> +	{ USB_DEVICE(USB_GIGA_VENDOR_ID, USB_4175_PRODUCT_ID) },
> +	{ USB_DEVICE(USB_GIGA_VENDOR_ID, USB_SX303_PRODUCT_ID) },
> +	{ USB_DEVICE(USB_GIGA_VENDOR_ID, USB_SX353_PRODUCT_ID) },
> +	{ } /* Terminating entry */
> +};
> +
> +MODULE_DEVICE_TABLE(usb, gigaset_table);
> +
> +/* Get a minor range for your devices from the usb maintainer */
> +#define USB_SKEL_MINOR_BASE	200

I don't think you need that comment anymore, or the #define anymore :)

thanks,

greg k-h
