Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUCWK2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUCWK2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:28:05 -0500
Received: from zux164-011.adsl.green.ch ([80.254.164.11]:51828 "EHLO
	iris.bluesaturn.com") by vger.kernel.org with ESMTP id S262441AbUCWK1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:27:55 -0500
Subject: cannot compile
From: Mauro Stettler <kernel-list@bluesaturn.com>
Reply-To: kernel-list@bluesaturn.com
To: kernel-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080048426.6447.6.camel@twinmos.bluesaturn.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2004 14:27:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hy

I got an error by compiling a kernel. I tried 2.4.x and 2.6.x, but it's
no difference, because of that I thought it must be a problem with gcc
or glibc and I recompiled them.

that's one try with 2.6.4:
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


thanks for help

