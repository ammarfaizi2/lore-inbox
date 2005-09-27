Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVI0WLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVI0WLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVI0WLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:11:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19588 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965201AbVI0WLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:11:05 -0400
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       gregkh <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de
In-Reply-To: <4339B8EA.1080303@pobox.com>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net>
	 <20050927044840.GA21108@colo.lackof.org>  <4339B8EA.1080303@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Sep 2005 23:37:50 +0100
Message-Id: <1127860670.10674.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-27 at 17:26 -0400, Jeff Garzik wrote:
> Grant Grundler wrote:
> > I've no clue why folks thought it was better to ignore
> > the IO APIC on UP kernels.
> 
> Hysterical raisins:  the -majority- of the early uniprocessor systems 
> that claimed IOAPIC support were broken.

Not really broken in most cases, but since nobody was using the APIC
board makers didn't bother wiring for it.

