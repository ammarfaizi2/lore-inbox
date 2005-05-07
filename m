Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVEGILB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVEGILB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVEGILB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:11:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45218 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S261557AbVEGIKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:10:51 -0400
Date: Sat, 07 May 2005 17:09:11 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 2/17] ARMNOMMU - nommu/mpu patch for arch/arm/mm/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400CMI1E0SY@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3Ays27ihl/FpTzy2PufAmwn2Ng==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [2/17]
 
- nommu/mpu patch for arch/arm/mm/*

 arch/arm/mm/Kconfig            |  144 +++++++++++----
 arch/arm/mm/Makefile           |   12 +
 arch/arm/mm/cache-v4.S         |   10 +
 arch/arm/mm/consistent-nommu.c |  207 ++++++++++++++++++++++
 arch/arm/mm/fault.c            |   20 ++
 arch/arm/mm/fault.h            |    3
 arch/arm/mm/init.c             |   57 +++++-
 arch/arm/mm/ioremap.c          |   12 +
 arch/arm/mm/mm-armv.c          |   19 ++
 arch/arm/mm/proc-arm1020.S     |   21 ++
 arch/arm/mm/proc-arm1020e.S    |   21 ++
 arch/arm/mm/proc-arm1022.S     |   21 ++
 arch/arm/mm/proc-arm1026.S     |   21 ++
 arch/arm/mm/proc-arm6_7.S      |   37 +++
 arch/arm/mm/proc-arm720.S      |   29 +++
 arch/arm/mm/proc-arm740.S      |  333 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-arm7tdmi.S    |  384
+++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-arm920.S      |   21 ++
 arch/arm/mm/proc-arm922.S      |   22 ++
 arch/arm/mm/proc-arm925.S      |   25 ++
 arch/arm/mm/proc-arm926.S      |   21 ++
 arch/arm/mm/proc-arm940.S      |  215 ++++++++++++++++++++++
 arch/arm/mm/proc-arm946.S      |  212 ++++++++++++++++++++++
 arch/arm/mm/proc-arm9tdmi.S    |  255 +++++++++++++++++++++++++++
 arch/arm/mm/proc-s3c4510b.S    |  383
++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-sa110.S       |   20 ++
 arch/arm/mm/proc-sa1100.S      |   24 ++
 arch/arm/mm/proc-syms.c        |    3
 arch/arm/mm/proc-v6.S          |   28 ++
 arch/arm/mm/proc-xscale.S      |    3
 30 files changed, 2532 insertions(+), 51 deletions(-)

 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-arm_mm.pat
ch.bz2

---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

