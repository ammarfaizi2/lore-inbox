Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267775AbTBRMx3>; Tue, 18 Feb 2003 07:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTBRMx2>; Tue, 18 Feb 2003 07:53:28 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:57489 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267775AbTBRMx1>; Tue, 18 Feb 2003 07:53:27 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.62]: 3/3: Very small menu cleanup
Date: Tue, 18 Feb 2003 14:00:18 +0100
User-Agent: KMail/1.4.3
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <200302181359.37969.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_IG9IWOBVWQ9PHMRH8WPG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_IG9IWOBVWQ9PHMRH8WPG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


1. Move "JBD (ext3) debugging support" two spaces rightwards

2. Can we please rename "Second extended fs support" to
   "Ext2 fs support" to be conform with:

=09Ext2 extended attributes
=09  Ext2 POSIX Access Control Lists

--------------Boundary-00=_IG9IWOBVWQ9PHMRH8WPG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="menu-fixes.pach"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="menu-fixes.pach"

diff -Naurp linux-2.5.62-vanilla/fs/Kconfig linux-2.5.62-mcp1/fs/Kconfig
--- linux-2.5.62-vanilla/fs/Kconfig	2003-02-10 19:38:43.000000000 +0100
+++ linux-2.5.62-mcp1/fs/Kconfig	2003-02-18 13:43:48.000000000 +0100
@@ -336,7 +336,7 @@ config JBD
 	  you cannot compile this code as a module.
 
 config JBD_DEBUG
-	bool "JBD (ext3) debugging support"
+	bool "  JBD (ext3) debugging support"
 	depends on JBD
 	---help---
 	  If you are using the ext3 journaled file system (or potentially any
@@ -943,7 +943,7 @@ config ROMFS_FS
 	  answer N.
 
 config EXT2_FS
-	tristate "Second extended fs support"
+	tristate "Ext2 fs support"
 	---help---
 	  This is the de facto standard Linux file system (method to organize
 	  files on a storage device) for hard disks.

--------------Boundary-00=_IG9IWOBVWQ9PHMRH8WPG--


