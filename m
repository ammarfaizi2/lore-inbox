Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267585AbSLMBeL>; Thu, 12 Dec 2002 20:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267587AbSLMBeL>; Thu, 12 Dec 2002 20:34:11 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:26830
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267585AbSLMBdC>; Thu, 12 Dec 2002 20:33:02 -0500
Date: Thu, 12 Dec 2002 20:43:35 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Martin Bligh <mbligh@us.ibm.com>
Subject: [PATCH][2.5] x86_summit typo(?)
Message-ID: <Pine.LNX.4.50.0212121202180.23467-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This looks like a typo judging from the code in
arch/i386/mach-summit

Index: linux-2.5.51-bochs/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mpparse.c
--- linux-2.5.51-bochs/arch/i386/kernel/mpparse.c	10 Dec 2002 12:46:46 -0000	1.1.1.1
+++ linux-2.5.51-bochs/arch/i386/kernel/mpparse.c	12 Dec 2002 04:40:26 -0000
@@ -70,7 +70,7 @@
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;

-int summit_x86 = 0;
+int x86_summit = 0;
 u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };

 /*

-- 
function.linuxpower.ca
