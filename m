Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbUBXQ1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUBXQ1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:27:39 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:27628 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262264AbUBXQ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:27:37 -0500
Date: Tue, 24 Feb 2004 08:27:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: richard.brunner@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IOMMUs was Re: Intel vs AMD x86-64
Message-ID: <20040224162720.GA9087@srv-lnx2600.matchmail.com>
Mail-Followup-To: richard.brunner@amd.com, linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C0FD384E3@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0FD384E3@txexmtae.amd.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:50:02AM -0600, richard.brunner@amd.com wrote:
> 
> > -----Original Message-----
> > From: Andi Kleen [mailto:ak@suse.de] 
> 
>  
> > On Opteron the IOMMU code (ab)uses the built in AGPv3 GART in 
> > the CPU, which 
> > was originally intended for AGP. AMD converted it to be able 
> > to remap PCI especially for Linux, which I think deserves applause.
> > 
> > It works surprisingly well even though it was not designed as 
> > a real IOMMU. Of course one of the main advantages of a real 
> > IOMMU - preventing arbitary memory corruption from broken 
> > devices - is lost because the remapping table is just a hole 
> > in the memory. I'm 
> > secretly hoping that when there is more support for Linux at 
> > chipset vendors they will someday add a bit to isolate all 
> > traffic that doesn't go through the GART from the main 
> > memory. This way you could get a much more reliable system 
> > that can tolerate broken PCI devices at a moderate 
> > performance penalty.
> 
> Andi is being modest. It was he and Andrea Arcangeli who convinced 
> me we had a problem. We found a way to trick the AGP
> GART hardware into helping, and then they turned it into a 
> "real" solution and helped us work the warts out of the BIOS 
> to enable it.

Yowza!  Open source helping to make better processors.  :-D
