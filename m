Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267360AbSLLACY>; Wed, 11 Dec 2002 19:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbSLLACY>; Wed, 11 Dec 2002 19:02:24 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:44777 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S267360AbSLLACV>; Wed, 11 Dec 2002 19:02:21 -0500
Message-ID: <3DF84493.70304@centurytel.net>
Date: Thu, 12 Dec 2002 01:10:59 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: debian-user@lists.debian.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: error in make-kpkg at linux-2.5.51
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   gcc -Wp,-MD,drivers/ide/pci/.nvidia.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred
-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic 
-fomit-frame-pointer -nos
tdinc -iwithprefix include  -Idrivers/ide  -DKBUILD_BASENAME=nvidia 
-DKBUILD_MOD
NAME=nvidia   -c -o drivers/ide/pci/nvidia.o drivers/ide/pci/nvidia.c
In file included from drivers/ide/pci/nvidia.c:29:
drivers/ide/pci/nvidia.h:35: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' 
undeclared here (
not in a function)
drivers/ide/pci/nvidia.h:35: initializer element is not constant
drivers/ide/pci/nvidia.h:35: (near initialization for 
`nvidia_chipsets[0].device
')
drivers/ide/pci/nvidia.h:43: initializer element is not constant
drivers/ide/pci/nvidia.h:43: (near initialization for 
`nvidia_chipsets[0].enable
bits[0]')
drivers/ide/pci/nvidia.h:43: initializer element is not constant
drivers/ide/pci/nvidia.h:43: (near initialization for 
`nvidia_chipsets[0].enable
bits[1]')
drivers/ide/pci/nvidia.h:43: initializer element is not constant
drivers/ide/pci/nvidia.h:43: (near initialization for 
`nvidia_chipsets[0].enable
bits')
drivers/ide/pci/nvidia.h:46: initializer element is not constant
drivers/ide/pci/nvidia.h:46: (near initialization for `nvidia_chipsets[0]')
drivers/ide/pci/nvidia.c: In function `nforce_ratemask':
drivers/ide/pci/nvidia.c:79: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' 
undeclared (first
  use in this function)
drivers/ide/pci/nvidia.c:79: (Each undeclared identifier is reported 
only once
drivers/ide/pci/nvidia.c:79: for each function it appears in.)
drivers/ide/pci/nvidia.c:80: warning: unreachable code at beginning of 
switch st
atement
drivers/ide/pci/nvidia.c: In function `ata66_nforce':
drivers/ide/pci/nvidia.c:288: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' 
undeclared (firs
t use in this function)
drivers/ide/pci/nvidia.c:289: warning: unreachable code at beginning of 
switch s
tatement
drivers/ide/pci/nvidia.c: At top level:
drivers/ide/pci/nvidia.c:343: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' 
undeclared here
(not in a function)
drivers/ide/pci/nvidia.c:343: initializer element is not constant
drivers/ide/pci/nvidia.c:343: (near initialization for 
`nforce_pci_tbl[0].device
')
make[4]: *** [drivers/ide/pci/nvidia.o] Error 1
make[3]: *** [drivers/ide/pci] Error 2
make[2]: *** [drivers/ide] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/home/fsshl/linux-2.5.51'
make: *** [stamp-build] Error 2
-- 
Sincere Eric
www.linuxspice.com
linux pc for sale

