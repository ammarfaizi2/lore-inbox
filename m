Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbTGIUA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266118AbTGIUA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 16:00:26 -0400
Received: from granite.he.net ([216.218.226.66]:28934 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S266108AbTGIUA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 16:00:26 -0400
Date: Wed, 9 Jul 2003 13:15:10 -0700
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CRIS architecture update
Message-ID: <20030709201510.GA18787@kroah.com>
References: <200307091905.h69J5srp005054@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307091905.h69J5srp005054@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -Nru a/arch/cris/drivers/usb-host.c b/arch/cris/drivers/usb-host.c
> --- a/arch/cris/drivers/usb-host.c	Wed Jul  9 12:06:00 2003
> +++ b/arch/cris/drivers/usb-host.c	Wed Jul  9 12:06:00 2003
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION (2, 4, 20)
> +typedef struct urb urb_t, *purb_t;
> +typedef struct iso_packet_descriptor iso_packet_descriptor_t;
> +typedef struct usb_ctrlrequest devrequest;
> +#endif

ICK ICK ICK!  Please do not do this.  These typedefs were removed for a
reason!

greg k-h
