Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSE2Muk>; Wed, 29 May 2002 08:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSE2Muj>; Wed, 29 May 2002 08:50:39 -0400
Received: from th00.opsion.fr ([195.219.20.10]:59405 "HELO th00.opsion.fr")
	by vger.kernel.org with SMTP id <S315210AbSE2Mui> convert rfc822-to-8bit;
	Wed, 29 May 2002 08:50:38 -0400
Send-By: 211.22.33.155 with Mozilla/4.7 [en] (X11; I; Linux 2.4.17 i586)
To: <linux-kernel@vger.kernel.org>
Subject: Fail To Compile Code For ALI M15x3 Chipset
From: <cnliou@eurosport.com>
X-Priority: 3 (normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 29 May 2002 12:50:26 GMT
Message-id: <200205291250.1a8a@th00.opsion.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel having problem when compiling: 2.4.17.
glibc 2.1.2
gcc 2.95.3
hardware=AMD K6 II 450 MHz.

When

CONFIG_BLK_DEV_ALIM15X3=y

then

"make bzImage"

aborts with the following message.

Regards,

CN
===========

make[3]: Entering directory
`/usr/src/linux-2.4.17/drivers/ide'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.17/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6    -c -o
alim15x3.o alim15x3.c
alim15x3.c: In function `ali15x3_tune_drive':
alim15x3.c:246: structure has no member named
`pci_dev'
alim15x3.c: In function `ali15x3_tune_chipset':
alim15x3.c:315: structure has no member named
`pci_dev'
alim15x3.c: In function `ata66_ali15x3':
alim15x3.c:548: structure has no member named
`pci_dev'
alim15x3.c: In function `ide_dmacapable_ali15x3':
alim15x3.c:704: warning: implicit declaration of
function `ide_setup_dma'
alim15x3.c: At top level:
alim15x3.c:362: warning: `config_chipset_for_pio'
defined but not used
make[3]: *** [alim15x3.o] Error 1
make[3]: Leaving directory
`/usr/src/linux-2.4.17/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/usr/src/linux-2.4.17/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory
`/usr/src/linux-2.4.17/drivers'
make: *** [_dir_drivers] Error 2

--------------------------------------------------------
You too can have your own email address from Eurosport.
http://www.eurosport.com





