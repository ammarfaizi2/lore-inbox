Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTJZQxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTJZQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:53:36 -0500
Received: from m77.net81-65-140.noos.fr ([81.65.140.77]:24745 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263310AbTJZQx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:53:27 -0500
Date: Sun, 26 Oct 2003 17:52:49 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.0-test9] meye driver update
Message-ID: <20031026165249.GV4013@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small patch documents the existence of a forth 'motioneye'
camera plugged into the USB bus, of course unsupported by the
meye driver.

Linus, please apply.

Thanks,

Stelian.

===== Documentation/video4linux/meye.txt 1.7 vs edited =====
--- 1.7/Documentation/video4linux/meye.txt	Fri Aug  1 14:47:51 2003
+++ edited/Documentation/video4linux/meye.txt	Sun Oct 26 15:00:36 2003
@@ -33,6 +33,11 @@
 driver however), but things are not moving very fast (see
 http://r-engine.sourceforge.net/) (PCI vendor/device is 0x10cf/0x2011).
 
+There is a forth model connected on the USB bus in TR1* Vaio laptops.
+This camera is not supported at all by the current driver, in fact
+little information if any is available for this camera
+(USB vendor/device is 0x054c/0x0107).
+
 Driver options:
 ---------------
 
===== drivers/media/video/meye.h 1.10 vs edited =====
--- 1.10/drivers/media/video/meye.h	Tue Sep 30 02:23:29 2003
+++ edited/drivers/media/video/meye.h	Fri Oct 24 21:14:38 2003
@@ -31,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	7
+#define MEYE_DRIVER_MINORVERSION	8
 
 #include <linux/config.h>
 #include <linux/types.h>
-- 
Stelian Pop <stelian@popies.net>
