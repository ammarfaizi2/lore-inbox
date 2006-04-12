Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWDLEB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWDLEB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 00:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDLEB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 00:01:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:55739 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751338AbWDLEB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 00:01:57 -0400
From: Neil Brown <neilb@suse.de>
To: Pavel Machek <pavel@suse.cz>
Date: Wed, 12 Apr 2006 14:01:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17468.31627.825807.569134@cse.unsw.edu.au>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to correct ELCR? - was Re: [PATCH 2.6.16] Shared interrupts sometimes lost
In-Reply-To: message from Pavel Machek on Tuesday April 11
References: <5Zd5E-3vi-7@gated-at.bofh.it>
	<4437C45E.8010503@shaw.ca>
	<17464.55398.270243.839773@cse.unsw.edu.au>
	<20060411170728.GB1893@elf.ucw.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 11, pavel@suse.cz wrote:
> > 
> > I currently have Linux compiled without ACPI support (as I don't
> > really want that and being an oldish notebook I gather it has a good
> > chance of causing problems) so that isn't fiddling with the ELCR.
> 
> Can you try to enable ACPI and/or APIC? Some machines are known to
> require APIC...

Thanks for the suggestions.

I now have

CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

in my .config, and it doesn't make any apparent difference.
I haven't tried ACPI yet... maybe in a couple of days.

Thanks again,
NeilBrown
