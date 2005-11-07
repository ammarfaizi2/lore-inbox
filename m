Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbVKGUDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbVKGUDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbVKGUDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:03:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26130 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965312AbVKGUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:03:42 -0500
Date: Mon, 7 Nov 2005 21:03:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/drivers/vx/vx_hwdep.c should #include <linux/vmalloc.h>
Message-ID: <20051107200341.GI3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for always getting the vmalloc()/vfree() prototypes.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-mm1-full/sound/drivers/vx/vx_hwdep.c.old	2005-11-07 18:48:50.000000000 +0100
+++ linux-2.6.14-mm1-full/sound/drivers/vx/vx_hwdep.c	2005-11-07 18:49:04.000000000 +0100
@@ -23,6 +23,7 @@
 #include <sound/driver.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/vmalloc.h>
 #include <sound/core.h>
 #include <sound/hwdep.h>
 #include <sound/vx_core.h>

