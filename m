Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbUK3B5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUK3B5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUK3B5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:57:18 -0500
Received: from baikonur.stro.at ([213.239.196.228]:22916 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261818AbUK3B5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:14 -0500
Subject: [patch 01/11] Subject: ifdef typos: arch_ppc_platforms_prep_setup.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:09 +0100
Message-ID: <E1CYxGQ-0002f2-SS@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



CONFIG_PREP_PRESIDUAL is mistyped.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/arch/ppc/platforms/prep_setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc/platforms/prep_setup.c~ifdef-arch_ppc_platforms_prep_setup arch/ppc/platforms/prep_setup.c
--- linux-2.6.10-rc2-bk13/arch/ppc/platforms/prep_setup.c~ifdef-arch_ppc_platforms_prep_setup	2004-11-30 02:41:33.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/arch/ppc/platforms/prep_setup.c	2004-11-30 02:41:33.000000000 +0100
@@ -1126,7 +1126,7 @@ prep_init(unsigned long r3, unsigned lon
 		_prep_type = _PREP_Motorola;
 	}
 
-#ifdef CONFIG_PREP_PRESIDUAL
+#ifdef CONFIG_PREP_RESIDUAL
 	/* Switch off all residual data processing if the user requests it */
 	if (strstr(cmd_line, "noresidual") != NULL)
 			res = NULL;
_
