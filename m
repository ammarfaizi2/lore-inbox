Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbTCGBMW>; Thu, 6 Mar 2003 20:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbTCGBMW>; Thu, 6 Mar 2003 20:12:22 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:37638 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261317AbTCGBMU>; Thu, 6 Mar 2003 20:12:20 -0500
Date: Fri, 7 Mar 2003 02:22:51 +0100 (CET)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.5.64] oops
Message-ID: <Pine.LNX.4.51L.0303070221460.23603@piorun.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c011c394>] __might_sleep+0x54/0x60
 [<c01a3111>] crypto_alg_lookup+0x21/0xd0
 [<d3948570>] in6addr_loopback+0x484/0x3d14 [ipv6]
 [<c01a411d>] crypto_alg_mod_lookup+0xd/0x30
 [<d3948570>] in6addr_loopback+0x484/0x3d14 [ipv6]
 [<c01a3301>] crypto_alloc_tfm+0x11/0xc0
 [<d3948570>] in6addr_loopback+0x484/0x3d14 [ipv6]
 [<d392e4f0>] __ipv6_regen_rndid+0xa0/0x200 [ipv6]
 [<d3948570>] in6addr_loopback+0x484/0x3d14 [ipv6]
 [<c011a86d>] wake_up_process+0xd/0x20
 [<d392e67e>] ipv6_regen_rndid+0x2e/0xc0 [ipv6]
 [<c01250c9>] run_timer_softirq+0xe9/0x140
 [<d392e650>] ipv6_regen_rndid+0x0/0xc0 [ipv6]
 [<c0121791>] do_softirq+0x51/0xb0
 [<c010c5d0>] do_IRQ+0xf0/0x110
 [<c010b04c>] common_interrupt+0x18/0x20
 [<c01c869e>] acpi_processor_idle+0xfe/0x210
 [<c01c85a0>] acpi_processor_idle+0x0/0x210
 [<c0109040>] default_idle+0x0/0x30
 [<c01090f5>] cpu_idle+0x35/0x40
 [<c01090f2>] cpu_idle+0x32/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c0105055>] rest_init+0x55/0x60


-- 
---------------------------------
pozdr.  Pawe³ Go³aszewski        
---------------------------------
CPU not found - software emulation...
