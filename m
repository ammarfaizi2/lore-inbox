Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVDLTGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVDLTGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVDLTFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:05:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:50121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262214AbVDLKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:36 -0400
Message-Id: <200504121032.j3CAWT29005605@shell0.pdx.osdl.net>
Subject: [patch 117/198] power/video.txt: update documentation with more systems
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This updates video.txt documentation with information about few more
systems.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Documentation/power/video.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff -puN Documentation/power/video.txt~power-videotxt-update-documentation-with-more-systems Documentation/power/video.txt
--- 25/Documentation/power/video.txt~power-videotxt-update-documentation-with-more-systems	2005-04-12 03:21:31.718314984 -0700
+++ 25-akpm/Documentation/power/video.txt	2005-04-12 03:21:31.721314528 -0700
@@ -32,9 +32,9 @@ There are a few types of systems where v
   acpi_sleep=s3_bios,s3_mode is needed.
 
 (5) radeon systems, where X can soft-boot your video card. You'll need
-  new enough X, and plain text console (no vesafb or radeonfb), see
-  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. Actually you
-  should probably use vbetool (6) instead.
+  a new enough X, and a plain text console (no vesafb or radeonfb). See
+  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html for more information.
+  Alternatively, you should use vbetool (6) instead.
 
 (6) other radeon systems, where vbetool is enough to bring system back
   to life. It needs text console to be working. Do vbetool vbestate
@@ -74,8 +74,9 @@ Acer TM 803			vga=normal, X patches, see
 Acer TM 803LCi			vga=normal, vbetool (6)
 Arima W730a			vbetool needed (6)
 Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
+Asus L3350M (SiS 740)           (6)
 Asus L3800C (Radeon M7)		s3_bios (2) (S1 also works OK)
-Asus M6NE			??? (*)
+Asus M6887Ne			vga=normal, s3_bios (2), use radeon driver instead of fglrx in x.org
 Athlon64 desktop prototype	s3_bios (2)
 Compal CL-50			??? (*)
 Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
@@ -99,16 +100,16 @@ IBM TP A31 / Type 2652-M5G      s3_mode 
 IBM TP R32 / Type 2658-MMG      none (1)
 IBM TP R40 2722B3G		??? (*)
 IBM TP R50p / Type 1832-22U     s3_bios (2)
-IBM TP R51			??? (*)
+IBM TP R51			none (1)
 IBM TP T30	236681A		??? (*)
 IBM TP T40 / Type 2373-MU4      none (1)
 IBM TP T40p			none (1)
 IBM TP R40p			s3_bios (2)
 IBM TP T41p			s3_bios (2), switch to X after resume
-IBM TP T42			??? (*)
+IBM TP T42			s3_bios (2)
 IBM ThinkPad T42p (2373-GTG)	s3_bios (2)
 IBM TP X20			??? (*)
-IBM TP X30			??? (*)
+IBM TP X30			s3_bios (2)
 IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
 IBM Thinkpad X40 Type 2371-7JG  s3_bios,s3_mode (4)
 Medion MD4220			??? (*)
_
