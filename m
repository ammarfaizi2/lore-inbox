Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSE3Fej>; Thu, 30 May 2002 01:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316367AbSE3Fei>; Thu, 30 May 2002 01:34:38 -0400
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:531 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S316364AbSE3Fei>; Thu, 30 May 2002 01:34:38 -0400
Message-Id: <5.1.0.14.2.20020530073357.00cba7d8@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 30 May 2002 07:35:18 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: 2.5.19 - raid1 erros on compile
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have problems compiling kernel with raid1 support.

Any idea?

thanks

make[2]: Entering directory `/usr/src/linux-2.5.19/drivers/md'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.19/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 
-march=i686    -DKBUILD_BASENAME=raid1  -c -o raid1.o raid1.c
raid1.c: In function `device_barrier':
raid1.c:412: `tq_disk' undeclared (first use in this function)
raid1.c:412: (Each undeclared identifier is reported only once
raid1.c:412: for each function it appears in.)
raid1.c: In function `make_request':
raid1.c:449: `tq_disk' undeclared (first use in this function)
raid1.c: In function `close_sync':
raid1.c:651: `tq_disk' undeclared (first use in this function)
make[2]: *** [raid1.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.19/drivers/md'
make[1]: *** [_subdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.19/drivers'
make: *** [drivers] Error 2



