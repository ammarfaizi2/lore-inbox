Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTDHAKH (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbTDGXYY (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:24:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:897
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263851AbTDGXKc (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:10:32 -0400
Date: Tue, 8 Apr 2003 01:29:24 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080029.h380TOvH009164@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: compatmac is not needed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/fs/nfsd/nfs4xdr.c linux-2.5.67-ac1/fs/nfsd/nfs4xdr.c
--- linux-2.5.67/fs/nfsd/nfs4xdr.c	2003-04-08 00:37:38.000000000 +0100
+++ linux-2.5.67-ac1/fs/nfsd/nfs4xdr.c	2003-04-04 00:03:46.000000000 +0100
@@ -45,7 +45,6 @@
 #include <linux/param.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/compatmac.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/vfs.h>
