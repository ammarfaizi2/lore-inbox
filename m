Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUIISA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUIISA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUIIR5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:57:05 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:22671 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266505AbUIIRlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:41:20 -0400
Subject: [patch 1/1] uml-update-2.6.8-finish
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Wed, 08 Sep 2004 19:38:55 +0200
Message-Id: <20040908173855.68F518D0B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some updates for API changes in 2.6.8 which were not included in the original
UML patch; these fixes were detected by some warnings, so I probably missed some more
ones.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h |    2 ++
 1 files changed, 2 insertions(+)

diff -puN include/asm-um/dma-mapping.h~uml-update-2.6.8-finish include/asm-um/dma-mapping.h
--- uml-linux-2.6.8.1/include/asm-um/dma-mapping.h~uml-update-2.6.8-finish	2004-09-07 15:17:57.593456048 +0200
+++ uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h	2004-09-07 15:17:57.595455744 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
+#include <asm/scatterlist.h>
+
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
_
