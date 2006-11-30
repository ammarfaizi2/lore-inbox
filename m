Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759209AbWK3JQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759209AbWK3JQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759210AbWK3JQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:16:59 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:52744 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759209AbWK3JQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:16:58 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: ralf@linux-mips.org
Subject: [PATCH] mips: klconfig add missing bracket
Date: Thu, 30 Nov 2006 10:16:29 +0100
User-Agent: KMail/1.9.5
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301016.29505.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing bracket.

 include/asm-mips/sn/klconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-mips/sn/klconfig.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-mips/sn/klconfig.h	2006-11-30 00:58:32.000000000 +0100
@@ -176,7 +176,7 @@ typedef struct kl_config_hdr {
 /* --- New Macros for the changed kl_config_hdr_t structure --- */
 
 #define PTR_CH_MALLOC_HDR(_k)   ((klc_malloc_hdr_t *)\
-			(unsigned long)_k + (_k->ch_malloc_hdr_off)))
+			((unsigned long)_k + (_k->ch_malloc_hdr_off)))
 
 #define KL_CONFIG_CH_MALLOC_HDR(_n)   PTR_CH_MALLOC_HDR(KL_CONFIG_HDR(_n))
 


-- 
Regards,

	Mariusz Kozlowski
