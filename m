Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSGXSK7>; Wed, 24 Jul 2002 14:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSGXSK7>; Wed, 24 Jul 2002 14:10:59 -0400
Received: from lehtori.cc.tut.fi ([130.230.10.20]:2565 "HELO lehtori.cc.tut.fi")
	by vger.kernel.org with SMTP id <S317454AbSGXSK6>;
	Wed, 24 Jul 2002 14:10:58 -0400
Date: Wed, 24 Jul 2002 21:14:10 +0300 (EET DST)
From: =?ISO-8859-1?Q?Lepp=E4nen_Raimo?= <waari@lehtori.cc.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Error and warnings linux-2.4.19-pre9
Message-ID: <Pine.OSF.4.44.0207242112460.7900-100000@lehtori.cc.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!
Help me next little problems linux-2.4.19-pre9:
make dep:
make[4]: Entering directory `/usr/src/linux/drivers/scsi'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.95.3/include -E -D__GENKSYMS__ scsi_syms.c
| /sbin/genksyms  -k 2.4.19 > /usr/src/linux/include/linux/modules/scsi_syms.ver.tmp
mv /usr/src/linux/include/linux/modules/scsi_syms.ver.tmp /usr/src/linux/include/linux/modules/scsi_syms.ver
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.95.3/include -E -D__GENKSYMS__ 53c700.c
| /sbin/genksyms  -k 2.4.19 > /usr/src/linux/include/linux/modules/53c700.ver.tmp
In file included from 53c700.c:134:
>>53c700.h:40: #error "Config.in must define either CONFIG_53C700_IO_MAPPED or CONFIG_53C700_MEM_MAPPED to use this scsi core."
>>53c700.c:155: 53c700_d.h: No such file or directory
mv /usr/src/linux/include/linux/modules/53c700.ver.tmp /usr/src/linux/include/linux/modules/53c700.ver
">>" Error found many older kernel versions.
How is my edit or repair this error ???
------
make bzlilo:
>>dnotify.c: In function `__inode_dir_notify':
>>dnotify.c:139: warning: label `out' defined but not used
>>dmi_scan.c:196: warning: `disable_ide_dma' defined but not used
">>" Why ??. How is my edit or repair source code in this warning ???
------
make modules:
ppp_generic.c: In function `ppp_read':
>>ppp_generic.c:381: warning: `ret' might be used uninitialized in this function
>>aha1542.c:114: warning: `setup_str' defined but not used
>>awe_wave.c:211: warning: `isapnp' defined but not used
">>" Why ??. How is my edit or repair source code in this warning ???

Thank You help.

WAARI



