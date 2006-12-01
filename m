Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936471AbWLAPYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936471AbWLAPYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936501AbWLAPYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:24:46 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:7176 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936471AbWLAPYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:24:45 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] mips/mips64 mv64340 parenthesis fixes
Date: Fri, 1 Dec 2006 16:24:20 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011624.21006.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes parenthesis mv64340 stuff in both mips and mips64 code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-mips/mv64340.h   |    2 +-
 include/asm-mips64/mv64340.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -upr linux-2.4.34-pre6-a/include/asm-mips/mv64340.h linux-2.4.34-pre6-b/include/asm-mips/mv64340.h
--- linux-2.4.34-pre6-a/include/asm-mips/mv64340.h	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.34-pre6-b/include/asm-mips/mv64340.h	2006-12-01 11:56:57.000000000 +0100
@@ -718,7 +718,7 @@
 #define MV64340_ETH_RX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2470 + (port<<10))
 #define MV64340_ETH_TX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2474 + (port<<10))
 #define MV64340_ETH_RX_MINIMAL_FRAME_SIZE_REG(port)                (0x247c + (port<<10))
-#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10)
+#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_0_REG(port)                         (0x248c + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_1_REG(port)                         (0x2490 + (port<<10))
 #define MV64340_ETH_PORT_INTERNAL_ADDR_ERROR_REG(port)             (0x2494 + (port<<10))
diff -upr linux-2.4.34-pre6-a/include/asm-mips64/mv64340.h linux-2.4.34-pre6-b/include/asm-mips64/mv64340.h
--- linux-2.4.34-pre6-a/include/asm-mips64/mv64340.h	2003-08-25 13:44:44.000000000 +0200
+++ linux-2.4.34-pre6-b/include/asm-mips64/mv64340.h	2006-12-01 12:01:03.000000000 +0100
@@ -718,7 +718,7 @@
 #define MV64340_ETH_RX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2470 + (port<<10))
 #define MV64340_ETH_TX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2474 + (port<<10))
 #define MV64340_ETH_RX_MINIMAL_FRAME_SIZE_REG(port)                (0x247c + (port<<10))
-#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10)
+#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_0_REG(port)                         (0x248c + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_1_REG(port)                         (0x2490 + (port<<10))
 #define MV64340_ETH_PORT_INTERNAL_ADDR_ERROR_REG(port)             (0x2494 + (port<<10))


-- 
Regards,

	Mariusz Kozlowski
