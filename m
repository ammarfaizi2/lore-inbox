Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbULAVua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbULAVua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbULAVua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:50:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62994 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261451AbULAVuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:50:16 -0500
Date: Wed, 1 Dec 2004 22:50:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Laufer <paul@laufernet.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS sb_card.c: no need to include mca.h
Message-ID: <20041201215012.GW2650@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any reason why this file includes mca.h .


diffstat output:
 sound/oss/sb_card.c |    3 ---
 1 files changed, 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

