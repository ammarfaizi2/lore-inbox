Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVKFQqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVKFQqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 11:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVKFQqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 11:46:08 -0500
Received: from outbound01.telus.net ([199.185.220.220]:50646 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751066AbVKFQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 11:46:07 -0500
From: Andi Kleen <ak@suse.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping - K3
Date: Sun, 6 Nov 2005 17:45:53 +0100
User-Agent: KMail/1.8
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
References: <20051106131112.GE24739@granada.merseine.nu> <20051106145947.GH3423@mea-ext.zmailer.org>
In-Reply-To: <20051106145947.GH3423@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511061745.54266.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 15:59, Matti Aarnio wrote:
> On Sun, Nov 06, 2005 at 03:11:12PM +0200, Muli Ben-Yehuda wrote:
> > Hi Andi,
> >
> > Here's the latest version of the dma_ops patch, updated to address
> > your comments. The patch is against Linus's tree as of a few minutes
> > ago and applies cleanly to 2.6.14-git9. Tested on AMD64 with gart,
> > swiotlb, nommu and iommu=off. There are still a few cleanups left, but
> > I'd appreciate it if this could see wider testing at this
> > stage. Please apply...
>
>   Works mostly.
> There is some problem which I am not sure of is it related
> to this at all or not.  

You can easily find out: Does it happen without the patch?
If yes please post the full boot log.

Thanks,
-Andi
