Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUDAKl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbUDAKlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:41:15 -0500
Received: from fmr02.intel.com ([192.55.52.25]:26517 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262841AbUDAKlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:41:08 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1080816043.31353.181.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2004 05:40:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040326-2.4.26.diff.gz

This will update the following files:

 arch/i386/kernel/acpi.c      |    4 +++
 arch/i386/kernel/io_apic.c   |    6 ++++-
 arch/x86_64/kernel/io_apic.c |    6 ++++-
 drivers/acpi/bus.c           |    5 ++++
 drivers/acpi/pci_irq.c       |   35 +++++++++++++++++--------------
 include/asm-i386/acpi.h      |    9 -------
 include/asm-i386/system.h    |    5 ----
 7 files changed, 40 insertions(+), 30 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/04/01 1.1063.46.95)
   [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua
Li)
   http://bugme.osdl.org/show_bug.cgi?id=2382

<len.brown@intel.com> (04/04/01 1.1063.46.94)
   [ACPI] PCI bridge interrupt fix (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2409

<len.brown@intel.com> (04/04/01 1.1063.46.93)
   [ACPI] delete extraneous IRQ->pin mappings below IRQ 16
   http://bugzilla.kernel.org/show_bug.cgi?id=2408

<len.brown@intel.com> (04/03/30 1.1063.46.92)
   [ACPI] allow building ACPI w/ CMPXCHG when CONFIG_M386=y
   http://bugzilla.kernel.org/show_bug.cgi?id=2391




