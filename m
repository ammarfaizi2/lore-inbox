Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263752AbTCUSjY>; Fri, 21 Mar 2003 13:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263754AbTCUSiS>; Fri, 21 Mar 2003 13:38:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10372
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263752AbTCUShu>; Fri, 21 Mar 2003 13:37:50 -0500
Date: Fri, 21 Mar 2003 19:53:06 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211953.h2LJr63u026097@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from lockd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/lockd/lockd_syms.c linux-2.5.65-ac2/fs/lockd/lockd_syms.c
--- linux-2.5.65/fs/lockd/lockd_syms.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.65-ac2/fs/lockd/lockd_syms.c	2003-03-14 00:52:26.000000000 +0000
@@ -8,7 +8,6 @@
  * Copyright (C) 1997 Olaf Kirch <okir@monad.swb.de>
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 
