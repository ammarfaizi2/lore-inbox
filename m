Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUDAKly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbUDAKlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:41:22 -0500
Received: from fmr10.intel.com ([192.55.52.30]:5843 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262840AbUDAKlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:41:08 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1080816042.31349.180.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2004 05:40:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.5/acpi-20040326-2.6.5.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c |    4 ++++
 arch/i386/kernel/io_apic.c   |    6 +++++-
 arch/x86_64/kernel/io_apic.c |    6 +++++-
 drivers/acpi/bus.c           |    5 +++++
 drivers/acpi/pci_irq.c       |   31 +++++++++++++++++--------------
 include/asm-i386/acpi.h      |    9 ---------
 include/asm-i386/system.h    |    5 +----
 7 files changed, 37 insertions(+), 29 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/04/01 1.1608.1.60)
   [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua
Li)
   http://bugme.osdl.org/show_bug.cgi?id=2382

<len.brown@intel.com> (04/04/01 1.1608.1.59)
   [ACPI] PCI bridge interrupt fix (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2409

<len.brown@intel.com> (04/04/01 1.1608.1.58)
   [ACPI] delete extraneous IRQ->pin mappings below IRQ 16
   http://bugzilla.kernel.org/show_bug.cgi?id=2408

<len.brown@intel.com> (04/03/30 1.1608.1.57)
   [ACPI] allow building ACPI w/ CMPXCHG when CONFIG_M386=y
   http://bugzilla.kernel.org/show_bug.cgi?id=2391




