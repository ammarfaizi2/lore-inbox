Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263671AbTCURZu>; Fri, 21 Mar 2003 12:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263672AbTCURZu>; Fri, 21 Mar 2003 12:25:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11395
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S263671AbTCURZt>; Fri, 21 Mar 2003 12:25:49 -0500
Date: Fri, 21 Mar 2003 18:41:02 GMT
From: Alan Cox <alan@hraefn.swansea.linux.org.uk>
Message-Id: <200303211841.h2LIf2xd025115@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Remove NO_VERSION from S390x exec32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/s390x/kernel/exec32.c linux-2.5.65-ac2/arch/s390x/kernel/exec32.c
--- linux-2.5.65/arch/s390x/kernel/exec32.c	2003-03-06 17:04:25.000000000 +0000
+++ linux-2.5.65-ac2/arch/s390x/kernel/exec32.c	2003-03-14 00:52:15.000000000 +0000
@@ -21,7 +21,6 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/binfmts.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <asm/uaccess.h>
