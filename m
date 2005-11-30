Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVK3F7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVK3F7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVK3F6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:58:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:30875 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751070AbVK3F6q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:58:46 -0500
Cc: grant_lkml@dodo.com.au
Subject: [PATCH] pci_ids.h: remove duplicate entries
In-Reply-To: <11333303173652@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 29 Nov 2005 21:58:37 -0800
Message-Id: <11333303172787@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pci_ids.h: remove duplicate entries

G'day Albert, Andrew,

	commit 4fb80634d30f5e639a92b78c8f215f96a61ba8c7
	Author: Albert Lee <albertcc@tw.ibm.com>
	Date:   Thu May 12 15:49:21 2005 -0400

duplicates symbols already appearing in pci_ids.h, appended patch
removes them again :o)

From: Grant Coady <gcoady@gmail.com>

pci_ids: commit 4fb80634d30f5e639a92b78c8f215f96a61ba8c7 duplicated a
couple existing symbols in pci_ids.h, remove them.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c9d6073fb3cda856132dd544d537679f9715436c
tree ad9bc2f500c71a6ff5012e62bdd3439760b9d829
parent 9632051963cb6e6f7412990f8b962209b9334e13
author Grant Coady <grant_lkml@dodo.com.au> Thu, 24 Nov 2005 20:41:06 +1100
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 29 Nov 2005 21:39:22 -0800

 include/linux/pci_ids.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1e737e2..53e3293 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -387,7 +387,6 @@
 #define PCI_DEVICE_ID_NS_SC1100_SMI	0x0511
 #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
-#define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202
@@ -489,8 +488,6 @@
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
 #define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
 
-#define PCI_DEVICE_ID_AMD_CS5536_IDE	0x209A
-
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001

