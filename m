Return-Path: <linux-kernel-owner+w=401wt.eu-S1754657AbWLRV65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbWLRV65 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbWLRV64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:58:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51697 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbWLRV64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:58:56 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 16:54:53 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Add a new section to CodingStyle, promoting
 include/linux/kernel.h.
In-Reply-To: <20061218215002.GL7280@harddisk-recovery.com>
Message-ID: <Pine.LNX.4.64.0612181652140.8141@localhost.localdomain>
References: <Pine.LNX.4.64.0612181238210.27907@localhost.localdomain>
 <20061218215002.GL7280@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006, Erik Mouw wrote:

> On Mon, Dec 18, 2006 at 12:43:35PM -0500, Robert P. J. Day wrote:
> >   Add a new section to the CodingStyle file, encouraging people not to
> > re-invent available kernel macros such as ARRAY_SIZE(),
> > FIELD_SIZEOF(), min() and max(), among others.
>
> Good stuff. Could you also mention the printk() KERN_ALERT etc.
> levels? I've seen quite some people using "<1>" on the kernelnewbies
> list.

they may be using it on that list, but there's very little of that in
the kernel source itself.  this is the only example i found:

$ grep -r '<[0-7]>' * | grep printk
arch/ppc/syslib/m8260_pci_erratum9.c:   printk("<4>Using IDMA%d for MPC8260 device erratum PCI 9 workaround\n",

maybe i'll submit a patch to clean that one up.

rday
