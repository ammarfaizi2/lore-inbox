Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVGYGTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVGYGTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVGYF5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:23 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:31096 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261714AbVGYFzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:51 -0400
Message-Id: <20050725054532.096182000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 11/24] serio_raw - fix Kconfig help
Content-Disposition: inline; filename=serio-raw-help-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Brown <neilb@cse.unsw.edu.au>

Input: serio_raw - fix Kconfig help

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/serio/Kconfig
===================================================================
--- work.orig/drivers/input/serio/Kconfig
+++ work/drivers/input/serio/Kconfig
@@ -175,7 +175,7 @@ config SERIO_RAW
 	  allocating minor 1 (that historically corresponds to /dev/psaux)
 	  first. To bind this driver to a serio port use sysfs interface:
 
-	      echo -n "serio_raw" > /sys/bus/serio/devices/serioX/driver
+	      echo -n "serio_raw" > /sys/bus/serio/devices/serioX/drvctl
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called serio_raw.

