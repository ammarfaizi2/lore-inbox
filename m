Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUIXDsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUIXDsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUIXDrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:47:03 -0400
Received: from baikonur.stro.at ([213.239.196.228]:20701 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267165AbUIWUbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:31:52 -0400
Subject: [patch 02/21]  kill KERNEL_VERSION duplicate 	in videocodec.c
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:31:53 +0200
Message-ID: <E1CAaFu-0000tm-3S@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Hi.

Kill KERNEL_VERSION duplicate.
Funny that it insn't even used in here

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/videocodec.c |    5 -----
 1 files changed, 5 deletions(-)

diff -puN drivers/media/video/videocodec.c~remove-unused-include-drivers_media_videocodec drivers/media/video/videocodec.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/videocodec.c~remove-unused-include-drivers_media_videocodec	2004-09-21 20:51:38.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/videocodec.c	2004-09-21 20:51:38.000000000 +0200
@@ -43,11 +43,6 @@
 #include <asm/uaccess.h>
 #endif
 
-#include <linux/version.h>
-#ifndef KERNEL_VERSION
-#define KERNEL_VERSION(a,b,c) ((a)*65536+(b)*256+(c))
-#endif
-
 #include "videocodec.h"
 
 static int debug = 0;
_
