Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbTCUVdY>; Fri, 21 Mar 2003 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263775AbTCUVcH>; Fri, 21 Mar 2003 16:32:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8836
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263749AbTCUShP>; Fri, 21 Mar 2003 13:37:15 -0500
Date: Fri, 21 Mar 2003 19:52:30 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211952.h2LJqUea026085@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from intermezzo #2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/sysctl.c linux-2.5.65-ac2/fs/intermezzo/sysctl.c
--- linux-2.5.65/fs/intermezzo/sysctl.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/sysctl.c	2003-03-14 00:52:26.000000000 +0000
@@ -21,7 +21,6 @@
  *  Sysctrl entries for Intermezzo!
  */
 
-#define __NO_VERSION__
 #include <linux/config.h> /* for CONFIG_PROC_FS */
 #include <linux/module.h>
 #include <linux/sched.h>
