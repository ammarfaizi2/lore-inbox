Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSIJVPO>; Tue, 10 Sep 2002 17:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSIJVPO>; Tue, 10 Sep 2002 17:15:14 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:53178 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S318141AbSIJVPN>; Tue, 10 Sep 2002 17:15:13 -0400
Date: Tue, 10 Sep 2002 17:19:53 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: Linux 2.4.20-pre6 tg3 compile errors
In-Reply-To: <20020910211222.37684.qmail@web14001.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0209101716300.17602-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling in tg3 support using the tg3.c and tg3.h from 2.4.20-pre6

distro: debian woody

gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=tg3  -c -o
tg3.o tg3.c
tg3.c: In function `tg3_rx':
tg3.c:1977: warning: implicit declaration of function `netif_receive_skb'
tg3.c: In function `tg3_poll':
tg3.c:2054: structure has no member named `quota'
tg3.c:2055: structure has no member named `quota'
tg3.c:2060: structure has no member named `quota'
tg3.c:2067: warning: implicit declaration of function `netif_rx_complete'
tg3.c: In function `tg3_interrupt_main_work':
tg3.c:2094: warning: implicit declaration of function
`netif_rx_schedule_prep'
tg3.c:2100: warning: implicit declaration of function
`__netif_rx_schedule'
tg3.c: In function `__tg3_set_rx_mode':
tg3.c:4881: structure has no member named `vlgrp'
tg3.c: In function `tg3_init_one':
tg3.c:6641: structure has no member named `poll'
tg3.c:6642: structure has no member named `weight'
make[3]: *** [tg3.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.19/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.19/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.19/drivers'
make: *** [_dir_drivers] Error 2


[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF


