Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWE0RXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWE0RXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 13:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWE0RXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 13:23:24 -0400
Received: from saltmine.radix.net ([207.192.128.40]:18371 "EHLO
	saltmine.radix.net") by vger.kernel.org with ESMTP id S964918AbWE0RXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 13:23:23 -0400
Date: Sat, 27 May 2006 13:23:22 -0400 (EDT)
From: Marshall DeBerry <mdb@radix.net>
Message-Id: <200605271723.k4RHNMsk015026@saltmine.radix.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: udev "unable to handle kernel paging request" FC5 2.6.16-1.2122
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over the past several kernel upgrades, I've begun to have problems getting
past the udev section of FC5.  Sometimes I get the "unable to handle kernel
paging request" message at the udev, other times it just sits until I turn 
the machine off, sometimes it seems to generate an oops, and dumps until
I turn the machine off.  Some of the dump messages have the following:
do_page_fault + 0x0/0x51d or do_page_fault + 0x8a/0x51d repeated over and over.

Machine is a Dell 4550, with the following info:
Linux version 2.6.16-1.2122_FC5
Cpuinfo: Intel(R) Pentium(R) 4 CPU 2.53GHz
Firewire: FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller
Video:  ATI Technologies Inc Radeon RV250 [Radeon 9000]
PCI Bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP
Sound card: Creative Labs [SB Live! Value] EMU10k1X
Ethernet: Intel Corporation 82801DB PRO/100 VE (LOM)
Modem:  Conexant Unknown device 2702 (rev 01)
Mouse:  Logitech USB Optical Mouse
Memory:  1035444 kB

I haven't been able to get a complete copy of the dump when it happens, but
was able to copy the do_page_faults by hand this last fault.

Any insights would be appreciated.
