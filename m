Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbUBNErU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 23:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUBNErU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 23:47:20 -0500
Received: from fmr04.intel.com ([143.183.121.6]:9370 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264575AbUBNErP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 23:47:15 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1076734010.25353.65.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Feb 2004 23:46:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.3

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.3/acpi-20040116-2.6.3.diff.gz

This will update the following files:

 arch/i386/Kconfig              |    6 +++---
 arch/i386/kernel/acpi/boot.c   |    4 ++++
 arch/i386/kernel/mpparse.c     |   11 ++++++-----
 arch/x86_64/kernel/acpi/boot.c |    5 +++++
 arch/x86_64/kernel/mpparse.c   |   13 +++++++------
 drivers/acpi/Kconfig           |    2 +-
 drivers/acpi/numa.c            |    2 +-
 drivers/acpi/processor.c       |    6 +++---
 8 files changed, 30 insertions(+), 19 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/02/13 1.1603.11.7)
   [ACPI] interrupt over-ride fix from i386 (Maciej W. Rozycki)

<akpm@osdl.org> (04/02/11 1.1500.36.5)
   [PATCH] acpi cpu_has_cpufreq() fix
   
   Call that function rather than evaluating its runtime address...

<len.brown@intel.com> (04/02/11 1.1500.36.4)
   [ACPI] clarify error message in processor.c

<len.brown@intel.com> (04/02/10 1.1603.11.4)
   [ACPI] don't register disabled processors -- it just confuses people

<len.brown@intel.com> (04/02/10 1.1603.11.3)
   [ACPI] delete mention of stale config option ACPI_HT_ONLY

<len.brown@intel.com> (04/02/10 1.1500.36.2)
   [ACPI] NUMA build fix -- NR_MEMBLKS is now NR_NODE_MEMBLKS

<mbligh@aracnet.com> (04/02/10 1.1603.11.1)
   [PATCH] NUMA build fix
   drivers/acpi/numa.c is IA64 only for now -- enforce it.
   (and arch/i386/kernel/srat.c is i386 only for now)

<len.brown@intel.com> (04/02/07 1.1493.1.17)
   [ACPI] nforce2 timer lockup from Maciej W. Rozycki




