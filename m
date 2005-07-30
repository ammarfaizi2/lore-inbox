Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVG3Eyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVG3Eyb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVG3Eyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:54:31 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:26026 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262727AbVG3Eya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:54:30 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Sat, 30 Jul 2005 14:54:17 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com> <42EAF987.7020607@pobox.com>
In-Reply-To: <42EAF987.7020607@pobox.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 23:52:39 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>
>However you did your search, you did it wrong.  The very first two 
>entries I tried had zero uses:
>
>[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_22
>./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_22   0x27e0
>[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_23
>./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_23   0x27e2
>[jgarzik@pretzel linux-2.6]$

Sorry Jeff, excluding "include/linux/pci_ids.h" makes a huge difference :o)

Does roughly 1/3 unused:

63065 2005-07-30 14:51 pci_ids-list
19243 2005-07-30 14:52 pci_ids-not_used

Seem in ballpark?

Thanks,
Grant.
