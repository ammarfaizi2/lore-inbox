Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312182AbSCTVGa>; Wed, 20 Mar 2002 16:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312180AbSCTVGU>; Wed, 20 Mar 2002 16:06:20 -0500
Received: from 216-224-51-61.client.dsl.net ([216.224.51.61]:43590 "EHLO
	ns11.ritman.com") by vger.kernel.org with ESMTP id <S312182AbSCTVGE>;
	Wed, 20 Mar 2002 16:06:04 -0500
Message-ID: <001501c1d053$0925cde0$0201a8c0@idlewild.net>
From: "Robert Schmaling" <schmali@ritman.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre3-ac4 compile failure on Alpha 
Date: Wed, 20 Mar 2002 16:05:54 -0500
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

Compilation fails with the following :

make[1]: Entering directory
`/usr/src/linux-2.4.19-pre3-ac4/arch/alpha/kernel'
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3-ac4/include -c 
-o entry.o entry.S
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3-ac4/include -Wall -Wstrict-pro
totypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-co
mmon -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=t
raps  -c -o traps.o traps.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3-ac4/include -Wall -Wstrict-pro
totypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-co
mmon -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=p
rocess  -c -o process.o process.c
process.c: In function `cpu_idle':
process.c:77: structure has no member named `nice'
process.c:78: structure has no member named `counter'
make[1]: *** [process.o] Error 1
make[1]: Leaving directory
`/usr/src/linux-2.4.19-pre3-ac4/arch/alpha/kernel'
make: *** [_dir_arch/alpha/kernel] Error 2


Hardware: alpha pc164lx w/533 21164a
Distribution: Redhat 7.1

Thanks,

