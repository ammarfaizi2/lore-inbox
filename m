Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTLQOre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 09:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbTLQOqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 09:46:31 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:30668 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S264425AbTLQOpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 09:45:07 -0500
Subject: [PATCH 2.4] Wolfson AC97 touch screen driver - build
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-rKei0EDCtnKaSzZrVMHh"
Message-Id: <1071672303.23686.2640.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 17 Dec 2003 14:45:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rKei0EDCtnKaSzZrVMHh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch removes the battery monitor text from the kernel build
configuration. The battery monitor will eventually be a separate driver.

Patch is against 2.4.24-pre1

Liam 

--=-rKei0EDCtnKaSzZrVMHh
Content-Disposition: attachment; filename=wm97xx-build.diff
Content-Type: text/x-patch; name=wm97xx-build.diff; charset=
Content-Transfer-Encoding: 7bit

diff -urN a/drivers/sound/Config.in b/drivers/sound/Config.in
--- a/drivers/sound/Config.in	2003-11-28 18:26:20.000000000 +0000
+++ b/drivers/sound/Config.in	2003-12-17 14:05:40.000000000 +0000
@@ -234,7 +234,7 @@
 
 dep_tristate '  AD1980 front/back switch plugin' CONFIG_SOUND_AD1980 $CONFIG_SOUND 
 
-dep_tristate '  Wolfson Touchscreen/BMON plugin' CONFIG_SOUND_WM97XX $CONFIG_SOUND 
+dep_tristate '  Wolfson Touchscreen plugin' CONFIG_SOUND_WM97XX $CONFIG_SOUND 
 
 # A cross directory dependence. The sound modules will need gameport.o compiled in,
 # but it resides in the drivers/char/joystick directory. This define_tristate takes

--=-rKei0EDCtnKaSzZrVMHh--

