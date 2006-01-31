Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWAaXHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWAaXHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWAaXHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:07:21 -0500
Received: from xenotime.net ([66.160.160.81]:9664 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750957AbWAaXHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:07:20 -0500
Date: Tue, 31 Jan 2006 15:07:18 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Pat Gefre <pfg@sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 Altix : correct export call
In-Reply-To: <200601312304.k0VN4Pnp044804@fsgi900.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0601311506380.5449@shark.he.net>
References: <200601312304.k0VN4Pnp044804@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2006, Pat Gefre wrote:

> Andrew,
>
> I didn't get any resistence to this - so guessing these are the correct
> macro calls...
>
>
>
> Call EXPORT_SYMBOL_GPL in ioc3 shim layer.

only resistence to "Call".  Try "Use".


> Signed-off-by: Patrick Gefre <pfg@sgi.com>
>
>
>  ioc3.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
>
> Index: linux/drivers/sn/ioc3.c
> ===================================================================
> --- linux.orig/drivers/sn/ioc3.c	2006-01-26 10:46:30.201721192 -0600
> +++ linux/drivers/sn/ioc3.c	2006-01-26 11:53:34.685090381 -0600
> @@ -843,9 +843,9 @@
>  MODULE_DESCRIPTION("PCI driver for SGI IOC3");
>  MODULE_LICENSE("GPL");
>
> -EXPORT_SYMBOL(ioc3_register_submodule);
> -EXPORT_SYMBOL(ioc3_unregister_submodule);
> -EXPORT_SYMBOL(ioc3_ack);
> -EXPORT_SYMBOL(ioc3_gpcr_set);
> -EXPORT_SYMBOL(ioc3_disable);
> -EXPORT_SYMBOL(ioc3_enable);
> +EXPORT_SYMBOL_GPL(ioc3_register_submodule);
> +EXPORT_SYMBOL_GPL(ioc3_unregister_submodule);
> +EXPORT_SYMBOL_GPL(ioc3_ack);
> +EXPORT_SYMBOL_GPL(ioc3_gpcr_set);
> +EXPORT_SYMBOL_GPL(ioc3_disable);
> +EXPORT_SYMBOL_GPL(ioc3_enable);
> -

-- 
~Randy
