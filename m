Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbUKREOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbUKREOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 23:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbUKREOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 23:14:38 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:9918 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262396AbUKREOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 23:14:35 -0500
From: kernel-stuff@comcast.net
To: linux-kernel@vger.kernel.org
Subject: RE: X86_64: Many Lost ticks
Date: Thu, 18 Nov 2004 04:14:34 +0000
Message-Id: <111820040414.17445.419C21AA000479CA00004425220076370400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 11 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might help if I provided the kernel version :)

I have tested with stock kernel 2.6.9 and Fedora Core 3 kernel - problem happens with both of them. Here is the CPU info, and /proc/interrupts -

/proc/cpuinfo
=============
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 8
cpu MHz         : 797.954
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 1581.05
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

/proc/interrupts
============================
           CPU0
  0:    2073747          XT-PIC  timer
  1:       5602          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc
  9:       2791          XT-PIC  acpi
 10:       9921          XT-PIC  NVidia nForce3 Modem, ehci_hcd, ohci_hcd, yenta, eth0
 11:     129885          XT-PIC  NVidia nForce3, ohci_hcd, yenta, ohci1394, nvidia
 12:      53655          XT-PIC  i8042
 14:      24671          XT-PIC  ide0
 15:      18174          XT-PIC  ide1
NMI:        485
LOC:    2069605
ERR:          1
MIS:          0
