Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVEGIM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVEGIM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVEGIMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:12:55 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:11683 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262787AbVEGIMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:12:31 -0400
Date: Sat, 07 May 2005 17:10:50 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 10/17] ARMNOMMU - platform patch for P2001
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG40016R1GSL0@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3EfZOxU2DkYYSlC7O5BUUiWBBQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [10/17]
 
- platform patch for P2001
 
 arch/arm/mach-p2001/Kconfig              |   61 +++++
 arch/arm/mach-p2001/Makefile             |    9
 arch/arm/mach-p2001/Makefile.boot        |    3
 arch/arm/mach-p2001/arch.c               |   95 ++++++++
 arch/arm/mach-p2001/entry-macro.S        |  168 ++++++++++++++
 arch/arm/mach-p2001/head.S               |   95 ++++++++
 arch/arm/mach-p2001/irq.c                |  165 ++++++++++++++
 arch/arm/mach-p2001/p2001_cpufreq.c      |  286 +++++++++++++++++++++++++
 arch/arm/mach-p2001/time.c               |  273 ++++++++++++++++++++++++
 include/asm-arm/arch-p2001/debug-macro.S |   37 +++
 include/asm-arm/arch-p2001/dma.h         |   32 ++
 include/asm-arm/arch-p2001/entry-macro.S |  168 ++++++++++++++
 include/asm-arm/arch-p2001/hardware.h    |  351
+++++++++++++++++++++++++++++++
 include/asm-arm/arch-p2001/io.h          |   36 +++
 include/asm-arm/arch-p2001/irq.h         |   32 ++
 include/asm-arm/arch-p2001/irqs.h        |   42 +++
 include/asm-arm/arch-p2001/memory.h      |   33 ++
 include/asm-arm/arch-p2001/param.h       |   16 +
 include/asm-arm/arch-p2001/system.h      |   32 ++
 include/asm-arm/arch-p2001/timex.h       |   17 +
 include/asm-arm/arch-p2001/uncompress.h  |   43 +++
 include/asm-arm/arch-p2001/vmalloc.h     |   35 +++
 22 files changed, 2029 insertions(+)
 
Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-p2001.patc
h.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

