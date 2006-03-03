Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWCCWdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWCCWdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWCCWdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:33:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:23443 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750875AbWCCWdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:33:19 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Fri, 3 Mar 2006 23:32:42 +0100
User-Agent: KMail/1.8
Cc: Allen Martin <AMartin@nvidia.com>, Chris Wedgwood <cw@f00f.org>,
       Michael Monnerie <m.monnerie@zmi.at>, linux-kernel@vger.kernel.org
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48CCB0@hqemmail02.nvidia.com> <200603032312.13369.ak@suse.de> <4408C1E1.7090006@pobox.com>
In-Reply-To: <4408C1E1.7090006@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603032332.43178.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 23:23, Jeff Garzik wrote:
> Andi Kleen wrote:
> > On Friday 03 March 2006 22:27, Allen Martin wrote:
> >>nForce4 has 64 bit (40 bit AMD64) DMA in the SATA controller.  We gave
> >>the docs to Jeff Garzik under NDA.  He posted some non functional driver
> >>code to linux-ide earlier this week that has the 64 bit registers and
> >>structures although it doesn't make use of them.  Someone could pick
> >>this up if they wanted to work on it though.
> >
> > Thanks for the correction. Sounds nice - hopefully we'll get a driver
> > soon. I guess it's in good hands with Jeff for now.
>
> I'll happen but not soon.  Motivation is low at NV and here as well,
> since newer NV is AHCI.  The code in question, "NV ADMA", is essentially
> legacy at this point 

NForce4s are used widely in new shipping systems so I wouldn't
exactly call them legacy.

> -- though I certainly acknowledge the large current 
> installed base.  Just being honest about the current state of things...

How much work would it be to finish the prototype driver you have? 

-Andi
