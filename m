Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWFZU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWFZU1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFZU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:27:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23821 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751165AbWFZU1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:27:04 -0400
Date: Mon, 26 Jun 2006 22:27:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: a.zummo@towertech.it
Cc: linux-kernel@vger.kernel.org, Matt LaPlante <webmaster@cyberdogtech.com>
Subject: [2.6 patch] fix a typo in the RTC_CLASS help text
Message-ID: <20060626202703.GB23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo spotted by
Matt LaPlante <webmaster@cyberdogtech.com>.

This patch fixes kernel Bugzilla #6704.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2-full/drivers/rtc/Kconfig.old	2006-06-26 22:07:10.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/rtc/Kconfig	2006-06-26 22:07:31.000000000 +0200
@@ -10,17 +10,17 @@
 config RTC_CLASS
 	tristate "RTC class"
 	depends on EXPERIMENTAL
 	default n
 	select RTC_LIB
 	help
 	  Generic RTC class support. If you say yes here, you will
  	  be allowed to plug one or more RTCs to your system. You will
-	  probably want to enable one of more of the interfaces below.
+	  probably want to enable one or more of the interfaces below.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-class.
 
 config RTC_HCTOSYS
 	bool "Set system time from RTC on startup"
 	depends on RTC_CLASS = y
 	default y
