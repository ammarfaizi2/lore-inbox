Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422995AbWBOGPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422995AbWBOGPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422997AbWBOGOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:14:11 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:52057 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1422995AbWBOGOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:14:06 -0500
Message-Id: <20060215061149.926289000.dtor_core@ameritech.net>
References: <20060215060140.243794000.dtor_core@ameritech.net>
Date: Wed, 15 Feb 2006 01:01:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH 1/6] ixp4xx-beeper: fix compile error
Content-Disposition: inline; filename=ixp4xx-beeper-compile-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alessandro Zummo <alessandro.zummo@towertech.it>

Input: ixp4xx-beeper - fix compile error

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/ixp4xx-beeper.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/misc/ixp4xx-beeper.c
===================================================================
--- work.orig/drivers/input/misc/ixp4xx-beeper.c
+++ work/drivers/input/misc/ixp4xx-beeper.c
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <asm/hardware.h>
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");

