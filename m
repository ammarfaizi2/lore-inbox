Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVKFRGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVKFRGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVKFRGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:06:51 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:53720 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S932137AbVKFRGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:06:50 -0500
Date: Sun, 6 Nov 2005 19:06:49 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andi Kleen <ak@suse.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping - K3
Message-ID: <20051106170649.GI3423@mea-ext.zmailer.org>
References: <20051106131112.GE24739@granada.merseine.nu> <20051106145947.GH3423@mea-ext.zmailer.org> <200511061745.54266.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511061745.54266.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 05:45:53PM +0100, Andi Kleen wrote:
> On Sunday 06 November 2005 15:59, Matti Aarnio wrote:
> > On Sun, Nov 06, 2005 at 03:11:12PM +0200, Muli Ben-Yehuda wrote:
> > > Hi Andi,
> > >
> > > Here's the latest version of the dma_ops patch, updated to address
> > > your comments. The patch is against Linus's tree as of a few minutes
> > > ago and applies cleanly to 2.6.14-git9. Tested on AMD64 with gart,
> > > swiotlb, nommu and iommu=off. There are still a few cleanups left, but
> > > I'd appreciate it if this could see wider testing at this
> > > stage. Please apply...
> >
> >   Works mostly.
> > There is some problem which I am not sure of is it related
> > to this at all or not.  
> 
> You can easily find out: Does it happen without the patch?
> If yes please post the full boot log.

git7 blows up like git2, git9 plain was not tested at all.
I am applying the debug patch and compiling right now for a test.

> Thanks,
> -Andi

/Matti Aarnio
