Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263985AbTCUW2N>; Fri, 21 Mar 2003 17:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263688AbTCUW1h>; Fri, 21 Mar 2003 17:27:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40579
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263674AbTCUSLa>; Fri, 21 Mar 2003 13:11:30 -0500
Date: Fri, 21 Mar 2003 19:26:44 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211926.h2LJQiij025765@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fc4 doesnt need __NO_VERSION__ any more
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/fc4/fc_syms.c linux-2.5.65-ac2/drivers/fc4/fc_syms.c
--- linux-2.5.65/drivers/fc4/fc_syms.c	2003-02-10 18:38:50.000000000 +0000
+++ linux-2.5.65-ac2/drivers/fc4/fc_syms.c	2003-03-14 00:52:15.000000000 +0000
@@ -2,7 +2,6 @@
  * We should not even be trying to compile this if we are not doing
  * a module.
  */
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 
