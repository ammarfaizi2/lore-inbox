Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTHZTgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTHZTgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:36:20 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:47621 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262719AbTHZTgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:36:10 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Alex Zarochentsev <zam@namesys.com>
Cc: Steven Cole <elenstev@mesatop.com>, Oleg Drokin <green@namesys.com>,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826182609.GO5448@backtop.namesys.com>
References: <20030826102233.GA14647@namesys.com>
	 <1061922037.1670.3.camel@spc9.esa.lanl.gov>
	 <20030826182609.GO5448@backtop.namesys.com>
Content-Type: text/plain
Message-Id: <1061926566.1076.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 21:36:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 20:26, Alex Zarochentsev wrote:

> Disable "reiser4 system call" (CONFIG_REISER4_FS_SYSCALL) support, it is 
> not ready.

[...]
  CC      lib/string.o
lib/string.c:435: warning: conflicting types for built-in function
`bcopy'
  CC      lib/vsprintf.o
  AR      lib/lib.a
  LD      arch/i386/lib/built-in.o
  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/dec_and_lock.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.data+0x7c4): In function `sys_call_table':
: undefined reference to `sys_reiser4'
make[2]: *** [.tmp_vmlinux1] Error 1
make[1]: *** [vmlinux] Error 2

[...]
CONFIG_REISER4_FS=m
# CONFIG_REISER4_FS_SYSCALL is not set
# CONFIG_REISER4_LARGE_KEY is not set
# CONFIG_REISER4_CHECK is not set
# CONFIG_REISER4_USE_EFLUSH is not set
# CONFIG_REISER4_BADBLOCKS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
[...]


