Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbTGKSXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbTGKSWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:22:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21380
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264973AbTGKSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:02:44 -0400
Date: Fri, 11 Jul 2003 19:16:31 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111816.h6BIGVVP017386@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix wrong printk in nm256 audio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/nm256_audio.c linux-2.5.75-ac1/sound/oss/nm256_audio.c
--- linux-2.5.75/sound/oss/nm256_audio.c	2003-07-10 21:08:52.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/nm256_audio.c	2003-07-11 16:20:34.000000000 +0100
@@ -1105,7 +1105,7 @@
 		printk (KERN_ERR "NM256: This doesn't look to me like the AC97-compatible version.\n");
 		printk (KERN_ERR "       You can force the driver to load by passing in the module\n");
 		printk (KERN_ERR "       parameter:\n");
-		printk (KERN_ERR "              force_ac97 = 1\n");
+		printk (KERN_ERR "              force_load = 1\n");
 		printk (KERN_ERR "\n");
 		printk (KERN_ERR "       More likely, you should be using the appropriate SB-16 or\n");
 		printk (KERN_ERR "       CS4232 driver instead.  (If your BIOS has settings for\n");
