Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbTCUWUl>; Fri, 21 Mar 2003 17:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbTCUWTi>; Fri, 21 Mar 2003 17:19:38 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:522 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S263952AbTCUWS0>;
	Fri, 21 Mar 2003 17:18:26 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Fri, 21 Mar 2003 23:29:27 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5-ac3 radeon warnings
Message-ID: <Pine.OSF.4.51.0303211849160.425037@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  could someone tell me if I should worry about this? The resulting
kernel is running fine. Please Cc: me in replies.

make[4]: Entering directory `/usr/src/linux-2.4.21-pre5-ac3/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre5-ac3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_drv  -c -o radeon_drv.o radeon_drv.c
In file included from drmP.h:75,
                 from radeon_drv.c:32:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_drv.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from drm_dma.h:33,
                 from radeon_drv.c:42:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre5-ac3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_cp  -c -o radeon_cp.o radeon_cp.c
In file included from drmP.h:75,
                 from radeon_cp.c:32:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_cp.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_cp.c:36:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre5-ac3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_state  -c -o radeon_state.o radeon_state.c
In file included from drmP.h:75,
                 from radeon_state.c:31:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_state.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_state.c:36:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre5-ac3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_mem  -c -o radeon_mem.o radeon_mem.c
In file included from drmP.h:75,
                 from radeon_mem.c:33:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_mem.c:36:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_mem.c:37:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
radeon_mem.c:135: warning: `print_heap' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre5-ac3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_irq  -c -o radeon_irq.o radeon_irq.c
In file included from drmP.h:75,
                 from radeon_irq.c:34:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_irq.c:37:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_irq.c:38:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
ld -m elf_i386 -r -o radeon.o radeon_drv.o radeon_cp.o radeon_state.o radeon_mem.o radeon_irq.o
rm -f drm.o
ld -m elf_i386  -r -o drm.o radeon.o
make[4]: Leaving directory `/usr/src/linux-2.4.21-pre5-ac3/drivers/char/drm'


-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
