Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264968AbSKNQhb>; Thu, 14 Nov 2002 11:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSKNQhb>; Thu, 14 Nov 2002 11:37:31 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:55313 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S264968AbSKNQh3>; Thu, 14 Nov 2002 11:37:29 -0500
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: Linux 2.4.20-rc1-ac2
Date: Thu, 14 Nov 2002 16:44:22 +0000 (UTC)
Organization: Cistron
Message-ID: <ar0jt6$fas$1@ncc1701.cistron.net>
References: <200211141622.gAEGMhX17361@devserv.devel.redhat.com>
X-Trace: ncc1701.cistron.net 1037292262 15708 62.216.30.38 (14 Nov 2002 16:44:22 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox  <alan@redhat.com> wrote:
>Linux 2.4.20-rc1-ac2

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586   -nostdinc -iwithprefix include -DKBUILD_BASENAME=rmap  -c -o rmap.o rmap.c
In file included from rmap.c:31:
/usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:17: warning: `kernel_locked' redefined
/usr/src/linux-2.4.20-rc1-ac2/include/linux/smp_lock.h:12: warning: this is the location of the previous definition
/usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:28: warning: `release_kernel_lock' redefined
/usr/src/linux-2.4.20-rc1-ac2/include/linux/smp_lock.h:10: warning: this is the location of the previous definition
/usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:37: warning: `reacquire_kernel_lock' redefined
/usr/src/linux-2.4.20-rc1-ac2/include/linux/smp_lock.h:11: warning: this is the location of the previous definition
/usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:47: arguments given to macro `lock_kernel'
/usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:63: arguments given to macro `unlock_kernel'
In file included from rmap.c:31:
/usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:47: parse error before `do'
/usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:63: parse error before `do'
make[3]: *** [rmap.o] Error 1




