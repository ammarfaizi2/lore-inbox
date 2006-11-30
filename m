Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759206AbWK3JNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759206AbWK3JNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759207AbWK3JNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:13:49 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:51722 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759206AbWK3JNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:13:47 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: gerg@uclinux.org
Subject: [PATCH] m68knommu: scatterlist add missing bracket
Date: Thu, 30 Nov 2006 10:13:17 +0100
User-Agent: KMail/1.9.5
Cc: uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301013.17991.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-m68knommu/scatterlist.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-m68knommu/scatterlist.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-m68knommu/scatterlist.h	2006-11-30 00:57:24.000000000 +0100
@@ -10,7 +10,7 @@ struct scatterlist {
 	unsigned int	length;
 };
 
-#define sg_address(sg) (page_address((sg)->page) + (sg)->offset
+#define sg_address(sg) (page_address((sg)->page) + (sg)->offset)
 #define sg_dma_address(sg)      ((sg)->dma_address)
 #define sg_dma_len(sg)          ((sg)->length)
 


-- 
Regards,

	Mariusz Kozlowski
