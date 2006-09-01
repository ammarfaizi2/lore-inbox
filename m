Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWIAVwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWIAVwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWIAVwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:52:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:6579 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751045AbWIAVwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:52:43 -0400
To: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	<200608311713.21618.bjorn.helgaas@hp.com>
	<1157070616.7974.232.camel@localhost.localdomain>
	<200608312353.05337.len.brown@intel.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Sep 2006 23:52:14 +0200
In-Reply-To: <200608312353.05337.len.brown@intel.com>
Message-ID: <p73d5af5k6p.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Len Brown <len.brown@intel.com> writes:
> 
> Re: optimizing suspend/resume speed
> I expect suspend/resume speed has more to do with devices than with ACPI.
> But frankly, with gaping functionality holes in Linux suspend/resume support such as
> IDE and SATA, I think that optimizing for suspend/resume speed on a mainstream laptop
> is somewhat "forward looking".

What are these gaping holes? SATA seems to work at least on many
drivers with an out of tree patch (that will hopefully be merged soon)
And IDE mostly works too except for HPA on thinkpads (which can be
disabled in the BIOS). While certainly not perfect it doesn't seem
that bad to me.

-Andi


-- 
VGER BF report: H 0
