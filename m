Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUHaN1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUHaN1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaN1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:27:02 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:54799 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268480AbUHaNXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:23:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: document fix/update
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 31 Aug 2004 22:23:11 +0900
Message-ID: <87eklnqw5c.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/Kconfig |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff -puN fs/Kconfig~fat_doc-fixes fs/Kconfig
--- linux-2.6.9-rc1/fs/Kconfig~fat_doc-fixes	2004-08-28 23:14:51.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/Kconfig	2004-08-28 23:14:51.000000000 +0900
@@ -650,18 +650,21 @@ config FAT_DEFAULT_CODEPAGE
 	default 437
 	help
 	  This option should be set to the codepage of your FAT filesystems.
-	  It can be overridden with the 'codepage' mount option.
+	  It can be overridden with the "codepage" mount option.
+	  See <file:Documentation/filesystems/vfat.txt> for more information.
 
 config FAT_DEFAULT_IOCHARSET
 	string "Default iocharset for FAT"
 	depends on VFAT_FS
 	default "iso8859-1"
 	help
-	  Set this to the default I/O character set you'd like FAT to use.
-	  It should probably match the character set that most of your
-	  FAT filesystems use, and can be overridded with the 'iocharset'
-	  mount option for FAT filesystems.  Note that UTF8 is *not* a
-	  supported charset for FAT filesystems.
+	  Set this to the default input/output character set you'd
+	  like FAT to use. It should probably match the character set
+	  that most of your FAT filesystems use, and can be overridden
+	  with the "iocharset" mount option for FAT filesystems.
+	  Note that "utf8" is not recommended for FAT filesystems.
+	  If unsure, you shouldn't set "utf8" here.
+	  See <file:Documentation/filesystems/vfat.txt> for more information.
 
 config UMSDOS_FS
 #dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
_
