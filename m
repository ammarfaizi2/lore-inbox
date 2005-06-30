Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVF3AVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVF3AVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVF3AVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:21:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262753AbVF3AUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:20:51 -0400
Date: Wed, 29 Jun 2005 17:20:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Linux 2.6.12.2
Message-ID: <20050630002046.GQ9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.12.2 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.12.1 and 2.6.12.2, as it is small enough to do so.

The updated 2.6.12.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.12.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

----------

 Makefile                       |    2 -
 drivers/acpi/pci_irq.c         |    1 
 drivers/net/e1000/e1000_main.c |    1 
 drivers/pci/pci-driver.c       |    2 -
 drivers/scsi/qla2xxx/qla_os.c  |   55 ++++++++++++++++++++---------------------
 include/asm-i386/string.h      |   32 ++++++++++++++++-------
 mm/memory.c                    |    2 -
 net/netlink/af_netlink.c       |   11 +++++---
 8 files changed, 63 insertions(+), 43 deletions(-)

Summary of changes from v2.6.12.1 to v2.6.12.2
==============================================

Andrew Vasquez:
  qla2xxx: Pull-down scsi-host-addition to follow board initialization.

Chris Wright:
  Linux 2.6.12.2

David S. Miller:
  Fix two socket hashing bugs.

Hugh Dickins:
  fix remap_pte_range BUG

Linus Torvalds:
  ACPI: Make sure we call acpi_register_gsi() even for default PCI interrupt assignment
  Add "memory" clobbers to the x86 inline asm of strncmp and friends

Mika Kukkonen:
  Fix typo in drivers/pci/pci-driver.c

Mitch Williams:
  e1000: fix spinlock bug

