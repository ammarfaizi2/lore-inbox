Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUETGO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUETGO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 02:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbUETGO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 02:14:28 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:2512 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S264984AbUETGO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 02:14:26 -0400
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1085033653.12359.484.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 May 2004 02:14:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.27

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.27/acpi-20040326-2.4.27.diff.gz

This will update the following files:

 arch/x86_64/kernel/io_apic.c |    3 ++-
 drivers/acpi/Makefile        |    2 +-
 drivers/acpi/ac.c            |    2 ++
 drivers/acpi/asus_acpi.c     |   24 ++++++++++++++++++++++++
 drivers/acpi/battery.c       |    6 ++++++
 drivers/acpi/bus.c           |   14 +++-----------
 drivers/acpi/button.c        |   17 +++++++++--------
 drivers/acpi/ec.c            |    6 ++++++
 drivers/acpi/fan.c           |    2 ++
 drivers/acpi/power.c         |    2 ++
 drivers/acpi/thermal.c       |   10 ++++++++++
 11 files changed, 67 insertions(+), 21 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/05/18 1.1359.6.21)
   [ACPI] remove /proc files before unloading modules
   from Sau Dan Lee, Zhenyu Wang
   http://bugzilla.kernel.org/show_bug.cgi?id=2705

<len.brown@intel.com> (04/05/18 1.1359.6.20)
   [ACPI] revert button module unload fix (OSDL 2281)
   Cset exclude: len.brown@intel.com|ChangeSet|20040504154434|56458
   Cset exclude: len.brown@intel.com|ChangeSet|20040428081912|57065
   Cset exclude: len.brown@intel.com|ChangeSet|20040428054017|55837

<len.brown@intel.com> (04/05/14 1.1359.6.19)
   [ACPI] delete IOAPIC-disable workaround on x86_64/VIA
   BTW. looks like 2.6 has an IOMMU disable workaround here that may be
needed or VIA in 2.4.
   http://bugme.osdl.org/show_bug.cgi?id=1530




