Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271723AbTGROvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbTGROst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:48:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28549
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271761AbTGROJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:09:28 -0400
Date: Fri, 18 Jul 2003 15:23:49 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181423.h6IENnAG017800@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: remove a now false comment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Frank Cusack)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/fs/nfs/nfs3xdr.c linux-2.6.0-test1-ac2/fs/nfs/nfs3xdr.c
--- linux-2.6.0-test1/fs/nfs/nfs3xdr.c	2003-07-10 21:15:41.000000000 +0100
+++ linux-2.6.0-test1-ac2/fs/nfs/nfs3xdr.c	2003-07-16 18:32:16.000000000 +0100
@@ -124,8 +124,6 @@
 
 /*
  * Encode/decode time.
- * Since the VFS doesn't care for fractional times, we ignore the
- * nanosecond field.
  */
 static inline u32 *
 xdr_encode_time3(u32 *p, struct timespec *timep)
