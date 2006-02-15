Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWBOGOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWBOGOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWBOGOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:14:14 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:35424 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1423000AbWBOGOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:14:07 -0500
Message-Id: <20060215061150.499567000.dtor_core@ameritech.net>
References: <20060215060140.243794000.dtor_core@ameritech.net>
Date: Wed, 15 Feb 2006 01:01:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH 6/6] Kill remnants of 98kbd{,-io} and 98spkr
Content-Disposition: inline; filename=kill-pc98-remnants.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Othieno <apgo@patchbomb.org>

Input: kill remnants of 98kbd{,-io} and 98spkr

98kbd{,-io} and 98spkr all went out with PC98 subarch.  Remove stale Makefile
entries that remained.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/Makefile |    1 -
 drivers/input/misc/Makefile     |    1 -
 drivers/input/serio/Makefile    |    1 -
 3 files changed, 3 deletions(-)

Index: work/drivers/input/keyboard/Makefile
===================================================================
--- work.orig/drivers/input/keyboard/Makefile
+++ work/drivers/input/keyboard/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
-obj-$(CONFIG_KEYBOARD_98KBD)		+= 98kbd.o
 obj-$(CONFIG_KEYBOARD_CORGI)		+= corgikbd.o
 obj-$(CONFIG_KEYBOARD_SPITZ)		+= spitzkbd.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
Index: work/drivers/input/misc/Makefile
===================================================================
--- work.orig/drivers/input/misc/Makefile
+++ work/drivers/input/misc/Makefile
@@ -7,7 +7,6 @@
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
-obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
Index: work/drivers/input/serio/Makefile
===================================================================
--- work.orig/drivers/input/serio/Makefile
+++ work/drivers/input/serio/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_SERIO_RPCKBD)	+= rpckbd.o
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
-obj-$(CONFIG_SERIO_98KBD)	+= 98kbd-io.o
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
 obj-$(CONFIG_HIL_MLC)		+= hp_sdc_mlc.o hil_mlc.o

