Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVEETuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVEETuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVEETuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:50:23 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:14014 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262204AbVEETsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:48:00 -0400
Message-ID: <427A7854.8020403@t-online.de>
Date: Thu, 05 May 2005 21:47:32 +0200
From: Michael Berger <mikeb1@t-online.de>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/bootmem.c: whitespace cleanups
Content-Type: multipart/mixed;
 boundary="------------030603020506010708040603"
X-ID: ZXVkFMZJoeQ51-J-WnBu9Z3Q81s4kOKppcn0wCjMUhAjvF97F91ScR
X-TOI-MSGID: 6724c063-2dcd-40cf-a059-198fdabe0948
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030603020506010708040603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear LKML

Here is a patch with whitespace cleanups for mm/bootmem.c

-- Mischa


--------------030603020506010708040603
Content-Type: text/x-patch;
 name="wspfx-mm_bootmem_c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wspfx-mm_bootmem_c.patch"

[PATCH] mm/bootmem.c: whitespace cleanups

Some whitespace cleanups for mm/bootmem.c.

Signed-off-by: Michael Berger <mikeb1@t-online.de>

---
commit 977cd0ff21ccda7f6b61b1ecbed4dd5384b5801c
tree 0b8ea04402c32ecb8731c7ed5aafdfa7a80027d7
parent b2d84f078a8be40f5ae3b4d2ac001e2a7f45fe4f
author Mischa <mischa@Odin.localdomain> 1115313241 +0200
committer Mischa <mischa@Odin.localdomain> 1115313241 +0200

Index: mm/bootmem.c
===================================================================
--- 173f941991f1b68da820e9926a3b7ebdd3a2c8b9/mm/bootmem.c  (mode:100644 sha1:260e703850d827d81356f64222a8beceb9f19b0c)
+++ 0b8ea04402c32ecb8731c7ed5aafdfa7a80027d7/mm/bootmem.c  (mode:100644 sha1:561988d3c49004a447f5659c150d4fff5b3d6a1a)
@@ -84,7 +84,7 @@
 	 * fully reserved.
 	 */
 	unsigned long sidx = (addr - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long eidx = (addr + size - bdata->node_boot_start + 
+	unsigned long eidx = (addr + size - bdata->node_boot_start +
 							PAGE_SIZE-1)/PAGE_SIZE;
 	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
 
@@ -169,7 +169,7 @@
 	 * We try to allocate bootmem pages above 'goal'
 	 * first, then we try to allocate lower pages.
 	 */
-	if (goal && (goal >= bdata->node_boot_start) && 
+	if (goal && (goal >= bdata->node_boot_start) &&
 	    ((goal >> PAGE_SHIFT) < bdata->node_low_pfn)) {
 		preferred = goal - bdata->node_boot_start;
 
@@ -259,7 +259,7 @@
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long i, count, total = 0;
 	unsigned long idx;
-	unsigned long *map; 
+	unsigned long *map;
 	int gofast = 0;
 
 	BUG_ON(!bdata->node_bootmem_map);


--------------030603020506010708040603--
