Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270483AbTHCBLM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270475AbTHCBLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:11:12 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:59028 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270483AbTHCBLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:11:06 -0400
From: Miles Lane <miles.lane@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-bk2 -- arch/ppc/kernel/setup.c:587: error: invalid use of undefined type `struct cpu'
Date: Sat, 2 Aug 2003 18:11:03 -0700
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308021811.03712.miles.lane@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/ppc/kernel/setup.o
arch/ppc/kernel/setup.c: In function `ppc_init':
arch/ppc/kernel/setup.c:587: warning: implicit declaration of function 
`register_cpu'
arch/ppc/kernel/setup.c:587: error: invalid use of undefined type `struct cpu'
include/asm/pmac_feature.h: At top level:
arch/ppc/kernel/setup.c:575: error: storage size of `cpu_devices' isn't known
make[1]: *** [arch/ppc/kernel/setup.o] Error 1

CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Platform support
#
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y
# CONFIG_40x is not set
# CONFIG_POWER3 is not set
# CONFIG_8xx is not set

#
# IBM 4xx options
#
CONFIG_PM=y
# CONFIG_8260 is not set
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_MULTIPLATFORM=y
CONFIG_PPC_CHRP=y
CONFIG_PPC_PMAC=y
CONFIG_PPC_PREP=y
CONFIG_PPC_OF=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_ALTIVEC=y
CONFIG_TAU=y
# CONFIG_TAU_INT is not set
CONFIG_TAU_AVERAGE=y
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_PMAC=y

CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_KCORE_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
CONFIG_I82092=y

