Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVAYHtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVAYHtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVAYHtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:49:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17415 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261860AbVAYHtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:49:01 -0500
Date: Tue, 25 Jan 2005 08:48:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Laufer <paul@laufernet.com>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS sb_card.c: no need to include mca.h
Message-ID: <20050125074857.GD3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any reason why this file includes mca.h .
Paul Laufer already ACK'ed this patch.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 Dec 2004

--- linux-2.6.10-rc2-mm4-full/sound/oss/sb_card.c.old	2004-12-01 08:17:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/sb_card.c	2004-12-01 08:17:28.000000000 +0100
@@ -26,9 +26,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
-#ifdef CONFIG_MCA
-#include <linux/mca.h>
-#endif /* CONFIG_MCA */
 #include "sound_config.h"
 #include "sb_mixer.h"
 #include "sb.h"

