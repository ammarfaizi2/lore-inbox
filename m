Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVEaVnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVEaVnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVEaVlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:41:39 -0400
Received: from [194.90.237.34] ([194.90.237.34]:47560 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261591AbVEaVkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:40:02 -0400
Date: Wed, 1 Jun 2005 00:40:05 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, stable@kernel.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci-sysfs: backport fix for 2.6.11.12
Message-ID: <20050531214005.GA8330@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050531163619.GA6711@mellanox.co.il> <20050531192349.GA21050@suse.de> <20050531205729.GA7921@mellanox.co.il> <20050531212545.GS14929@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531212545.GS14929@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Matthew Wilcox <matthew@wil.cx>:
> Subject: Re: [PATCH] pci-sysfs: backport fix for 2.6.11.12
> 
> On Tue, May 31, 2005 at 11:57:29PM +0300, Michael S. Tsirkin wrote:
> > No, unsigned int is 32 bit wide on all platforms with gcc,
> > char is signed and 8 bit wide on all platforms with gcc.
> 
> Oops, no.  char is signed on x86 and unsigned on ppc.  Other architectures
> vary (I believe arm, mips and parisc are also unsigned).

So there's no bug on these platforms :)

-- 
MST - Michael S. Tsirkin
