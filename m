Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbUCRKlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbUCRKlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:41:45 -0500
Received: from zux164-011.adsl.green.ch ([80.254.164.11]:53344 "EHLO
	iris.bluesaturn.com") by vger.kernel.org with ESMTP id S262504AbUCRKln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:41:43 -0500
Subject: compile error
From: Mauro Stettler <kernel-list@bluesaturn.com>
Reply-To: kernel-list@bluesaturn.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1079612949.2235.48.camel@twinmos.bluesaturn.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Mar 2004 13:29:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list

i got en error when i do make clean bzImage to compile my kernel 2.6.4.
i already did make mrproper and oldconfig...

it's a gentoo 1.4 with gcc3.3.2-r5 and glibc2.3.2-r9



  CLEAN   scripts
  RM  $(CLEAN_FILES)
  HOSTCC  scripts/fixdep
  HOSTCC  scripts/split-include
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/docproc
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTCC  scripts/sumversion.o
  HOSTLD  scripts/modpost
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/bin2c
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/i386/kernel/asm-offsets.s
In file included from include/asm/system.h:5,
                 from include/asm/processor.h:18,
                 from include/linux/prefetch.h:13,
                 from include/linux/list.h:7,
                 from include/linux/signal.h:4,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/kernel.h:10:20: stdarg.h: No such file or directory
In file included from include/asm/system.h:5,
                 from include/asm/processor.h:18,
                 from include/linux/prefetch.h:13,
                 from include/linux/list.h:7,
                 from include/linux/signal.h:4,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/kernel.h:71: error: syntax error before "va_list"
include/linux/kernel.h:71: warning: function declaration isn't a
prototype
include/linux/kernel.h:74: error: syntax error before "va_list"
include/linux/kernel.h:74: warning: function declaration isn't a
prototype
include/linux/kernel.h:77: error: syntax error before "va_list"
include/linux/kernel.h:77: warning: function declaration isn't a
prototype
include/linux/kernel.h:81: error: syntax error before "va_list"
include/linux/kernel.h:81: warning: function declaration isn't a
prototype
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [arch/i386/kernel/asm-offsets.s] Error 2



greets Mauro

