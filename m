Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030722AbWLAPeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030722AbWLAPeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030734AbWLAPeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:34:17 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:49420 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1030722AbWLAPeQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:34:16 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] ppc ppc4xx_dma parenthesis fix
Date: Fri, 1 Dec 2006 16:33:50 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011633.50809.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis in DMA_DEC macro code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-ppc/ppc4xx_dma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/include/asm-ppc/ppc4xx_dma.h	2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.34-pre6-b/include/asm-ppc/ppc4xx_dma.h	2006-12-01 11:57:29.000000000 +0100
@@ -137,7 +137,7 @@ extern unsigned long DMA_MODE_WRITE, DMA
 #define DMA_TCE_ENABLE     (1<<(8-DMA_CR_OFFSET))
 #define SET_DMA_TCE(x)     (((x)&0x1)<<(8-DMA_CR_OFFSET))
 
-#define DMA_DEC            (1<<(2)	/* Address Decrement */
+#define DMA_DEC            (1<<(2))	/* Address Decrement */
 #define SET_DMA_DEC(x)     (((x)&0x1)<<2)
 #define GET_DMA_DEC(x)     (((x)&DMA_DEC)>>2)
 


-- 
Regards,

	Mariusz Kozlowski
