Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271959AbRH2MjS>; Wed, 29 Aug 2001 08:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271958AbRH2Mi5>; Wed, 29 Aug 2001 08:38:57 -0400
Received: from mail.gazinter.net ([212.44.64.6]:33297 "EHLO
	server-001.gazinter.net") by vger.kernel.org with ESMTP
	id <S271957AbRH2Miz>; Wed, 29 Aug 2001 08:38:55 -0400
X-Mail-Server: =?ISO-8859-1?Q?Eserv/2.95/=CE=CE=CE?= 
Date: Wed, 29 Aug 2001 15:39:23 +0300
From: "Oleg O. Ossovitskii" <oleg@kgpa.ru>
X-Mailer: The Bat! (v1.45) Personal
Reply-To: "Oleg O. Ossovitskii" <oleg@kgpa.ru>
Organization: KGPA Ltd. Software lab
X-Priority: 3 (Normal)
Message-ID: <1161445508.20010829153923@kgpa.ru>
To: linux-kernel@vger.kernel.org
Subject: Small slip in ntfs code from linux kernel 2.4.9
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Linux kernel 2.4.9 can't be compiled if NTFS support is added. Fix of
 this problem see at bottom of letter.

=== cut ===
diff -u --recursive --new-file linux-2.4.9/fs/ntfs/unistr.c linux-2.4.9-oo1/fs/ntfs/unistr.c
--- linux-2.4.9/fs/ntfs/unistr.c        Mon Aug 27 16:35:21 2001
+++ linux-2.4.9-oo1/fs/ntfs/unistr.c    Mon Aug 27 16:23:25 2001
@@ -22,6 +22,7 @@
  */
 
 #include <linux/string.h>
+#include <linux/kernel.h>
 #include <asm/byteorder.h>
 
 #include "unistr.h"

 === cut ===


Best regards, Oleg O. Ossovitskii
system programmer of KGPA Ltd.
tel: +7(0112)46-23-40, fax: +7(0112)43-64-96
mailto:oleg@kgpa.ru, icq# 33366588


