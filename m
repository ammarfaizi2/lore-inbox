Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSJHS4Z>; Tue, 8 Oct 2002 14:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261739AbSJHS4S>; Tue, 8 Oct 2002 14:56:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10768 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261718AbSJHS4H>; Tue, 8 Oct 2002 14:56:07 -0400
Subject: PATCH: missing cache tag
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:53:15 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzTn-0004r2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/arch/i386/kernel/cpu/intel.c linux.2.5.41-ac1/arch/i386/kernel/cpu/intel.c
--- linux.2.5.41/arch/i386/kernel/cpu/intel.c	2002-10-02 21:33:55.000000000 +0100
+++ linux.2.5.41-ac1/arch/i386/kernel/cpu/intel.c	2002-10-04 16:33:09.000000000 +0100
@@ -127,6 +127,7 @@
 	{ 0x7B, LVL_2,      512 },
 	{ 0x7C, LVL_2,      1024 },
 	{ 0x82, LVL_2,      256 },
+	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
 	{ 0x00, 0, 0}
