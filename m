Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284761AbRLEWIS>; Wed, 5 Dec 2001 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284760AbRLEWIC>; Wed, 5 Dec 2001 17:08:02 -0500
Received: from walden.phpwebhosting.com ([64.65.61.214]:9995 "HELO
	walden.phpwebhosting.com") by vger.kernel.org with SMTP
	id <S284657AbRLEWGa>; Wed, 5 Dec 2001 17:06:30 -0500
Message-Id: <5.1.0.14.0.20011205160555.00a10ec0@sunset.olemiss.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 05 Dec 2001 16:07:05 -0600
To: linux-kernel@vger.kernel.org
From: Ben Pharr - Lists <ben-lists@benpharr.com>
Subject: Missing Files
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling 2.4.17 today I got the following errors. I didn't cause 
anything fatal, but it's something that needs fixing.

Ben Pharr


gcc -D__KERNEL__ -I/usr/src/linux-2.4.17-pre4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686  -E -D__GENKSYMS__ sa1100fb.c
| /sbin/genksyms  -k 2.4.17 > 
/usr/src/linux-2.4.17-pre4/include/linux/modules/sa1100fb.ver.tmp
sa1100fb.c:164: linux/cpufreq.h: No such file or directory
sa1100fb.c:166: asm/hardware.h: No such file or directory
sa1100fb.c:169: asm/mach-types.h: No such file or directory
sa1100fb.c:171: asm/arch/assabet.h: No such file or directory
mv /usr/src/linux-2.4.17-pre4/include/linux/modules/sa1100fb.ver.tmp 
/usr/src/linux-2.4.17-pre4/include/linux/modules/sa1100fb

