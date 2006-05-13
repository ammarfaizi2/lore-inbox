Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWEMDmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWEMDmQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWEMDmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:42:16 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:1780 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S932169AbWEMDmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:42:15 -0400
Date: Fri, 12 May 2006 21:42:18 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 3/13: eCryptfs] Makefile
Message-ID: <20060513034218.GC18631@hellewell.homeip.net>
References: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

Makefile for eCryptfs.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/Makefile	2006-05-12 20:00:25.000000000 -0600
@@ -0,0 +1,7 @@
+#
+# Makefile for the Linux 2.6 eCryptfs
+#
+
+obj-$(CONFIG_ECRYPT_FS) += ecryptfs.o
+
+ecryptfs-objs := dentry.o file.o inode.o main.o super.o mmap.o crypto.o keystore.o debug.o
