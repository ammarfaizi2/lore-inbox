Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCaB1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUCaB1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:27:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:50155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261161AbUCaB1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:27:16 -0500
Date: Tue, 30 Mar 2004 17:26:15 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add PCI_DMA_{64,32}BIT constants
Message-ID: <20040331012615.GA12444@kroah.com>
References: <20040323052305.GA2287@havoc.gtf.org> <20040329223604.63d981d0.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329223604.63d981d0.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 10:36:04PM -0800, Randy.Dunlap wrote:
> On Tue, 23 Mar 2004 00:23:05 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> | 
> | Been meaning to do this for ages...
> | 
> | Another one for the janitors.
> 
> >>>Nice, I've pulled this to my pci tree and will forward it on to Linus in
> >>>the next round of pci patches after 2.6.5 is out.
> >>
> >>Yeah well...  in the intervening time, somebody on IRC commented
> >>
> >>"so what is so PCI-specific about those constants?"
> >>
> >>They probably ought to be DMA_{32,64}BIT_MASK or somesuch.
> > 
> > 
> > Heh, ok, care to make up another patch for this?  :)
> 
> 
> Here's an updated patch, applies to 2.6.5-rc2-bk9.
> I left the DMA_xxBIT_MASK defines in linux/pci.h, although
> they aren't necessarily PCI-specific.  Would we prefer to
> have them in linux/dma-mapping.h ?

Ok, this looks good.  I've backed out Jeff's patch and applied this one
instead to my tree.  If you want to move the defines, please send me a
patch relative to this one.

thanks,

greg k-h
