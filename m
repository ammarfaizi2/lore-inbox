Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTEJXOy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 19:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTEJXOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 19:14:53 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:41716 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP id S264526AbTEJXOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 19:14:52 -0400
Message-ID: <3EBD8ADF.5040803@attbi.com>
Date: Sat, 10 May 2003 16:27:27 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4a) Gecko/20030403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk4 -- drivers/ide/ppc/pmac.c: 724: In function `pmac_find_ide_boot':
 incompatible types in return
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   gcc -Wp,-MD,drivers/ide/ppc/.pmac.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple 
-mstring -fomit-frame-pointer -nostdinc -iwithprefix include 
-Idrivers/ide  -DKBUILD_BASENAME=pmac -DKBUILD_MODNAME=pmac -c -o 
drivers/ide/ppc/pmac.o drivers/ide/ppc/pmac.c
drivers/ide/ppc/pmac.c: In function `pmac_find_ide_boot':
drivers/ide/ppc/pmac.c:724: incompatible types in return
make[3]: *** [drivers/ide/ppc/pmac.o] Error 1

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y

CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

