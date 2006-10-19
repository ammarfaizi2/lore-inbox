Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423252AbWJSFPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423252AbWJSFPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 01:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423253AbWJSFPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 01:15:32 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:63160 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423252AbWJSFPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 01:15:31 -0400
Date: Thu, 19 Oct 2006 07:15:28 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Sebastian Biallas <sb@biallas.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Disabling IOMMU
Message-ID: <20061019051528.GE4582@rhun.haifa.ibm.com>
References: <45364248.2020901@biallas.net> <20061018211509.GB4582@rhun.haifa.ibm.com> <200610182348.44968.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610182348.44968.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 11:48:44PM +0200, Andi Kleen wrote:
> On Wednesday 18 October 2006 23:15, Muli Ben-Yehuda wrote:
> > On Wed, Oct 18, 2006 at 05:03:36PM +0200, Sebastian Biallas wrote:
> > 
> > > Should I worry about this IOMMU-disabling? All other Linux/IOMMU stuff I
> > > found had AGP or BIOS messages nearby, but I only get this single
> > > "PCI-DMA: Disabling IOMMU" line, without any hint.
> > 
> > No, it's fine. Just a badly worded information message. Andi, how
> > about something like this?
> 
> I think the original message is fine. I'm sure someone will be alarmed
> about any possible message, but we can't help them.

The original message is misleading - there may certainly be more than
one IOMMU and then we will end up "disabling IOMMU" and then
"reenabling IOMMU" later when we detect another one. Can we at least
make it "disabling GART IOMMU"?

Cheers,
Muli

