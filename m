Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135828AbREANk0>; Tue, 1 May 2001 09:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136613AbREANkR>; Tue, 1 May 2001 09:40:17 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:11278 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135828AbREANkI>;
	Tue, 1 May 2001 09:40:08 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: hch@caldera.de, linux-kernel@vger.kernel.org
Subject: [patch] 2.4.4-ac2 freexvfs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 23:39:59 +1000
Message-ID: <30771.988724399@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/Makefile requires that any filesystem which can be compiled as a
module must have O_TARGET set to the directory name.  Against 2.4.4-ac2.

Index: 4.8/fs/freevxfs/Makefile
--- 4.8/fs/freevxfs/Makefile Tue, 01 May 2001 23:35:00 +1000 kaos (linux-2.4/d/e/32_Makefile 1.1 644)
+++ 4.8(w)/fs/freevxfs/Makefile Tue, 01 May 2001 23:38:19 +1000 kaos (linux-2.4/d/e/32_Makefile 1.1 644)
@@ -2,7 +2,7 @@
 # VxFS Makefile
 #
 
-O_TARGET :=	vxfs.o
+O_TARGET :=	freevxfs.o
 
 obj-y :=	vxfs_bmap.o vxfs_fshead.o vxfs_immed.o vxfs_inode.o \
 		vxfs_lookup.o vxfs_olt.o vxfs_subr.o vxfs_super.o

