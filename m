Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWJSMGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWJSMGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWJSMGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:06:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50394 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751584AbWJSMGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:06:15 -0400
Subject: Re: PCI-DMA: Disabling IOMMU
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Sebastian Biallas <sb@biallas.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610182348.44968.ak@suse.de>
References: <45364248.2020901@biallas.net>
	 <20061018211509.GB4582@rhun.haifa.ibm.com>  <200610182348.44968.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 13:08:08 +0100
Message-Id: <1161259688.17335.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 23:48 +0200, ysgrifennodd Andi Kleen:
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

Actually if you flip it around and print
"PCI-DMA: Enabling IOMMU"

and keep quiet if you disable it then users should be happy because its
turned something on and that is clearly always good 8)


