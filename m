Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSE1OaR>; Tue, 28 May 2002 10:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSE1OaQ>; Tue, 28 May 2002 10:30:16 -0400
Received: from vivi.uptime.at ([62.116.87.11]:43166 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S314395AbSE1OaQ>;
	Tue, 28 May 2002 10:30:16 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.5.18 on alpha
Date: Tue, 28 May 2002 16:29:15 +0200
Organization: =?US-ASCII?Q?UPtime_Systemlosungen?=
Message-ID: <000901c20654$0e215440$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <1022593339.21314.63.camel@sake>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi volks!

I get this error when trying to compile kernel 2.5.18 on alpha.

Please help me!

[ ... ]
gcc -D__KERNEL__ -I/root/linux-2.5.18/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6
-DKBUILD_BASENAME=do_mounts  -c -o do_mounts.o do_mounts.c
In file included from /root/linux-2.5.18/include/linux/thread_info.h:10,
                 from /root/linux-2.5.18/include/linux/spinlock.h:7,
                 from /root/linux-2.5.18/include/linux/tqueue.h:16,
                 from /root/linux-2.5.18/include/linux/sched.h:10,
                 from do_mounts.c:4:
/root/linux-2.5.18/include/linux/bitops.h: In function
`get_bitmask_order':
/root/linux-2.5.18/include/linux/bitops.h:77: warning: implicit
declaration of function `fls'
In file included from do_mounts.c:13:
/root/linux-2.5.18/include/linux/suspend.h:4:25: asm/suspend.h: No such
file or directory
make[1]: *** [do_mounts.o] Error 1
make[1]: Leaving directory `/root/linux-2.5.18/init'
make: *** [_dir_init] Error 2
[ ... ]

Greetz,
 Oliver


