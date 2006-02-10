Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWBJK0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWBJK0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWBJK0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:26:44 -0500
Received: from mail13.bluewin.ch ([195.186.18.62]:26310 "EHLO
	mail13.bluewin.ch") by vger.kernel.org with ESMTP id S1751222AbWBJK0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:26:44 -0500
Cc: Arthur Othieno <apgo@patchbomb.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] input: 98kbd{,-io} and 98spkr removal, really.
In-Reply-To: <11395671853420-git-send-email-apgo@patchbomb.org>
X-Mailer: git-send-email
Date: Fri, 10 Feb 2006 05:26:25 -0500
Message-Id: <11395671852402-git-send-email-apgo@patchbomb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Arthur Othieno <apgo@patchbomb.org>
To: apgo@patchbomb.org
Content-Transfer-Encoding: 7BIT
From: Arthur Othieno <apgo@patchbomb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

98kbd{,-io} and 98spkr all went out with PC98 subarch.
Remove stale Makefile entries that remained.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 drivers/input/keyboard/Makefile |    1 -
 drivers/input/misc/Makefile     |    1 -
 drivers/input/serio/Makefile    |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

c35a909838076b3eb593c50a784b2f8604857441
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 6e0afbb..2708167 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
-obj-$(CONFIG_KEYBOARD_98KBD)		+= 98kbd.o
 obj-$(CONFIG_KEYBOARD_CORGI)		+= corgikbd.o
 obj-$(CONFIG_KEYBOARD_SPITZ)		+= spitzkbd.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 184c412..415c491 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -7,7 +7,6 @@
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
-obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 678a859..4155197 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_SERIO_RPCKBD)	+= rpckbd.o
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
-obj-$(CONFIG_SERIO_98KBD)	+= 98kbd-io.o
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
 obj-$(CONFIG_HIL_MLC)		+= hp_sdc_mlc.o hil_mlc.o
-- 
1.1.5


