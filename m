Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWGCUoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWGCUoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWGCUoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:44:17 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:6833 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751126AbWGCUoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:44:15 -0400
Message-ID: <44A981FF.2080801@oracle.com>
Date: Mon, 03 Jul 2006 13:45:51 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: airlied@linux.ie, lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>
Subject: [UBUNTUPATCH: drm] Allow drm detection of new VIA chipsets
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Short <chuck@maggie>

[UBUNTU: drm] Allow drm detection of new VIA chipsets.

Update pci ids.

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=5195a64a27550a279b2ecaf400066a3823f2d053

Signed-off-by: Chuck Short <zulcss@gmail.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

---
 drivers/char/drm/drm_pciids.h |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2617-g21.orig/drivers/char/drm/drm_pciids.h
+++ linux-2617-g21/drivers/char/drm/drm_pciids.h
@@ -227,6 +227,9 @@
 	{0x1106, 0x3122, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x1106, 0x7205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x1106, 0x3108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x1106, 0x3157, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x1106, 0x3344, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x1106, 0x7204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0, 0, 0}
 
 #define i810_PCI_IDS \



