Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWFRHcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWFRHcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWFRHcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:32:24 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:58843 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932138AbWFRHcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:32:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][14/29] hz-default_1000.patch
Date: Sun, 18 Jun 2006 17:32:12 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1298
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181732.13124.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set HZ to 1000 by default which is a better choice for normal desktops.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/Kconfig.hz |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-ck-dev/kernel/Kconfig.hz
===================================================================
--- linux-ck-dev.orig/kernel/Kconfig.hz	2006-06-18 15:20:13.000000000 +1000
+++ linux-ck-dev/kernel/Kconfig.hz	2006-06-18 15:23:58.000000000 +1000
@@ -4,7 +4,7 @@
 
 choice
 	prompt "Timer frequency"
-	default HZ_250
+	default HZ_1000
 	help
 	 Allows the configuration of the timer frequency. It is customary
 	 to have the timer interrupt run at 1000 HZ but 100 HZ may be more

-- 
-ck
