Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSFCShL>; Mon, 3 Jun 2002 14:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317450AbSFCShK>; Mon, 3 Jun 2002 14:37:10 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:37764 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S317448AbSFCShK>;
	Mon, 3 Jun 2002 14:37:10 -0400
Message-ID: <04cf01c20b2d$96097030$f6de11cc@black>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.5.20 RAID5 compile error
Date: Mon, 3 Jun 2002 14:36:33 -0400
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

RAID5 still doesn't compile....sigh....

gcc -D__KERNEL__ -I/usr/src/linux-2.5.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-alias
ing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DKBUILD_BASENAME=raid5  -c -o raid5.o raid5.c
raid5.c: In function `raid5_plug_device':
raid5.c:1247: `tq_disk' undeclared (first use in this function)
raid5.c:1247: (Each undeclared identifier is reported only once
raid5.c:1247: for each function it appears in.)
raid5.c: In function `run':
raid5.c:1589: sizeof applied to an incomplete type
make[2]: *** [raid5.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.14/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.14/drivers'
make: *** [_mod_drivers] Error 2


Michael D. Black mblack@csihq.com
http://www.csihq.com/
http://www.csihq.com/~mike
321-676-2923, x203
Melbourne FL

