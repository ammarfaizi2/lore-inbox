Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759139AbWK3Ijs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759139AbWK3Ijs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759152AbWK3Ijs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:39:48 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:41220 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759139AbWK3Ijr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:39:47 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: nico@cam.org
Subject: [PATCH] net: smc91x add missing bracket
Date: Thu, 30 Nov 2006 09:39:18 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300939.18252.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/net/smc91x.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/drivers/net/smc91x.h	2006-11-28 12:16:43.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/net/smc91x.h	2006-11-30 00:55:12.000000000 +0100
@@ -238,7 +238,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #define SMC_CAN_USE_16BIT	1
 #define SMC_CAN_USE_32BIT	0
 
-#define SMC_inb(a, r)		inb((u32)a) + (r))
+#define SMC_inb(a, r)		inb(((u32)a) + (r))
 #define SMC_inw(a, r)		inw(((u32)a) + (r))
 #define SMC_outb(v, a, r)	outb(v, ((u32)a) + (r))
 #define SMC_outw(v, a, r)	outw(v, ((u32)a) + (r))


-- 
Regards,

	Mariusz Kozlowski
