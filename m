Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263700AbTCUSaO>; Fri, 21 Mar 2003 13:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263704AbTCUS3X>; Fri, 21 Mar 2003 13:29:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60803
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263700AbTCUS27>; Fri, 21 Mar 2003 13:28:59 -0500
Date: Fri, 21 Mar 2003 19:44:13 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211944.h2LJiDBg025929@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: pnpbios doesnt want __NO_VERSION__
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/pnp/pnpbios/proc.c linux-2.5.65-ac2/drivers/pnp/pnpbios/proc.c
--- linux-2.5.65/drivers/pnp/pnpbios/proc.c	2003-02-10 18:38:54.000000000 +0000
+++ linux-2.5.65-ac2/drivers/pnp/pnpbios/proc.c	2003-03-14 00:52:26.000000000 +0000
@@ -19,7 +19,6 @@
  */
 
 //#include <pcmcia/config.h>
-#define __NO_VERSION__
 //#include <pcmcia/k_compat.h>
 
 #include <linux/module.h>
