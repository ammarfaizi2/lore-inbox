Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTE0Cuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTE0Cuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:50:44 -0400
Received: from web40608.mail.yahoo.com ([66.218.78.145]:10253 "HELO
	web40608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262569AbTE0Cum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:50:42 -0400
Message-ID: <20030527030355.30173.qmail@web40608.mail.yahoo.com>
Date: Mon, 26 May 2003 20:03:55 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.70 -- drivers/ide/ppc/pmac.c:1265: `ide_dma_intr' undeclared (first use in this function)
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 CC      drivers/ide/ppc/pmac.o
drivers/ide/ppc/pmac.c: In function
`pmac_ide_dma_read':
drivers/ide/ppc/pmac.c:1265: `ide_dma_intr' undeclared
(first use in this function)
drivers/ide/ppc/pmac.c:1265: (Each undeclared
identifier is reported only once
drivers/ide/ppc/pmac.c:1265: for each function it
appears in.)
drivers/ide/ppc/pmac.c: In function
`pmac_ide_dma_write':
drivers/ide/ppc/pmac.c:1318: `ide_dma_intr' undeclared
(first use in this function)
drivers/ide/ppc/pmac.c: In function
`pmac_ide_setup_dma':
drivers/ide/ppc/pmac.c:1499: `__ide_dma_off'
undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1500: `__ide_dma_off_quietly'
undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1501: `__ide_dma_on' undeclared
(first use in this function)
drivers/ide/ppc/pmac.c:1511: `__ide_dma_good_drive'
undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1512: `__ide_dma_bad_drive'
undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1513: `__ide_dma_verbose'
undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1514: `__ide_dma_timeout'
undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1515: `__ide_dma_retune'
undeclared (first use in this function)
make[3]: *** [drivers/ide/ppc/pmac.o] Error 1

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7

CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y

CONFIG_PM=y
# CONFIG_8260 is not set
CONFIG_GENERIC_ISA_DMA=y
CONFIG_ALL_PPC=y
CONFIG_PPC_STD_MMU=y
CONFIG_ALL_PPC_CH=y
CONFIG_ALTIVEC=y
CONFIG_TAU=y
# CONFIG_TAU_INT is not set
CONFIG_TAU_AVERAGE=y
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_PMAC=y

CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y



__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
