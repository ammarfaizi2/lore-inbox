Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVCRBVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVCRBVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVCRBTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:19:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:48847 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261422AbVCRBTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:19:15 -0500
Date: Thu, 17 Mar 2005 17:02:28 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] USB: possible cleanups
Message-ID: <20050318010228.GA7816@kroah.com>
References: <20050301004352.GD4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301004352.GD4021@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:43:52AM +0100, Adrian Bunk wrote:
> Before I'm getting flamed to death:
> This patch contains possible cleanups. If parts of this patch conflict
> with pending changes these parts of my patch have to be dropped.
> 
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global functions:
>   - core/usb.c: usb_buffer_map
>   - core/usb.c: usb_buffer_unmap
> - remove the following unneeded EXPORT_SYMBOL's:
>   - core/hcd.c: usb_bus_init
>   - core/hcd.c: usb_alloc_bus
>   - core/hcd.c: usb_register_bus
>   - core/hcd.c: usb_deregister_bus
>   - core/hcd.c: usb_hcd_irq
>   - core/usb.c: usb_buffer_map
>   - core/usb.c: usb_buffer_unmap
>   - core/buffer.c: hcd_buffer_create
>   - core/buffer.c: hcd_buffer_destroy
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks good to me, thanks for the patch.  Applied.

greg k-h
