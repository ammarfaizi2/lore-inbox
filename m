Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422969AbWJRVQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422969AbWJRVQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422966AbWJRVQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:16:30 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:35903 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422969AbWJRVQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:16:29 -0400
Date: Wed, 18 Oct 2006 23:16:26 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Sebastian Biallas <sb@biallas.net>
Cc: Prakash Punnoor <prakash@punnoor.de>, linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Disabling IOMMU
Message-ID: <20061018211626.GD4582@rhun.haifa.ibm.com>
References: <45364248.2020901@biallas.net> <200610181741.03428.prakash@punnoor.de> <45364D9D.2060003@biallas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45364D9D.2060003@biallas.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 05:51:57PM +0200, Sebastian Biallas wrote:
> Prakash Punnoor wrote:
> > Am Mittwoch 18 Oktober 2006 17:03 schrieben Sie:
> >> Linux ouputs some strange "PCI-DMA: Disabling IOMMU" on booting. It's a
> >> ALiveNF4G motherboard with an Athlon64 X2 running vanilla Linux 2.6.18.1
> >> (which supports all hardware out of the box, pretty cool).
> >>
> >> Should I worry about this IOMMU-disabling? All other Linux/IOMMU stuff I
> >> found had AGP or BIOS messages nearby, but I only get this single
> >> "PCI-DMA: Disabling IOMMU" line, without any hint.
> > 
> > Unless you have >=4GB of RAM using IOMMU makes no sense, thus it gets 
> > disabled.
> 
> Thanks for the answer (I thought that IOMMU is also used by VMMs like
> XEN, for direct hardware access of the guest. But I might have
> misunderstood this).

Nope, you got it right, that's one of the neater uses of an isolation
capable IOMMU.

Cheers,
Muli
