Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVAaIcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVAaIcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVAaIcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:32:32 -0500
Received: from fmr16.intel.com ([192.55.52.70]:49281 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261840AbVAaIca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:32:30 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1107160339.18002.44.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Jan 2005 03:32:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/to-marcelo

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.29/acpi-20040326-2.4.29.diff.gz

This will update the following files:

 arch/i386/kernel/pci-irq.c   |    4 ++--
 arch/x86_64/kernel/pci-irq.c |    4 ++--
 drivers/acpi/pci_irq.c       |    4 ++++
 drivers/pci/quirks.c         |   30 +++++-------------------------
 4 files changed, 13 insertions(+), 29 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (05/01/26 1.1499.5.2)
   [ACPI] via interrupt quirk fix from 2.6
   http://bugzilla.kernel.org/show_bug.cgi?id=3319
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com.




