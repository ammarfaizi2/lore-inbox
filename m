Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263311AbTC0RHN>; Thu, 27 Mar 2003 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbTC0RFv>; Thu, 27 Mar 2003 12:05:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54917
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263311AbTC0RFS>; Thu, 27 Mar 2003 12:05:18 -0500
Date: Thu, 27 Mar 2003 18:22:47 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271822.h2RIMlVI019690@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/exec.c does not need __NO_VERSION__
(Christoph Hellwig I think)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/fs/exec.c linux-2.5.66-ac1/fs/exec.c
--- linux-2.5.66-bk3/fs/exec.c	2003-03-27 17:13:35.000000000 +0000
+++ linux-2.5.66-ac1/fs/exec.c	2003-03-22 19:57:38.000000000 +0000
@@ -38,7 +38,6 @@
 #include <linux/binfmts.h>
 #include <linux/swap.h>
 #include <linux/utsname.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
