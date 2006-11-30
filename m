Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759217AbWK3JZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217AbWK3JZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759218AbWK3JZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:25:54 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:7429 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759217AbWK3JZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:25:53 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: m48t35 add missing bracket
Date: Thu, 30 Nov 2006 10:25:23 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301025.24042.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-ppc/m48t35.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-ppc/m48t35.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-ppc/m48t35.h	2006-11-30 00:59:27.000000000 +0100
@@ -39,7 +39,7 @@
 #define M48T35_RTC_WATCHDOG_RB         0x03
 #define M48T35_RTC_WATCHDOG_BMB        0x7c
 #define M48T35_RTC_WATCHDOG_WDS        0x80
-#define M48T35_RTC_WATCHDOG_ALL        (M48T35_RTC_WATCHDOG_RB|M48T35_RTC_WATCHDOG_BMB|M48T35_RTC_W
+#define M48T35_RTC_WATCHDOG_ALL        (M48T35_RTC_WATCHDOG_RB|M48T35_RTC_WATCHDOG_BMB|M48T35_RTC_W)
 
 #define M48T35_RTC_CONTROL_WRITE       0x80
 #define M48T35_RTC_CONTROL_READ        0x40


-- 
Regards,

	Mariusz Kozlowski
