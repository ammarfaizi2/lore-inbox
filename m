Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318077AbSHDDUd>; Sat, 3 Aug 2002 23:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSHDDUd>; Sat, 3 Aug 2002 23:20:33 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:50183 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318077AbSHDDUd>;
	Sat, 3 Aug 2002 23:20:33 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 warnings with allnoconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Aug 2002 13:23:52 +1000
Message-ID: <23899.1028431432@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19 with make allnoconfig produces these warnings.  How about
getting a clean kernel before starting on 2.4.20?

init/do_mounts.c:980: warning: `crd_load' defined but not used

arch/i386/kernel/setup.c: In function `amd_adv_spec_cache_feature': 
arch/i386/kernel/setup.c:751: warning: implicit declaration of function `have_cpuid_p'
arch/i386/kernel/setup.c: At top level:
arch/i386/kernel/setup.c:2629: warning: `have_cpuid_p' was declared implicitly `extern' and later `static'
arch/i386/kernel/setup.c:751: warning: previous declaration of `have_cpuid_p' 

arch/i386/kernel/dmi_scan.c:196: warning: `disable_ide_dma' defined but not used

fs/dnotify.c: In function `__inode_dir_notify':
fs/dnotify.c:139: warning: label `out' defined but not used

fs/namespace.c: In function `mnt_init':
fs/namespace.c:1093: warning: implicit declaration of function `init_rootfs'

drivers/char/random.c:540: warning: `free_entropy_store' defined but not used

