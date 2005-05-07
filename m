Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVEGIUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVEGIUn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVEGIPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:15:50 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16803 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262790AbVEGIMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:12:48 -0400
Date: Sat, 07 May 2005 17:11:06 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 12/17] ARMNOMMU - platform patch for s3c3410
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400COZ1H8SY@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3FGsSASCGmS6TSmVpcf8DvQscA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [12/17]
 
- platform patch for s3c3410
 
 arch/arm/mach-s3c3410/Kconfig              |   33 ++
 arch/arm/mach-s3c3410/Makefile             |    7
 arch/arm/mach-s3c3410/arch.c               |   55 ++++
 arch/arm/mach-s3c3410/dma.c                |   26 +
 arch/arm/mach-s3c3410/head.S               |   70 +++++
 arch/arm/mach-s3c3410/irq.c                |  131 +++++++++
 arch/arm/mach-s3c3410/mm.c                 |   21 +
 arch/arm/mach-s3c3410/time.c               |   96 +++++++
 include/asm-arm/arch-s3c3410/dma.h         |   26 +
 include/asm-arm/arch-s3c3410/entry-macro.S |   38 ++
 include/asm-arm/arch-s3c3410/hardware.h    |   27 ++
 include/asm-arm/arch-s3c3410/io.h          |   67 +++++
 include/asm-arm/arch-s3c3410/irq.h         |   24 +
 include/asm-arm/arch-s3c3410/irqs.h        |   48 +++
 include/asm-arm/arch-s3c3410/keyboard.h    |   21 +
 include/asm-arm/arch-s3c3410/memory.h      |   25 +
 include/asm-arm/arch-s3c3410/param.h       |    6
 include/asm-arm/arch-s3c3410/s3c3410.h     |  384
+++++++++++++++++++++++++++++
 include/asm-arm/arch-s3c3410/sizes.h       |   52 +++
 include/asm-arm/arch-s3c3410/system.h      |   29 ++
 include/asm-arm/arch-s3c3410/time.h        |   23 +
 include/asm-arm/arch-s3c3410/timex.h       |   27 ++
 include/asm-arm/arch-s3c3410/vmalloc.h     |   35 ++
 23 files changed, 1271 insertions(+)
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-s3c3410.pa
tch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

