Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWHJTzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWHJTzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWHJThO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:12945 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932660AbWHJThG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:06 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [107/145] x86_64: Calgary IOMMU: eradicate sole remaining 80 chars per line offender
Message-Id: <20060810193705.7FA9513C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:05 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -86,7 +86,8 @@
 
 #define MAX_NUM_OF_PHBS		8 /* how many PHBs in total? */
 #define MAX_NUM_CHASSIS		8 /* max number of chassis */
-#define MAX_PHB_BUS_NUM		(MAX_NUM_OF_PHBS * MAX_NUM_CHASSIS * 2) /* max dev->bus->number */
+/* MAX_PHB_BUS_NUM is the maximal possible dev->bus->number */
+#define MAX_PHB_BUS_NUM		(MAX_NUM_OF_PHBS * MAX_NUM_CHASSIS * 2)
 #define PHBS_PER_CALGARY	4
 
 /* register offsets in Calgary's internal register space */
