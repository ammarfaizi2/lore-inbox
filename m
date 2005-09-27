Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVI0JOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVI0JOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 05:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVI0JOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 05:14:52 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36510 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S964876AbVI0JOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 05:14:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17209.3427.936263.463751@alkaid.it.uu.se>
Date: Tue, 27 Sep 2005 11:14:11 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
In-Reply-To: <20050927052128.GB21108@colo.lackof.org>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net>
	<20050927044840.GA21108@colo.lackof.org>
	<20050926215245.7a1be7fa.rdunlap@xenotime.net>
	<20050927052128.GB21108@colo.lackof.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler writes:
 > Yeah, my preference would be PCI_MSI only depend on Local APIC.
 > (Note that having a Local APIC implies having an IO APIC as well

Not true. Lots of systems have a local APIC but no I/O APICs.
However, having an I/O APIC pretty much implies having a local APIC.
