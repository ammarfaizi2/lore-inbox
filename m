Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSLPE7h>; Sun, 15 Dec 2002 23:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSLPE7h>; Sun, 15 Dec 2002 23:59:37 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:19585 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265222AbSLPE7g>; Sun, 15 Dec 2002 23:59:36 -0500
Message-ID: <3DFD510C.5C535881@verizon.net>
Date: Sun, 15 Dec 2002 20:05:32 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, braam@clusterfs.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.52 fix intermezzo build (trivial)
Content-Type: multipart/mixed;
 boundary="------------7EC42F80D08709A13CB83D74"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [4.64.197.173] at Sun, 15 Dec 2002 23:07:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7EC42F80D08709A13CB83D74
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This allows intermezzo to build in 2.5.52.
Is this OK, Peter?

~Randy
--------------7EC42F80D08709A13CB83D74
Content-Type: text/plain; charset=us-ascii;
 name="intermez-build-2552.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intermez-build-2552.patch"

--- ./fs/intermezzo/Makefile%IMZ	Sun Dec 15 18:08:13 2002
+++ ./fs/intermezzo/Makefile	Sun Dec 15 20:01:06 2002
@@ -5,7 +5,7 @@
 obj-$(CONFIG_INTERMEZZO_FS) += intermezzo.o
 
 intermezzo-objs := cache.o dcache.o dir.o ext_attr.o file.o fileset.o \
-	           inode.o io_daemon.o journal.o journal_ext2.o journal_ext3.o \
+	           inode.o journal.o journal_ext2.o journal_ext3.o \
 	           journal_obdfs.o journal_reiserfs.o journal_tmpfs.o journal_xfs.o \
 	           kml_reint.o kml_unpack.o methods.o presto.o psdev.o replicator.o \
 	           super.o sysctl.o upcall.o vfs.o

--------------7EC42F80D08709A13CB83D74--

