Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292122AbSCSThi>; Tue, 19 Mar 2002 14:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291948AbSCSTha>; Tue, 19 Mar 2002 14:37:30 -0500
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:35523 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S292122AbSCSThT>; Tue, 19 Mar 2002 14:37:19 -0500
Message-ID: <070a01c1cf7d$83a67370$6caaa8c0@KPFW2K>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre3-ac2 compile error
Date: Tue, 19 Mar 2002 12:37:32 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make
CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno
-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -
mpreferred-stack-boundary=2 -march=athlon  " -C  ipc
make[1]: Entering directory `/usr/src/linux/ipc'
make all_targets
make[2]: Entering directory `/usr/src/linux/ipc'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpre
ferred-stack-boundary=2 -march=athlon    -DKBUILD_BASENAME=shm  -c -o shm.o
shm.c
shm.c: In function `sys_shmdt':
shm.c:682: too few arguments to function `do_munmap'
make[2]: *** [shm.o] Error 1
make[2]: Leaving directory `/usr/src/linux/ipc'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/ipc'
make: *** [_dir_ipc] Error 2

Sources were 2.4.19-pre3-ac2 plus lm-sensors patches and local ide-floppy
patches.

