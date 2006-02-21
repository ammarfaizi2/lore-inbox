Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161461AbWBUKsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161461AbWBUKsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWBUKsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:48:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63431 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161461AbWBUKsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:48:45 -0500
Date: Tue, 21 Feb 2006 10:48:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, maule@sgi.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
Message-ID: <20060221104841.GE19349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, maule@sgi.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060214162337.GA16954@sgi.com> <20060220201713.GA4992@infradead.org> <20060220133956.01b59562.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220133956.01b59562.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:39:56PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> >  On Tue, Feb 14, 2006 at 10:23:37AM -0600, Mark Maule wrote:
> >  > Export sn_pcidev_info_get.
> > 
> >  Tony or Andrew please back this out again.
> 
> Please send a patch.


--- a/arch/ia64/sn/kernel/io_init.c	20 Feb 2006 14:29:08 -0000	1.11
+++ b/arch/ia64/sn/kernel/io_init.c	21 Feb 2006 10:47:10 -0000
@@ -716,4 +716,3 @@ EXPORT_SYMBOL(sn_pci_unfixup_slot);
 EXPORT_SYMBOL(sn_pci_controller_fixup);
 EXPORT_SYMBOL(sn_bus_store_sysdata);
 EXPORT_SYMBOL(sn_bus_free_sysdata);
-EXPORT_SYMBOL(sn_pcidev_info_get);
