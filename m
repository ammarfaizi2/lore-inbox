Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVEGI2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVEGI2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVEGI1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:27:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22947 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262791AbVEGINE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:13:04 -0400
Date: Sat, 07 May 2005 17:11:23 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 14/17] ARMNOMMU - platform patch for s5c7375
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GSO1HPNY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3Fu2/LftcpdFS3GSarIAnBaHJg==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [14/17]
 
- platform patch for s5c7375
 
 arch/arm/mach-s5c7375/Kconfig              |    3
 arch/arm/mach-s5c7375/Makefile             |    7
 arch/arm/mach-s5c7375/Makefile.boot        |    2
 arch/arm/mach-s5c7375/arch.c               |   56 ++++
 arch/arm/mach-s5c7375/dma.c                |   39 ++
 arch/arm/mach-s5c7375/head.S               |  163 ++++++++++++
 arch/arm/mach-s5c7375/irq.c                |  148 +++++++++++
 arch/arm/mach-s5c7375/time.c               |  104 +++++++
 include/asm-arm/arch-s5c7375/blkmem.h      |   25 +
 include/asm-arm/arch-s5c7375/dma.h         |  141 ++++++++++
 include/asm-arm/arch-s5c7375/entry-macro.S |   57 ++++
 include/asm-arm/arch-s5c7375/hardware.h    |   31 ++
 include/asm-arm/arch-s5c7375/io.h          |   69 +++++
 include/asm-arm/arch-s5c7375/irq.h         |   40 +++
 include/asm-arm/arch-s5c7375/irqs.h        |  124 +++++++++
 include/asm-arm/arch-s5c7375/memory.h      |   30 ++
 include/asm-arm/arch-s5c7375/param.h       |    6
 include/asm-arm/arch-s5c7375/s5c7375.h     |  384
+++++++++++++++++++++++++++++
 include/asm-arm/arch-s5c7375/sizes.h       |   52 +++
 include/asm-arm/arch-s5c7375/system.h      |   63 ++++
 include/asm-arm/arch-s5c7375/time.h        |   88 ++++++
 include/asm-arm/arch-s5c7375/timex.h       |   27 ++
 include/asm-arm/arch-s5c7375/uncompress.h  |   58 ++++
 include/asm-arm/arch-s5c7375/vmalloc.h     |   35 ++
 24 files changed, 1752 insertions(+)
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-s5c7375.pa
tch.bz2 
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

