Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVAGOJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVAGOJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVAGOG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:06:59 -0500
Received: from [212.20.225.142] ([212.20.225.142]:60990 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261423AbVAGOCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:02:55 -0500
Subject: [PATCH 3/5] WM97xx touch driver AC97 plugin
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-GLOxxhRS0FXrMdysGuSz"
Message-Id: <1105106573.9143.1005.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Jan 2005 14:02:54 +0000
X-OriginalArrivalTime: 07 Jan 2005 14:02:54.0374 (UTC) FILETIME=[954A0C60:01C4F4C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GLOxxhRS0FXrMdysGuSz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch contains changes to Kconfig for building the wm97xx plugin.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>


--=-GLOxxhRS0FXrMdysGuSz
Content-Disposition: attachment; filename=KConfig.diff
Content-Type: text/x-patch; name=KConfig.diff; charset=
Content-Transfer-Encoding: 7bit

--- a/sound/oss/Kconfig	2004-12-24 21:35:24.000000000 +0000
+++ b/sound/oss/Kconfig	2005-01-05 17:16:49.000000000 +0000
@@ -1088,6 +1088,14 @@
 	tristate "AD1980 front/back switch plugin"
 	depends on SOUND_PRIME!=n
 
+config SOUND_WM97XX
+	tristate "WM97xx touch screen controller plugin"
+	depends on SOUND_PRIME!=n
+	help
+	  Say Y or M here if you have a WM9705, WM9712 or WM9713
+	  touchscreen controller. Details on driver parameters can
+	  be found in Documentation/input/wm97xx.txt
+
 config SOUND_SH_DAC_AUDIO
 	tristate "SuperH DAC audio support"
 	depends on SOUND_PRIME!=n && SOUND && CPU_SH3

--=-GLOxxhRS0FXrMdysGuSz--

