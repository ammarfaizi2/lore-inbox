Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVCEWnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVCEWnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCEWl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:41:59 -0500
Received: from coderock.org ([193.77.147.115]:28069 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261291AbVCEWlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:41:32 -0500
Subject: [patch 3/4] delete unused file include_asm_arm_hardware_linkup_l1110.h
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:41:21 +0100
Message-Id: <20050305224121.7FF711F202@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-arm/hardware/linkup-l1110.h |   48 -----------------------------
 1 files changed, 48 deletions(-)

diff -L include/asm-arm/hardware/linkup-l1110.h -puN include/asm-arm/hardware/linkup-l1110.h~remove_file-include_asm_arm_hardware_linkup_l1110.h /dev/null
--- kj/include/asm-arm/hardware/linkup-l1110.h
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
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
_
