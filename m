Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSGZHL7>; Fri, 26 Jul 2002 03:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317276AbSGZHL6>; Fri, 26 Jul 2002 03:11:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56582 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317269AbSGZHLz>; Fri, 26 Jul 2002 03:11:55 -0400
Message-ID: <3D40F5CE.8010705@evision.ag>
Date: Fri, 26 Jul 2002 09:10:06 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.28 IDE 103
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------050200000404040905070608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200000404040905070608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Remove pseudo headers for nonexisting support of not existing
   hardware from Big Black Boxen code.

--------------050200000404040905070608
Content-Type: text/plain;
 name="ide-103.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-103.diff"

diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/include/asm-s390/hdreg.h linux/include/asm-s390/hdreg.h
--- linux-2.5.28/include/asm-s390/hdreg.h	2002-07-24 23:03:31.000000000 +0200
+++ linux/include/asm-s390/hdreg.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,13 +0,0 @@
-/*
- *  linux/include/asm-arm/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASMS390_HDREG_H
-#define __ASMS390_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASMS390_HDREG_H */
-
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/include/asm-s390/ide.h linux/include/asm-s390/ide.h
--- linux-2.5.28/include/asm-s390/ide.h	2002-07-24 23:03:28.000000000 +0200
+++ linux/include/asm-s390/ide.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,27 +0,0 @@
-/*
- *  linux/include/asm-s390/ide.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-/* s390 does not have IDE */
-
-#ifndef __ASMS390_IDE_H
-#define __ASMS390_IDE_H
-
-#ifdef __KERNEL__
-
-#ifndef MAX_HWIFS
-#define MAX_HWIFS	0
-#endif
-
-/*
- * We always use the new IDE port registering,
- * so these are fixed here.
- */
-#define ide_default_io_base(i)		((ide_ioreg_t)0)
-#define ide_default_irq(b)		(0)
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASMS390_IDE_H */
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/include/asm-s390x/hdreg.h linux/include/asm-s390x/hdreg.h
--- linux-2.5.28/include/asm-s390x/hdreg.h	2002-07-24 23:03:31.000000000 +0200
+++ linux/include/asm-s390x/hdreg.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,13 +0,0 @@
-/*
- *  linux/include/asm-arm/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASMS390_HDREG_H
-#define __ASMS390_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASMS390_HDREG_H */
-

--------------050200000404040905070608--

