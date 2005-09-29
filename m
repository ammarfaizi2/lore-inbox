Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVI2D1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVI2D1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 23:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVI2D1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 23:27:54 -0400
Received: from colo.lackof.org ([198.49.126.79]:26781 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1750808AbVI2D1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 23:27:54 -0400
Date: Wed, 28 Sep 2005 21:34:26 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       gregkh <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
Message-ID: <20050929033426.GA3892@colo.lackof.org>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net> <20050927044840.GA21108@colo.lackof.org> <4339B8EA.1080303@pobox.com> <1127860670.10674.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127860670.10674.32.camel@localhost.localdomain>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 11:37:50PM +0100, Alan Cox wrote:
> On Maw, 2005-09-27 at 17:26 -0400, Jeff Garzik wrote:
> > Grant Grundler wrote:
> > > I've no clue why folks thought it was better to ignore
> > > the IO APIC on UP kernels.
> > 
> > Hysterical raisins:  the -majority- of the early uniprocessor systems 
> > that claimed IOAPIC support were broken.
> 
> Not really broken in most cases, but since nobody was using the APIC
> board makers didn't bother wiring for it.

ok. Any clue how PCI IRQs got routed/handled on those boxes?
Did UP boards have an 8259 PIC and an IRQ line to the CPU?
Could an 8529 PIC even co-exist with an IO APIC?

Or was it something more silly like BIOS mfgs had no version
of Windows that could grok a IRQ routing table and thus no
incentive to enable that feature?

thanks,
grant
