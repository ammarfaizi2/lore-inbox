Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032287AbWLGPAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032287AbWLGPAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032289AbWLGPAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:00:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2017 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032287AbWLGPAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:00:23 -0500
Date: Thu, 7 Dec 2006 16:00:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cx88/saa7134: remove unused -DHAVE_VIDEO_BUF_DVB
Message-ID: <20061207150028.GJ8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused HAVE_VIDEO_BUF_DVB define.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/drivers/media/video/cx88/Makefile.old	2006-12-07 15:04:11.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/media/video/cx88/Makefile	2006-12-07 15:05:04.000000000 +0100
@@ -13,7 +13,6 @@
 EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
 
-extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
 extra-cflags-$(CONFIG_VIDEO_CX88_VP3054)+= -DHAVE_VP3054_I2C=1
 
 EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)
--- linux-2.6.19-rc6-mm2/drivers/media/video/saa7134/Makefile.old	2006-12-07 15:04:45.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/media/video/saa7134/Makefile	2006-12-07 15:04:58.000000000 +0100
@@ -15,6 +15,3 @@
 EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
 
-extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
-
-EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)

