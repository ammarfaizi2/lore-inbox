Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSDVTpp>; Mon, 22 Apr 2002 15:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314704AbSDVTpo>; Mon, 22 Apr 2002 15:45:44 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:36130 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S314702AbSDVTph>;
	Mon, 22 Apr 2002 15:45:37 -0400
Message-ID: <07a201c1ea36$34277820$a501a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: PPC compile issue
Date: Mon, 22 Apr 2002 21:44:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to compile 2.5.8 on PowerMac G3 and I got this:

----------------
gcc -D__KERNEL__ -I/home/users/adasi/rpm/BUILD/linux-2.5.8/include -Wall -Ws
trict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -I/home/users/adasi/rpm/BUILD/linux-2.5.8/arch/ppc -fsigned-ch
ar -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -D
KBUILD_BASENAME=swim3  -c -o swim3.o swim3.c
swim3.c:32: asm/feature.h: No such file or directory
swim3.c: In function `start_request':
swim3.c:316: invalid operands to binary >>
swim3.c:318: structure has no member named `bh'
swim3.c:318: structure has no member named `bh'
swim3.c:341: warning: comparison between pointer and integer
swim3.c: In function `setup_transfer':
swim3.c:429: warning: comparison between pointer and integer
swim3.c:442: warning: comparison between pointer and integer
swim3.c:456: warning: comparison between pointer and integer
swim3.c: In function `xfer_timeout':
swim3.c:595: warning: comparison between pointer and integer
swim3.c:604: warning: comparison between pointer and integer
swim3.c: In function `swim3_interrupt':
swim3.c:626: warning: unsigned int format, pointer arg (arg 3)
swim3.c:688: warning: comparison between pointer and integer
swim3.c:705: warning: comparison between pointer and integer
swim3.c:715: warning: unsigned int format, pointer arg (arg 3)
swim3.c: In function `floppy_ioctl':
swim3.c:819: invalid operands to binary &
swim3.c: In function `floppy_open':
swim3.c:851: invalid operands to binary &
swim3.c: In function `floppy_release':
swim3.c:925: invalid operands to binary &
swim3.c: In function `floppy_check_change':
swim3.c:942: invalid operands to binary &
swim3.c:944: invalid operands to binary >>
swim3.c: In function `floppy_revalidate':
swim3.c:956: invalid operands to binary &
swim3.c:958: invalid operands to binary >>
swim3.c: In function `swim3_add_device':
swim3.c:1066: warning: implicit declaration of function `feature_set'
swim3.c:1066: `FEATURE_SWIM3_enable' undeclared (first use in this function)
swim3.c:1066: (Each undeclared identifier is reported only once
swim3.c:1066: for each function it appears in.)
swim3.c:1088: warning: implicit declaration of function `feature_clear'
make[3]: *** [swim3.o] Error 1
make[3]: Leaving directory
`/home/users/adasi/rpm/BUILD/linux-2.5.8/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/home/users/adasi/rpm/BUILD/linux-2.5.8/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/home/users/adasi/rpm/BUILD/linux-2.5.8/drivers'
make: *** [_dir_drivers] Error 2
----------------------------------
Who can help?
WK

