Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUL2WYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUL2WYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUL2WYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:24:40 -0500
Received: from web52002.mail.yahoo.com ([206.190.39.58]:28011 "HELO
	web52002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261174AbUL2WYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:24:35 -0500
Message-ID: <20041229222434.67496.qmail@web52002.mail.yahoo.com>
Date: Wed, 29 Dec 2004 19:24:34 -0300 (ART)
From: =?iso-8859-1?q?V=EDtor=20De=20Ara=FAjo?= 
	<xyzinformatica@yahoo.com.br>
Subject: Linux 2.6.10 compile-time error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This error ocurred while I'm compiling the Linux 2.6.10:

  Using /mnt/docs/docs/Install/Kernel/linux-2.6.10 as source for kernel
  GEN    /mnt/docs/docs/Install/Kernel/linux-2.6.10-build/Makefile
  CHK     include/linux/version.h
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      fs/dquot.o
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:1: error: parse error
before '/' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:14: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:16: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:19: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:32: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:38:51: missing
terminating ' character
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:38:51: warning: character
constant too long for its type
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:40: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:43: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:47: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:50: error: syntax error
at '@' token
/mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:53: error: syntax error
at '@' token
In file included from
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:10,
                 from /mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:59:
/usr/lib/gcc-lib/i486-linux/3.3.4/include/stdarg.h:105: error: parse error
before "va_list"
In file included from /mnt/docs/docs/Install/Kernel/linux-2.6.10/fs/dquot.c:59:
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:82: error:
parse error before "va_list"
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:82: warning:
function declaration isn't a prototype
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:85: error:
parse error before "va_list"
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:85: warning:
function declaration isn't a prototype
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:88: error:
parse error before "va_list"
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:88: warning:
function declaration isn't a prototype
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:92: error:
parse error before "va_list"
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:92: warning:
function declaration isn't a prototype
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:102: error:
parse error before "va_list"
/mnt/docs/docs/Install/Kernel/linux-2.6.10/include/linux/kernel.h:102: warning:
function declaration isn't a prototype
make[2]: *** [fs/dquot.o] Error 1
make[1]: *** [fs] Error 2
make: *** [all] Error 2

The output of scripts/ver_linux follows:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux XYZ001-tst 2.6.6 #3 Fri Dec 10 20:59:31 GMT-2 2004 i586 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         apm snd_mixer_oss snd pcspkr 3c59x rtc

                                                                               
                                                                

=====
Vítor De Araújo


	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Instale o discador do Yahoo! agora. http://br.acesso.yahoo.com/ - Internet rápida e grátis
