Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261655AbSI0IDz>; Fri, 27 Sep 2002 04:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSI0IDy>; Fri, 27 Sep 2002 04:03:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:31243 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261655AbSI0IDw>; Fri, 27 Sep 2002 04:03:52 -0400
Message-Id: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Does kernel use system stdarg.h?
Date: Fri, 27 Sep 2002 10:58:52 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory `/usr/src/linux-2.5.36/kernel'
gcc -E 
-Wp,-MD,/usr/src/linux-2.5.36/include/linux/modules/kernel/.exec_domain.ver.d 
-D__KERNEL__ -I/usr/src/linux-2.5.36/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i486 -nostdinc -iwithprefix include 
   -DKBUILD_BASENAME=exec_domain -D__GENKSYMS__  exec_domain.c | 
/sbin/genksyms -p smp_ -k 2.5.36 > 
/usr/src/linux-2.5.36/include/linux/modules/kernel/exec_domain.ver.tmp
In file included from exec_domain.c:12:
/usr/src/linux-2.5.36/include/linux/kernel.h:10:20: stdarg.h: No such file or 
directory

There is no stdarg.h in kernel tree, should it be there?
For now I just copied GCC one into linux/include...
--
vda
