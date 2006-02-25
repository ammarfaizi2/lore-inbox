Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWBYLz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWBYLz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBYLz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:55:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58343 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030229AbWBYLz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:55:28 -0500
Date: Sat, 25 Feb 2006 11:55:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       maule@sgi.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
Message-ID: <20060225115526.GB24439@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, maule@sgi.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060214162337.GA16954@sgi.com> <20060220201713.GA4992@infradead.org> <20060220133956.01b59562.akpm@osdl.org> <20060221104841.GE19349@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221104841.GE19349@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 10:48:41AM +0000, Christoph Hellwig wrote:
> On Mon, Feb 20, 2006 at 01:39:56PM -0800, Andrew Morton wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > >  On Tue, Feb 14, 2006 at 10:23:37AM -0600, Mark Maule wrote:
> > >  > Export sn_pcidev_info_get.
> > > 
> > >  Tony or Andrew please back this out again.
> > 
> > Please send a patch.

ping?

> --- a/arch/ia64/sn/kernel/io_init.c	20 Feb 2006 14:29:08 -0000	1.11
> +++ b/arch/ia64/sn/kernel/io_init.c	21 Feb 2006 10:47:10 -0000
> @@ -716,4 +716,3 @@ EXPORT_SYMBOL(sn_pci_unfixup_slot);
>  EXPORT_SYMBOL(sn_pci_controller_fixup);
>  EXPORT_SYMBOL(sn_bus_store_sysdata);
>  EXPORT_SYMBOL(sn_bus_free_sysdata);
> -EXPORT_SYMBOL(sn_pcidev_info_get);
---end quoted text---
