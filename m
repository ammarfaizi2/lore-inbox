Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUFRHdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUFRHdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 03:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUFRHdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 03:33:16 -0400
Received: from fmr99.intel.com ([192.55.52.32]:52939 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S265029AbUFRHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 03:33:13 -0400
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1087540935.4488.214.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Jun 2004 03:32:49 -0400
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

 arch/i386/kernel/acpi.c      |    5 +++
 arch/i386/kernel/mpparse.c   |   18 ++++++++++-
 arch/x86_64/kernel/mpparse.c |    1 
 drivers/acpi/asus_acpi.c     |    4 +-
 drivers/acpi/pci_link.c      |   22 +------------
 drivers/acpi/pci_root.c      |   49 ++++++++++++++++++++++++++++++-
 drivers/acpi/thermal.c       |    7 ++++
 7 files changed, 82 insertions(+), 24 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/06/18 1.1359.6.28)
   [ACPI] handle SCI override to nth IOAPIC
   http://bugzilla.kernel.org/show_bug.cgi?id=2835

<len.brown@intel.com> (04/06/18 1.1359.6.27)
   [ACPI] fix 2.4.27-pre3 IRQ override regression
   due to dynamically allocated mp_irqs[].
   http://bugzilla.kernel.org/show_bug.cgi?id=2834

<len.brown@intel.com> (04/06/18 1.1359.6.26)
   [ACPI] avoid spurious interrupts on VIA
   http://bugzilla.kernel.org/show_bug.cgi?id=2243

<len.brown@intel.com> (04/06/18 1.1359.6.25)
   [ACPI] fix passive cooling mode indicator (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=1770

<len.brown@intel.com> (04/06/17 1.1359.6.24)
   [ACPI] PCI bus numbering workaround for ServerWorks
   from David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=1662

<sziwan@hell.org.pl> (04/06/03 1.1359.6.23)
   [PATCH] acpi4asus trivial sync with 2.6 (Karol 'sziwan' Kozimor)




