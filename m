Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967420AbWLAPby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967420AbWLAPby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967496AbWLAPbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:31:53 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:47884 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967420AbWLAPbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:31:53 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] ppc m48t35 parenthesis fix
Date: Fri, 1 Dec 2006 16:31:27 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011631.27600.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-ppc/m48t35.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/include/asm-ppc/m48t35.h	2003-08-25 13:44:44.000000000 +0200
+++ linux-2.4.34-pre6-b/include/asm-ppc/m48t35.h	2006-12-01 11:57:59.000000000 +0100
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
