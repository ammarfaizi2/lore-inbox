Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbTIET0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbTIETZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:25:39 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:30625 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265924AbTIETZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:25:23 -0400
Date: Fri, 5 Sep 2003 14:25:11 -0500
From: Dave Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200309051925.h85JPBSL026596@shaggy.austin.ibm.com>
To: torvalds@osdl.org
Subject: [PATCH] New version of jfsutils needed
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply this patch to the Changes file.

A recent change to the 2.6.0 kernel has changed the behavior of opening a
block device with the O_EXCL flag.  This can cause fsck.jfs to fail to
replay the journal when a file system is mounted read-only.

The JFS utilities have been fixed, and it is recommended that any users of
JFS update the utilities to version 1.1.3.

===== Documentation/Changes 1.39 vs edited =====
--- 1.39/Documentation/Changes	Tue Jul 29 15:47:56 2003
+++ edited/Documentation/Changes	Fri Sep  5 13:28:00 2003
@@ -54,7 +54,7 @@
 o  util-linux             2.10o                   # fdformat --version
 o  module-init-tools      0.9.9                   # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
-o  jfsutils               1.0.14                  # fsck.jfs -V
+o  jfsutils               1.1.3                   # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
 o  xfsprogs               2.1.0                   # xfs_db -V
 o  pcmcia-cs              3.1.21                  # cardmgr -V
