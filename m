Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVCWBBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVCWBBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVCWBAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:00:09 -0500
Received: from fmr20.intel.com ([134.134.136.19]:63941 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262683AbVCWA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:57:12 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Li Shaohua <shaohua.li@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
Content-Type: text/plain
Message-Id: <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 23 Mar 2005 08:54:09 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 04:57, Bjorn Helgaas wrote:
> > Your patch applied with some problems:
> >
> > patching file arch/i386/pci/irq.c
> > Hunk #2 succeeded at 1081 with fuzz 2 (offset 1 line).
> > patching file drivers/acpi/pci_irq.c
> > patching file drivers/pci/quirks.c
> > Hunk #1 succeeded at 678 (offset -5 lines).
> 
> These indicate minor differences in these files between upstream BK
> (which is what my patch was against) and the kernel you're building.
> You can ignore them.
> 
> > Then I tested it and it works (at least my speedtouch still works).
> 
> Great.  Shaohua, where should we go from here?  Do you have more
> concerns with the current patch, or should we ask Andrew to put it
> in -mm?  If you do have concerns, would you like to propose an
> alternate patch that fixes the problem for Grzegorz?
No, the patch is great to me.

Thanks,
Shaohua

