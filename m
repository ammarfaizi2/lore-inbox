Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbTIEUcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTIEU2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:28:50 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:10500 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266036AbTIEU2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:28:33 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AGPGART_MINOR needs <linux/agpgart.h>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 06 Sep 2003 05:28:22 +0900
Message-ID: <87llt3j7yx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes the following alias.

alias char-major-10-AGPGART_MINOR agpgart

Please apply.


 drivers/char/agp/backend.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/char/agp/backend.c~agpgart drivers/char/agp/backend.c
--- linux-2.6.0-test4/drivers/char/agp/backend.c~agpgart	2003-09-06 05:14:07.000000000 +0900
+++ linux-2.6.0-test4-hirofumi/drivers/char/agp/backend.c	2003-09-06 05:14:22.000000000 +0900
@@ -34,6 +34,7 @@
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
 #include <linux/agp_backend.h>
+#include <linux/agpgart.h>
 #include <linux/vmalloc.h>
 #include <asm/io.h>
 #include "agp.h"

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
