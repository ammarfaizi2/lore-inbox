Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbUK3B5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUK3B5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUK3B5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:57:23 -0500
Received: from baikonur.stro.at ([213.239.196.228]:59289 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261819AbUK3B5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:16 -0500
Subject: [patch 02/11] Subject: ifdef typos: arch_ppc_platforms_prep_setup.c -another one
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:13 +0100
Message-ID: <E1CYxGU-0002hi-4R@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Found another typo in the same file :-)

Obvious typo, FB_VGA16 is from Kconfig.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/arch/ppc/platforms/prep_setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc/platforms/prep_setup.c~ifdef-arch_ppc_platforms_prep_setup2 arch/ppc/platforms/prep_setup.c
--- linux-2.6.10-rc2-bk13/arch/ppc/platforms/prep_setup.c~ifdef-arch_ppc_platforms_prep_setup2	2004-11-30 02:41:31.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/arch/ppc/platforms/prep_setup.c	2004-11-30 02:41:31.000000000 +0100
@@ -645,7 +645,7 @@ static void __init prep_init_sound(void)
 static void __init
 prep_init_vesa(void)
 {
-#if     (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
+#if     (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA16_MODULE) || \
 	 defined(CONFIG_FB_VESA))
 	PPC_DEVICE *vgadev = NULL;
 
_
