Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbUK3B7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbUK3B7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUK3B7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:59:18 -0500
Received: from baikonur.stro.at ([213.239.196.228]:29095 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261927AbUK3B5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:44 -0500
Subject: [patch 11/11] Subject: ifdef typos: sound_isa_es18xx.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:41 +0100
Message-ID: <E1CYxGv-00033J-Tv@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Changed CONFIG_PNP_ to CONFIG_PNP, also fixed a comment related to
another CONFIG_PNP.

Signed-off-by: Domen Puncer <domen@coderock.org>

---

 linux-2.6.10-rc2-bk13-max/sound/isa/es18xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN sound/isa/es18xx.c~ifdef-sound_isa_es18xx sound/isa/es18xx.c
--- linux-2.6.10-rc2-bk13/sound/isa/es18xx.c~ifdef-sound_isa_es18xx	2004-11-30 02:41:48.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/sound/isa/es18xx.c	2004-11-30 02:41:48.000000000 +0100
@@ -1849,7 +1849,7 @@ static int enable[SNDRV_CARDS] = SNDRV_D
 static int isapnp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 #endif
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240,0x260,0x280 */
-#ifndef CONFIG_PNP_
+#ifndef CONFIG_PNP
 static long mpu_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
 #else
 static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
@@ -1988,7 +1988,7 @@ static int __devinit snd_audiodrive_pnp(
 	kfree(cfg);
 	return 0;
 }
-#endif /* CONFIG_PNP_ */
+#endif /* CONFIG_PNP */
 
 static int __devinit snd_audiodrive_probe(int dev, struct pnp_card_link *pcard,
 					  const struct pnp_card_device_id *pid)
_
