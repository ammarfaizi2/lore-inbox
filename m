Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbVINUdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbVINUdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbVINUdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:33:37 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:261 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932769AbVINUdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:33:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=lYUhwcC6P5NCpkUV4wB02c+ARcIgJ9ZtOJrifLGJZsJr5HNGjPl/V6p6er9oSUz2/uzD/RMt9bjMLUSk38D9emxlDB6Ry+8lMvGgDsY1vtjxt8F8Yo82FtGZ81P5peqYsJ1oarv4cxq8w4d8V8mmKPq7OCsLqSh29a8Moc76cAk=
Date: Thu, 15 Sep 2005 00:43:39 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove include/asm-arm/hardware/linkup-l1110.h
Message-ID: <20050914204339.GM19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file (grep "linkup-l1110" didn't find
anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm/hardware/linkup-l1110.h |   48 --------------------------------
 1 files changed, 48 deletions(-)

--- a/include/asm-arm/hardware/linkup-l1110.h	2005-09-15 00:36:56.000000000 +0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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

