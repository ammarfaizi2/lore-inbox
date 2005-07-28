Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVG1Gs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVG1Gs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 02:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVG1Gs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 02:48:59 -0400
Received: from [194.90.237.34] ([194.90.237.34]:64228 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261291AbVG1Gs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 02:48:57 -0400
Date: Thu, 28 Jul 2005 09:48:59 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       mj@ucw.cz, openib-general@openib.org
Subject: Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Message-ID: <20050728064859.GA11644@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050725223200.GA1545@mellanox.co.il> <20050728042607.GA12799@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728042607.GA12799@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> Subject: Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
> 
> On Tue, Jul 26, 2005 at 01:32:00AM +0300, Michael S. Tsirkin wrote:
> > Greg, Martin, does the following make sense?
> > If it does, should other architectures be updated as well?
> > 
> Hm, you do realize that io_remap_pfn_range() is the same thing as
> remap_pfn_range() on i386, right?
> 
> So, why would this patch change anything?
> 
> thanks,
> 
> greg k-h
> 

It doesnt change any behaviour.
Its a style issue I'm trying to fix: even in arch specific code, isnt it better
to use a generic io_remap_pfn_range to map PCI memory?

-- 
MST
