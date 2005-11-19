Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVKSERA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVKSERA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVKSEQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:16:59 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:56821
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750891AbVKSEQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:16:58 -0500
Date: Fri, 18 Nov 2005 21:16:58 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 3/12: eCryptfs] Makefile
Message-ID: <20051119041658.GC15747@sshock.rn.byu.edu>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119041130.GA15559@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile for eCryptfs.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+)
--- linux-2.6.15-rc1-mm1/fs/ecryptfs/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.15-rc1-mm1-ecryptfs/fs/ecryptfs/Makefile	2005-11-08 10:43:42.000000000 -0600
@@ -0,0 +1,7 @@
+#
+# Makefile for the Linux 2.6 eCryptfs
+#
+
+obj-$(CONFIG_ECRYPTFS) += ecryptfs.o
+
+ecryptfs-objs := dentry.o file.o inode.o main.o super.o mmap.o crypto.o keystore.o
