Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292530AbSCSVFU>; Tue, 19 Mar 2002 16:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSCSVFL>; Tue, 19 Mar 2002 16:05:11 -0500
Received: from ep09.kernel.pl ([212.87.11.162]:39300 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S292530AbSCSVEx>;
	Tue, 19 Mar 2002 16:04:53 -0500
Message-ID: <01c901c1cf89$b402b4f0$0201a8c0@WITEK>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.7] sbpcd compilation error
Date: Tue, 19 Mar 2002 22:04:41 +0100
Organization: PLD Team
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

egcs -D__KERNEL__ -I/home/users/adasi/rpm/BUILD/linux-2.5.7/include -Wall -W
strict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasi
ng -fno-common -pipe  -march=i686 -DMODULE  -DKBUILD_BASENAME=sbpcd  -c -o
sbpcd.o sbpcd.c
sbpcd.c: In function `sbpcd_end_request':
sbpcd.c:4884: structure has no member named `queue'
sbpcd.c: In function `__SBPCD_INIT':
sbpcd.c:5861: too few arguments to function `blk_init_queue'
sbpcd.c:5863: warning: assignment from incompatible pointer type
sbpcd.c:5864: warning: assignment from incompatible pointer type
sbpcd.c:5865: warning: assignment from incompatible pointer type
sbpcd.c:5867: `read_ahead' undeclared (first use in this function)
sbpcd.c:5867: (Each undeclared identifier is reported only once
sbpcd.c:5867: for each function it appears in.)
sbpcd.c:5919: incompatible types in assignment
make[2]: *** [sbpcd.o] B³±d 1

Building sbpcd as module
--
Witek 'adasi' Krêcicki|Emancipate yourselves from mental slavery
adasi[at]grubno.da.ru |None  but ourselves  can  free our  minds
GG:346981 +48502117580|  -  Bob  Marley,       Redemption   Song
...-=DOoGA=-....-=CRS00=-...-=CRSPoland=-....-=AI=-...-=PLD=-...




