Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbSLKXTC>; Wed, 11 Dec 2002 18:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbSLKXTB>; Wed, 11 Dec 2002 18:19:01 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:20998 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S266114AbSLKXTB>; Wed, 11 Dec 2002 18:19:01 -0500
Message-Id: <5.1.1.6.2.20021212002424.00cdeb00@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 12 Dec 2002 00:27:12 +0100
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Compilation problems with local APIC for uniprocessors in
  linux 2.4.20-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-ac2/include 
-I/usr/lib/gcc-lib/i386-linux/3.2.2/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
mpparse.c:75: `dest_LowestPrio' undeclared here (not in a function)
mpparse.c: In function `smp_read_mpc':
mpparse.c:607: `dest_Fixed' undeclared (first use in this function)
mpparse.c:607: (Each undeclared identifier is reported only once
mpparse.c:607: for each function it appears in.)
mpparse.c:607: `dest_LowestPrio' undeclared (first use in this function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20-ac2/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


the variable is not defined or is not "inherited".

Seeya

