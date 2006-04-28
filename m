Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWD1Jsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWD1Jsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWD1Jsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:48:51 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:45712 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1030349AbWD1Jsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:48:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] kernel/sys.c doesn't need init.h
From: Jes Sorensen <jes@sgi.com>
Date: 28 Apr 2006 05:48:48 -0400
Message-ID: <yq0irouqbcv.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one falls under the cosmetics section. Nothing from
include/linux/init.h is used in kernel/sys.c

Cheers,
Jes

kernel/sys.c doesn't have anything in it relying on linux/init.h -
remove the include.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 kernel/sys.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/kernel/sys.c
===================================================================
--- linux-2.6.orig/kernel/sys.c
+++ linux-2.6/kernel/sys.c
@@ -13,7 +13,6 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/prctl.h>
-#include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
