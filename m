Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261722AbSJFR0I>; Sun, 6 Oct 2002 13:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262125AbSJFRZ0>; Sun, 6 Oct 2002 13:25:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59396 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262150AbSJFRYA>; Sun, 6 Oct 2002 13:24:00 -0400
Subject: PATCH: 6x4 font headers
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:20:58 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yF5O-0001ta-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops forgot this in the first patch set

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/include/video/font.h linux.2.5.40-ac5/include/video/font.h
--- linux.2.5.40/include/video/font.h	2002-07-20 20:11:14.000000000 +0100
+++ linux.2.5.40-ac5/include/video/font.h	2002-10-05 23:51:20.000000000 +0100
@@ -28,6 +28,7 @@
 #define SUN8x16_IDX	4
 #define SUN12x22_IDX	5
 #define ACORN8x8_IDX	6
+#define	MINI4x6_IDX	7
 
 extern struct fbcon_font_desc	font_vga_8x8,
 				font_vga_8x16,
@@ -35,7 +36,8 @@
 				font_vga_6x11,
 				font_sun_8x16,
 				font_sun_12x22,
-				font_acorn_8x8;
+				font_acorn_8x8,
+				font_mini_4x6;
 
 /* Find a font with a specific name */
 
