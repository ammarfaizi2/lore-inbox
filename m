Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUKFXFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUKFXFO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 18:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUKFXFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 18:05:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39432 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261496AbUKFXFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 18:05:10 -0500
Date: Sun, 7 Nov 2004 00:04:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DIGIEPCA does not depend on SERIAL_NONSTANDARD
Message-ID: <20041106230436.GV1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make the driver better, but it seems to be correct...


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/Kconfig.old	2004-11-06 23:58:48.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/Kconfig	2004-11-06 23:58:57.000000000 +0100
@@ -138,7 +138,7 @@
 
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on BROKEN_ON_SMP
 	---help---
 	  This is a driver for Digi International's Xx, Xeve, and Xem series
 	  of cards which provide multiple serial ports. You would need

