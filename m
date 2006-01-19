Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWASCMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWASCMM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 21:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbWASCMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 21:12:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17418 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161158AbWASCLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 21:11:51 -0500
Date: Thu, 19 Jan 2006 03:11:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] schedule SHAPER for removal
Message-ID: <20060119021150.GC19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 13 Jan 2006

--- linux-2.6.15-mm3-full/Documentation/feature-removal-schedule.txt.old	2006-01-13 15:02:15.000000000 +0100
+++ linux-2.6.15-mm3-full/Documentation/feature-removal-schedule.txt	2006-01-13 15:06:19.000000000 +0100
@@ -164,0 +165,6 @@
+---------------------------
+
+What:   Traffic Shaper (CONFIG_SHAPER)
+When:   July 2006
+Why:    obsoleted by the code in net/sched/
+Who:    Adrian Bunk <bunk@stusta.de
--- linux-2.6.15-mm3-full/drivers/net/Kconfig.old	2006-01-13 15:06:34.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/net/Kconfig	2006-01-13 15:06:49.000000000 +0100
@@ -2663,7 +2663,7 @@
 	  "SCSI generic support".
 
 config SHAPER
-	tristate "Traffic Shaper (EXPERIMENTAL)"
+	tristate "Traffic Shaper (OBSOLETE)"
 	depends on EXPERIMENTAL
 	---help---
 	  The traffic shaper is a virtual network device that allows you to

