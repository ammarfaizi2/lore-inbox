Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753226AbWK3JVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbWK3JVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759203AbWK3JVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:21:21 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:13582 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753226AbWK3JVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:21:20 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: matthew@wil.cx, grundler@parisc-linux.org, kyle@parisc-linux.org
Subject: [PATCH] parisc: pdcpat remove extra brackets
Date: Thu, 30 Nov 2006 10:20:50 +0100
User-Agent: KMail/1.9.5
Cc: parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301020.51261.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes extra brackets.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-parisc/pdcpat.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-parisc/pdcpat.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-parisc/pdcpat.h	2006-11-30 01:09:47.000000000 +0100
@@ -250,7 +250,7 @@ struct pdc_pat_pd_addr_map_entry {
 #define PAT_GET_ENTITY(value)	(((value) >> 56) & 0xffUL)
 #define PAT_GET_DVI(value)	(((value) >> 48) & 0xffUL)
 #define PAT_GET_IOC(value)	(((value) >> 40) & 0xffUL)
-#define PAT_GET_MOD_PAGES(value)(((value) & 0xffffffUL)
+#define PAT_GET_MOD_PAGES(value) ((value) & 0xffffffUL)
 
 
 /*
@@ -330,7 +330,7 @@ extern int pdc_pat;     /* arch/parisc/k
 #define PAT_GET_ENTITY(value)	(((value) >> 56) & 0xffUL)
 #define PAT_GET_DVI(value)	(((value) >> 48) & 0xffUL)
 #define PAT_GET_IOC(value)	(((value) >> 40) & 0xffUL)
-#define PAT_GET_MOD_PAGES(value)(((value) & 0xffffffUL)
+#define PAT_GET_MOD_PAGES(value) ((value) & 0xffffffUL)
 
 #endif /* __ASSEMBLY__ */
 


-- 
Regards,

	Mariusz Kozlowski
