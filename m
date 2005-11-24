Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbVKXBki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVKXBki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 20:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVKXBki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 20:40:38 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:49032 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932610AbVKXBkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 20:40:37 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] pci_ids.h: remove duplicate entries
Date: Thu, 24 Nov 2005 12:40:28 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <q06ao1hpt9briinvo7om1s99s0t071vk32@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Albert, Andrew,

	commit 4fb80634d30f5e639a92b78c8f215f96a61ba8c7
	Author: Albert Lee <albertcc@tw.ibm.com>
	Date:   Thu May 12 15:49:21 2005 -0400

duplicates symbols already appearing in pci_ids.h, appended patch 
removes them again :o)  

Cheers,
Grant.

From: Grant Coady <gcoady@gmail.com>

pci_ids: commit 4fb80634d30f5e639a92b78c8f215f96a61ba8c7 duplicated a 
couple existing symbols in pci_ids.h, remove them.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 pci_ids.h |    3 ---
 1 files changed, 3 deletions(-)

--- linux-2.6.15-rc2-mm1a/include/linux/pci_ids.h~	2005-11-24 07:51:24.000000000 +1100
+++ linux-2.6.15-rc2-mm1a/include/linux/pci_ids.h	2005-11-24 12:27:58.000000000 +1100
@@ -391,7 +391,6 @@
 #define PCI_DEVICE_ID_NS_SC1100_SMI	0x0511
 #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
-#define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202
@@ -501,8 +500,6 @@
 #define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
 #define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
 
-#define PCI_DEVICE_ID_AMD_CS5536_IDE	0x209A
-
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001
