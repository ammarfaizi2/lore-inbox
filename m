Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTISO1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 10:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbTISO1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 10:27:20 -0400
Received: from mail2.uu.nl ([131.211.16.76]:39569 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S261588AbTISO1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 10:27:12 -0400
Subject: [PATCH] 2.6.0-testX: zoran driver documentation fix
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-YmjX2D56M0SfptHHCRJU"
Message-Id: <1063981711.2220.113.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 16:28:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YmjX2D56M0SfptHHCRJU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

the zoran kernel driver is called 'zoran.o' in its CVS (historical
thing, I don't know why), and it's called zr36067.o in the kernel tree.
The documentation in the kernel tree refers to zoran.o, though, which is
(in the kernel tree) the driver for zr36120-based cards, rather than the
driver for zr360x7-based cards.

The attached patch fixes the documentation and makes it refer to
zr36067.o instead. It's against 2.6.0-test4, but should apply cleanly
against the current tree, since the file wasn't modified since then.

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

--=-YmjX2D56M0SfptHHCRJU
Content-Disposition: attachment; filename=zoran-doc.patch
Content-Type: text/plain; name=zoran-doc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test4/Documentation/video4linux/Zoran-old	2003-09-19 16:15:17.000000000 +0200
+++ linux-2.6.0-test4/Documentation/video4linux/Zoran	2003-09-19 16:18:25.000000000 +0200
@@ -28,7 +28,7 @@
 * Philips saa7111 TV decoder
 * Philips saa7185 TV encoder
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-                videocodec, saa7111, saa7185, zr36060, zoran
+                videocodec, saa7111, saa7185, zr36060, zr36067
 Inputs/outputs: Composite and S-video
 Norms: PAL, SECAM (720x576 @ 25 fps), NTSC (720x480 @ 29.97 fps)
 Card number: 7
@@ -39,7 +39,7 @@
 * Brooktree bt819 TV decoder
 * Brooktree bt856 TV encoder
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-                videocodec, bt819, bt856, zr36060, zoran
+                videocodec, bt819, bt856, zr36060, zr36067
 Inputs/outputs: Composite and S-video
 Norms: PAL (720x576 @ 25 fps), NTSC (720x480 @ 29.97 fps)
 Card number: 5
@@ -50,7 +50,7 @@
 * Philips saa7114 TV decoder
 * Analog Devices adv7170 TV encoder
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-                videocodec, saa7114, adv7170, zr36060, zoran
+                videocodec, saa7114, adv7170, zr36060, zr36067
 Inputs/outputs: Composite and S-video
 Norms: PAL (720x576 @ 25 fps), NTSC (720x480 @ 29.97 fps)
 Card number: 6
@@ -61,7 +61,7 @@
 * Philips saa7110a TV decoder
 * Analog Devices adv7176 TV encoder
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-                videocodec, saa7110, adv7175, zr36060, zoran
+                videocodec, saa7110, adv7175, zr36060, zr36067
 Inputs/outputs: Composite, S-video and Internal
 Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
 Card number: 1
@@ -72,7 +72,7 @@
 * Philips saa7110a TV decoder
 * Analog Devices adv7176 TV encoder
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-		videocodec, sa7110, adv7175, zr36060, zoran
+		videocodec, sa7110, adv7175, zr36060, zr36067
 Inputs/outputs: Composite, S-video and Internal
 Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
 Card number: 2
@@ -84,7 +84,7 @@
 * Micronas vpx3220a TV decoder
 * mse3000 TV encoder or Analog Devices adv7176 TV encoder *
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-                videocodec, vpx3220, mse3000/adv7175, zr36050, zr36016, zoran
+                videocodec, vpx3220, mse3000/adv7175, zr36050, zr36016, zr36067
 Inputs/outputs: Composite, S-video and Internal
 Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
 Card number: 0
@@ -96,7 +96,7 @@
 * Micronas vpx3225d/vpx3220a/vpx3216b TV decoder
 * Analog Devices adv7176 TV encoder
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-                videocodec, vpx3220/vpx3224, adv7175, zr36050, zr36016, zoran
+                videocodec, vpx3220/vpx3224, adv7175, zr36050, zr36016, zr36067
 Inputs/outputs: Composite, S-video and Internal
 Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
 Card number: 3
@@ -108,7 +108,7 @@
 * Micronas vpx3225d/vpx3220a/vpx3216b TV decoder
 * Analog Devices adv7176 TV encoder
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-		videocodec, vpx3220/vpx3224, adv7175, zr36050, zr36015, zoran
+		videocodec, vpx3220/vpx3224, adv7175, zr36050, zr36015, zr36067
 Inputs/outputs: Composite, S-video and Internal
 Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
 Card number: 4
@@ -229,16 +229,16 @@
 
 2. How do I get this damn thing to work
 
-Load zoran.o. If it can't autodetect your card, use the card=X insmod
+Load zr36067.o. If it can't autodetect your card, use the card=X insmod
 option with X being the card number as given in the previous section.
 To have more than one card, use card=X1[,X2[,X3,[X4[..]]]]
 
 To automate this, add the following to your /etc/modules.conf:
 
-options zoran card=X1[,X2[,X3[,X4[..]]]]
-alias char-major-81-0 zoran
+options zr36067 card=X1[,X2[,X3[,X4[..]]]]
+alias char-major-81-0 zr36067
 
-One thing to keep in mind is that this doesn't load zoran.o itself yet. It
+One thing to keep in mind is that this doesn't load zr36067.o itself yet. It
 just automates loading. If you start using xawtv, the device won't load on
 some systems, since you're trying to load modules as a user, which is not
 allowed ("permission denied"). A quick workaround is to add 'Load "v4l"' to
@@ -500,7 +500,7 @@
 7. It hangs/crashes/fails/whatevers! Help!
 
 Make sure that the card has its own interrupts (see /proc/interrupts), check
-the output of dmesg at high verbosity (load zoran.o/zr36067.o with debug=2,
+the output of dmesg at high verbosity (load zr36067.o with debug=2,
 load all other modules with debug=1). Check that your mainboard is favorable
 (see question 2) and if not, test the card in another computer. Also see the
 notes given in question 3 and try lowering quality/buffersize/capturesize

--=-YmjX2D56M0SfptHHCRJU--

