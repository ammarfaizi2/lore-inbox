Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVFTWUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVFTWUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVFTWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:10:09 -0400
Received: from coderock.org ([193.77.147.115]:55959 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261681AbVFTVtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:49:53 -0400
Message-Id: <20050620214925.670530000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:49:26 +0200
From: domen@coderock.org
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 3/4] delete include/asm-arm/hardware/linkup-l1110.h
Content-Disposition: inline; filename=remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---
 linkup-l1110.h |   48 ------------------------------------------------
 1 files changed, 48 deletions(-)

Index: quilt/include/asm-arm/hardware/linkup-l1110.h
===================================================================
--- quilt.orig/include/asm-arm/hardware/linkup-l1110.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
-*
-* Definitions for H3600 Handheld Computer
-*
-* Copyright 2001 Compaq Computer Corporation.
-*
-* Use consistent with the GNU GPL is permitted,
-* provided that this copyright notice is
-* preserved in its entirety in all copies and derived works.
-*
-* COMPAQ COMPUTER CORPORATION MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
-* AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
-* FITNESS FOR ANY PARTICULAR PURPOSE.
-*
-* Author: Jamey Hicks.
-*
-*/
-
-/* LinkUp Systems PCCard/CompactFlash Interface for SA-1100 */
-
-/* PC Card Status Register */
-#define LINKUP_PRS_S1	(1 << 0) /* voltage control bits S1-S4 */
-#define LINKUP_PRS_S2	(1 << 1)
-#define LINKUP_PRS_S3	(1 << 2)
-#define LINKUP_PRS_S4	(1 << 3)
-#define LINKUP_PRS_BVD1	(1 << 4)
-#define LINKUP_PRS_BVD2	(1 << 5)
-#define LINKUP_PRS_VS1	(1 << 6)
-#define LINKUP_PRS_VS2	(1 << 7)
-#define LINKUP_PRS_RDY	(1 << 8)
-#define LINKUP_PRS_CD1	(1 << 9)
-#define LINKUP_PRS_CD2	(1 << 10)
-
-/* PC Card Command Register */
-#define LINKUP_PRC_S1	(1 << 0)
-#define LINKUP_PRC_S2	(1 << 1)
-#define LINKUP_PRC_S3	(1 << 2)
-#define LINKUP_PRC_S4	(1 << 3)
-#define LINKUP_PRC_RESET (1 << 4)
-#define LINKUP_PRC_APOE	(1 << 5) /* Auto Power Off Enable: clears S1-S4 when either nCD goes high */
-#define LINKUP_PRC_CFE	(1 << 6) /* CompactFlash mode Enable: addresses A[10:0] only, A[25:11] high */
-#define LINKUP_PRC_SOE	(1 << 7) /* signal output driver enable */
-#define LINKUP_PRC_SSP	(1 << 8) /* sock select polarity: 0 for socket 0, 1 for socket 1 */
-#define LINKUP_PRC_MBZ	(1 << 15) /* must be zero */
-
-struct linkup_l1110 {
-	volatile short prc;
-};

--
