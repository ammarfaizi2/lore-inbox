Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264297AbTCXQei>; Mon, 24 Mar 2003 11:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264243AbTCXQbJ>; Mon, 24 Mar 2003 11:31:09 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:29930 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264267AbTCXQar>; Mon, 24 Mar 2003 11:30:47 -0500
Message-Id: <200303241641.h2OGfv35008196@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:44 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Add missing intel cache descriptor
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/intel.c linux-2.5/arch/i386/kernel/cpu/intel.c
--- bk-linus/arch/i386/kernel/cpu/intel.c	2003-03-08 09:56:26.000000000 +0000
+++ linux-2.5/arch/i386/kernel/cpu/intel.c	2003-03-19 18:46:49.000000000 +0000
@@ -100,6 +131,7 @@ static struct _cache_table cache_table[]
 	{ 0x25, LVL_3,      2048 },
 	{ 0x29, LVL_3,      4096 },
 	{ 0x39, LVL_2,      128 },
+	{ 0x3b, LVL_2,      128 },
 	{ 0x3C, LVL_2,      256 },
 	{ 0x41, LVL_2,      128 },
 	{ 0x42, LVL_2,      256 },
