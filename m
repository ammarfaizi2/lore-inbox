Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317612AbSFIN7z>; Sun, 9 Jun 2002 09:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317613AbSFIN7y>; Sun, 9 Jun 2002 09:59:54 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33551 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317612AbSFIN7x>;
	Sun, 9 Jun 2002 09:59:53 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.21 make allnoconfig errors
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Jun 2002 23:59:42 +1000
Message-ID: <32638.1023631182@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

namespace.h, dcache.h do not cope with make allnoconfig.

In file included from kernel/fork.c:22:
include/linux/namespace.h:9: field `sem' has incomplete type
include/linux/namespace.h: In function `put_namespace':
include/linux/namespace.h:18: `dcache_lock' undeclared (first use in this function)
include/linux/namespace.h:18: (Each undeclared identifier is reported only once
include/linux/namespace.h:18: for each function it appears in.)
include/linux/namespace.h: In function `exit_namespace':
include/linux/namespace.h:28: dereferencing pointer to incomplete type
include/linux/namespace.h:31: dereferencing pointer to incomplete type
In file included from include/linux/fs.h:19,
                 from kernel/fork.c:26:
include/linux/dcache.h: At top level:
include/linux/dcache.h:136: `dcache_lock' used prior to declaration

In file included from include/linux/highmem.h:5,
                 from mm/vmalloc.c:13:
include/linux/bio.h:90: parse error before `atomic_t'
include/linux/bio.h:95: parse error before `}'

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_NOHIGHMEM=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y

