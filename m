Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUK3Ci2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUK3Ci2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUK3B7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:59:41 -0500
Received: from baikonur.stro.at ([213.239.196.228]:43928 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261820AbUK3B5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:40 -0500
Subject: [patch 10/11] Subject: ifdef typos: sound_isa_cs423x_cs4231_lib.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:38 +0100
Message-ID: <E1CYxGs-00031G-Lm@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Funny typo.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/sound/isa/cs423x/cs4231_lib.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN sound/isa/cs423x/cs4231_lib.c~ifdef-sound_isa_cs423x_cs4231_lib sound/isa/cs423x/cs4231_lib.c
--- linux-2.6.10-rc2-bk13/sound/isa/cs423x/cs4231_lib.c~ifdef-sound_isa_cs423x_cs4231_lib	2004-11-30 02:41:46.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/sound/isa/cs423x/cs4231_lib.c	2004-11-30 02:41:46.000000000 +0100
@@ -694,7 +694,7 @@ static void snd_cs4231_init(cs4231_t *ch
 
 	snd_cs4231_mce_down(chip);
 
-#ifdef SNDRV_DEBUGq_MCE
+#ifdef SNDRV_DEBUG_MCE
 	snd_printk("init: (1)\n");
 #endif
 	snd_cs4231_mce_up(chip);
_
