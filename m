Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUEKQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUEKQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbUEKQya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:54:30 -0400
Received: from fmr02.intel.com ([192.55.52.25]:17625 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264882AbUEKQs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:48:29 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1084294082.12353.104.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 May 2004 12:48:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.6

	This handles the IRQ15 IDE issue we exposed just as
	2.6.6 closed.  It also handles a similar mouse issue.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.6/acpi-20040326-2.6.6.diff.gz

This will update the following files:

 drivers/acpi/pci_link.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/05/10 1.1618)
   [ACPI] handle _CRS outside _PRS -- even when non-zero
   avoid sharing IRQ12
   http://bugzilla.kernel.org/show_bug.cgi?id=2665




