Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSCSTa6>; Tue, 19 Mar 2002 14:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSCSTas>; Tue, 19 Mar 2002 14:30:48 -0500
Received: from inti.inf.utfsm.cl ([146.83.198.3]:7325 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S291753AbSCSTal>;
	Tue, 19 Mar 2002 14:30:41 -0500
Date: Tue, 19 Mar 2002 14:30:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Message-Id: <200203191830.g2JIUAWo010438@tigger.valparaiso.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre3-ac2 compile failure
Cc: Alan.Cox@linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Entering directory `/usr/src/linux-2.4/ipc'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4/ipc'
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=util  -c -o util.o util.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=msg  -c -o msg.o msg.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=sem  -c -o sem.o sem.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=shm  -c -o shm.o shm.c
shm.c: In function `sys_shmdt':
shm.c:682: too few arguments to function `do_munmap'
make[2]: *** [shm.o] Error 1
