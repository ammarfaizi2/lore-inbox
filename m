Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267896AbTBVNIk>; Sat, 22 Feb 2003 08:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBVNIk>; Sat, 22 Feb 2003 08:08:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:640 "EHLO bilbo.tmr.com")
	by vger.kernel.org with ESMTP id <S267896AbTBVNIj>;
	Sat, 22 Feb 2003 08:08:39 -0500
Date: Sat, 22 Feb 2003 08:18:43 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.4.21-pre4-ac5] make dep - Circular dependencies
Message-ID: <Pine.LNX.4.44.0302220815440.5038-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Circular /usr/src/linux-2.4.21-pre4-ac5/include/asm/smplock.h <- /usr/src/linux-2.4.21-pre4-ac5/include/linux/interrupt.h dependency dropped.
make[1]: Circular /usr/src/linux-2.4.21-pre4-ac5/include/linux/netfilter_ipv4/ip_conntrack_helper.h <- /usr/src/linux-2.4.21-pre4-ac5/include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped.

Happened to note this as it flashed by, the kernel is still building so I 
don't know if it matters.

Built on 2.5.61-ac1 kernel with gcc 2.96 (RH 7.3) if it matters.

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


