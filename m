Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVEGIKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVEGIKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVEGIKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:10:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:8356 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262776AbVEGIKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:10:37 -0400
Date: Sat, 07 May 2005 17:08:57 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 1/17] ARMNOMMU - nommu/mpu patch for arch/arm/kernel/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG40014N1DNL0@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3ARlztbExuh/RxWCyG6k8a0tRQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [1/17]

- nommu/mpu patch for arch/arm/kernel/*

 arch/arm/kernel/Makefile       |    9 +-
 arch/arm/kernel/calls.S        |   16 +++
 arch/arm/kernel/entry-armv.S   |    8 +
 arch/arm/kernel/entry-common.S |    2
 arch/arm/kernel/head-common.S  |  171
+++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/head-nommu.S   |  119 ++++++++++++++++++++++++++++
 arch/arm/kernel/head.S         |  162
--------------------------------------
 arch/arm/kernel/module.c       |    8 +
 arch/arm/kernel/process.c      |    4
 arch/arm/kernel/setup.c        |   42 ++++++++++
 arch/arm/kernel/sys_arm.c      |    2
 arch/arm/kernel/traps.c        |   25 +++++
 arch/arm/kernel/vmlinux.lds.S  |    2
 13 files changed, 402 insertions(+), 168 deletions(-)

Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-arm_kernel
.patch.bz2

---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

