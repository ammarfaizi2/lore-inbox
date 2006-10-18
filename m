Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422972AbWJRVP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422972AbWJRVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422973AbWJRVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:15:59 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:19899 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422970AbWJRVP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:15:58 -0400
Date: Wed, 18 Oct 2006 23:15:55 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Sebastian Biallas <sb@biallas.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Disabling IOMMU
Message-ID: <20061018211555.GC4582@rhun.haifa.ibm.com>
References: <45364248.2020901@biallas.net> <200610181741.03428.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610181741.03428.prakash@punnoor.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 05:41:03PM +0200, Prakash Punnoor wrote:
> Am Mittwoch 18 Oktober 2006 17:03 schrieben Sie:
> > Hi,
> >
> > Linux ouputs some strange "PCI-DMA: Disabling IOMMU" on booting. It's a
> > ALiveNF4G motherboard with an Athlon64 X2 running vanilla Linux 2.6.18.1
> > (which supports all hardware out of the box, pretty cool).
> >
> > Should I worry about this IOMMU-disabling? All other Linux/IOMMU stuff I
> > found had AGP or BIOS messages nearby, but I only get this single
> > "PCI-DMA: Disabling IOMMU" line, without any hint.
> 
> Unless you have >=4GB of RAM using IOMMU makes no sense, thus it gets 
> disabled.

In some cases it certainly does (e.g, if it's an isolation capable
IOMMU), in others it doesn't matter even if you do have more than 4GB
of memory (e.g., if all of your devices are DAC capable).

Cheers,
Muli
