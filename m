Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVASE6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVASE6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 23:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVASE6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:58:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42768 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261578AbVASE5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:57:14 -0500
Date: Wed, 19 Jan 2005 05:57:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] #if 0 cx88_risc_disasm
Message-ID: <20050119045711.GM1841@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's the unused function cx88_risc_disasm.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

diffstat output:
 drivers/media/video/cx88/cx88-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

This patch was already sent on:
- 10 Nov 2004

--- linux-2.6.10-rc1-mm4-full/drivers/media/video/cx88/cx88-core.c.old	2004-11-10 02:46:36.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/media/video/cx88/cx88-core.c	2004-11-10 02:47:15.000000000 +0100
@@ -462,6 +462,7 @@
 	return incr[risc >> 28] ? incr[risc >> 28] : 1;
 }
 
+#if 0
 void cx88_risc_disasm(struct cx88_core *core,
 		      struct btcx_riscmem *risc)
 {
@@ -479,6 +480,8 @@
 			break;
 	}
 }
+EXPORT_SYMBOL(cx88_risc_disasm);
+#endif
 
 void cx88_sram_channel_dump(struct cx88_core *core,
 			    struct sram_channel *ch)
@@ -1197,8 +1200,6 @@
 EXPORT_SYMBOL(cx88_risc_stopper);
 EXPORT_SYMBOL(cx88_free_buffer);
 
-EXPORT_SYMBOL(cx88_risc_disasm);
-
 EXPORT_SYMBOL(cx88_sram_channels);
 EXPORT_SYMBOL(cx88_sram_channel_setup);
 EXPORT_SYMBOL(cx88_sram_channel_dump);

