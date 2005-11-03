Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbVKCDnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVKCDnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVKCDnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:43:32 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:7406
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1030310AbVKCDnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:43:31 -0500
Date: Wed, 2 Nov 2005 20:43:54 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 3/12: eCryptfs] Makefile
Message-ID: <20051103034354.GC3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile for eCryptfs.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+)
--- linux-2.6.14-rc5-mm1/fs/ecryptfs/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/fs/ecryptfs/Makefile	2005-11-01 13:48:26.000000000 -0600
@@ -0,0 +1,7 @@
+#
+# Makefile for the Linux 2.6 eCryptfs
+#
+
+obj-$(CONFIG_ECRYPTFS) += ecryptfs.o
+
+ecryptfs-objs := dentry.o file.o inode.o main.o super.o mmap.o crypto.o keystore.o
