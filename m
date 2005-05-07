Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVEGINt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVEGINt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVEGINn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:13:43 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:35236 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262784AbVEGIMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:12:12 -0400
Date: Sat, 07 May 2005 17:10:33 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 8/17] ARMNOMMU - platform patch for espd_4510b
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GR11GANY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3D0X3l/E9fCvQyqEUpLTvpMPSQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [8/17]

- platform patch for espd_4510b

 arch/arm/mach-espd_4510b/Kconfig              |   26 ++
 arch/arm/mach-espd_4510b/Makefile             |    7
 arch/arm/mach-espd_4510b/Makefile.boot        |    4
 arch/arm/mach-espd_4510b/arch.c               |   44 ++++
 arch/arm/mach-espd_4510b/dma.c                |   26 ++
 arch/arm/mach-espd_4510b/head.S               |   97 +++++++++
 arch/arm/mach-espd_4510b/irq.c                |  123 ++++++++++++
 arch/arm/mach-espd_4510b/mm.c                 |   17 +
 arch/arm/mach-espd_4510b/time.c               |  119 ++++++++++++
 include/asm-arm/arch-espd_4510b/dma.h         |   29 ++
 include/asm-arm/arch-espd_4510b/entry-macro.S |   27 ++
 include/asm-arm/arch-espd_4510b/hardware.h    |   30 +++
 include/asm-arm/arch-espd_4510b/io.h          |   67 ++++++
 include/asm-arm/arch-espd_4510b/irq.h         |   27 ++
 include/asm-arm/arch-espd_4510b/irqs.h        |   42 ++++
 include/asm-arm/arch-espd_4510b/keyboard.h    |   21 ++
 include/asm-arm/arch-espd_4510b/memory.h      |   25 ++
 include/asm-arm/arch-espd_4510b/param.h       |    6
 include/asm-arm/arch-espd_4510b/s3c4510b.h    |  255
++++++++++++++++++++++++++
 include/asm-arm/arch-espd_4510b/sizes.h       |   52 +++++
 include/asm-arm/arch-espd_4510b/system.h      |   27 ++
 include/asm-arm/arch-espd_4510b/time.h        |   31 +++
 include/asm-arm/arch-espd_4510b/timex.h       |   27 ++
 include/asm-arm/arch-espd_4510b/uart.h        |  114 +++++++++++
 include/asm-arm/arch-espd_4510b/uncompress.c  |   69 +++++++
 include/asm-arm/arch-espd_4510b/uncompress.h  |   50 +++++
 include/asm-arm/arch-espd_4510b/vmalloc.h     |   35 +++
 27 files changed, 1397 insertions(+)
 
Signed-off-by: Jiun-Shian Ho <asky@syncom.com.tw>
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-espd_4510b
.patch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

