Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283265AbRLIJZu>; Sun, 9 Dec 2001 04:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283254AbRLIJZk>; Sun, 9 Dec 2001 04:25:40 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:5022 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283265AbRLIJZ2>; Sun, 9 Dec 2001 04:25:28 -0500
Date: Sun, 9 Dec 2001 11:27:59 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Comments on 2.4.17-pre5 and ATYFB
Message-ID: <Pine.LNX.4.33.0112091123520.1350-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.4.17-pre5 i don't get display corruption when i switch to a
console and
try and view some scrolling text (ie dmesg | less).

XFree86 Version 4.1.0 (Red Hat Linux release: 4.1.0-3) / X Window System
(1280x1024@16)

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 02)

atyfb: using auxiliary register aperture
atyfb: 3D RAGE IIC (AGP) [0x475a rev 0x3a] 8M SDRAM, 14.31818 MHz XTAL,
230 MHz
PLL, 83 Mhz MCLK
Console: switching to colour frame buffer device 80x25
fb0: ATY Mach64 frame buffer device on PCI

zwane@montezuma:~ $ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xdf000000 (3568MB), size=   8MB: write-combining, count=1

Thanks !

Regards,
        Zwane Mwaikambo


