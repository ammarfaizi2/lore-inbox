Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263767AbTCUTXB>; Fri, 21 Mar 2003 14:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263762AbTCUTV7>; Fri, 21 Mar 2003 14:21:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48772
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263751AbTCUTVF>; Fri, 21 Mar 2003 14:21:05 -0500
Date: Fri, 21 Mar 2003 20:36:21 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212036.h2LKaL8f026407@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: __NO_VERSION__ for ide-lib
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-lib.c linux-2.5.65-ac2/drivers/ide/ide-lib.c
--- linux-2.5.65/drivers/ide/ide-lib.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-lib.c	2003-03-06 23:27:52.000000000 +0000
@@ -1,5 +1,4 @@
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
