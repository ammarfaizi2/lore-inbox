Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSGFGLv>; Sat, 6 Jul 2002 02:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317621AbSGFGLu>; Sat, 6 Jul 2002 02:11:50 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:48135 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317620AbSGFGLt>;
	Sat, 6 Jul 2002 02:11:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.5.25 no source for joydump
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jul 2002 16:14:15 +1000
Message-ID: <28763.1025936055@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no source for joydump.  Detected by kbuild 2.5, not detected
by the existing build system.

Index: 25.1/drivers/input/joystick/Makefile
--- 25.1/drivers/input/joystick/Makefile Sat, 06 Jul 2002 13:37:55 +1000 kaos (linux-2.5/V/d/23_Makefile 1.3 444)
+++ 25.1(w)/drivers/input/joystick/Makefile Sat, 06 Jul 2002 16:12:08 +1000 kaos (linux-2.5/V/d/23_Makefile 1.3 444)
@@ -33,7 +33,7 @@ obj-$(CONFIG_JOYSTICK_GF2K)		+= gf2k.o
 obj-$(CONFIG_JOYSTICK_GRIP)		+= grip.o
 obj-$(CONFIG_JOYSTICK_GUILLEMOT)	+= guillemot.o
 obj-$(CONFIG_JOYSTICK_INTERACT)		+= interact.o
-obj-$(CONFIG_JOYSTICK_JOYDUMP)		+= joydump.o
+# obj-$(CONFIG_JOYSTICK_JOYDUMP)		+= joydump.o no source for joydump
 obj-$(CONFIG_JOYSTICK_MAGELLAN)		+= magellan.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o

