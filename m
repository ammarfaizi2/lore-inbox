Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWIAWgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWIAWgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWIAWgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:36:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39071 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750740AbWIAWg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:36:28 -0400
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM
	Improvements
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
In-Reply-To: <p73d5af5k6p.fsf@verdi.suse.de>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	 <200608311713.21618.bjorn.helgaas@hp.com>
	 <1157070616.7974.232.camel@localhost.localdomain>
	 <200608312353.05337.len.brown@intel.com>  <p73d5af5k6p.fsf@verdi.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Sep 2006 23:57:25 +0100
Message-Id: <1157151445.6271.336.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-01 am 23:52 +0200, ysgrifennodd Andi Kleen:
> What are these gaping holes? SATA seems to work at least on many
> drivers with an out of tree patch (that will hopefully be merged soon)

SATA ought to be pretty good now. 

> And IDE mostly works too except for HPA on thinkpads (which can be
> disabled in the BIOS). While certainly not perfect it doesn't seem
> that bad to me.

IDE also fails for various chipsets where PLLs need a recalibration or
setup needs redoing, and some users report things like floating IRQ 14
hangs on suspend or resume.

HPA now has a -mm proposed patch.

Alan


-- 
VGER BF report: H 0
