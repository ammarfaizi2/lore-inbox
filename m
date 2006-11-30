Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759144AbWK3IgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759144AbWK3IgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759152AbWK3IgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:36:09 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:40196 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759136AbWK3IgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:36:07 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: maintainers@chelsio.com
Subject: [PATCH] net: chelsio add missing bracket
Date: Thu, 30 Nov 2006 09:35:37 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300935.37796.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/net/chelsio/suni1x10gexp_regs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/drivers/net/chelsio/suni1x10gexp_regs.h	2006-11-28 12:16:42.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/net/chelsio/suni1x10gexp_regs.h	2006-11-30 00:54:28.000000000 +0100
@@ -76,7 +76,7 @@
 #define mSUNI1x10GEXP_REG_RXXG_EXACT_MATCH_ADDR_LOW(filterId) (0x204A + mSUNI1x10GEXP_MAC_FILTER_OFFSET(filterId))
 #define mSUNI1x10GEXP_REG_RXXG_EXACT_MATCH_ADDR_MID(filterId) (0x204B + mSUNI1x10GEXP_MAC_FILTER_OFFSET(filterId))
 #define mSUNI1x10GEXP_REG_RXXG_EXACT_MATCH_ADDR_HIGH(filterId)(0x204C + mSUNI1x10GEXP_MAC_FILTER_OFFSET(filterId))
-#define mSUNI1x10GEXP_REG_RXXG_EXACT_MATCH_VID(filterId)      (0x2062 + mSUNI1x10GEXP_MAC_VID_FILTER_OFFSET(filterId)
+#define mSUNI1x10GEXP_REG_RXXG_EXACT_MATCH_VID(filterId)      (0x2062 + mSUNI1x10GEXP_MAC_VID_FILTER_OFFSET(filterId))
 #define SUNI1x10GEXP_REG_RXXG_EXACT_MATCH_ADDR_0_LOW                     0x204A
 #define SUNI1x10GEXP_REG_RXXG_EXACT_MATCH_ADDR_0_MID                     0x204B
 #define SUNI1x10GEXP_REG_RXXG_EXACT_MATCH_ADDR_0_HIGH                    0x204C


-- 
Regards,

	Mariusz Kozlowski
