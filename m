Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVDEKKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDEKKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVDEKHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:07:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49564 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261683AbVDEKCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:02:45 -0400
Date: Tue, 5 Apr 2005 12:02:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: power/video.txt: update documentation with more systems
Message-ID: <20050405100223.GA1393@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This updates video.txt documentation with information about few more
systems. Please apply,
								Pavel

--- clean/Documentation/power/video.txt	2005-04-05 10:54:28.000000000 +0200
+++ linux/Documentation/power/video.txt	2005-04-05 10:56:04.000000000 +0200
@@ -32,9 +32,9 @@
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
@@ -74,8 +74,9 @@
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
@@ -99,16 +100,16 @@
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

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
