Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWI1VfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWI1VfE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWI1VfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:35:03 -0400
Received: from polish-dvd.com ([69.222.0.225]:18621 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S964900AbWI1VfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:35:01 -0400
Message-ID: <20060928160920.8r3tutazc9zv4sc4@69.222.0.225>
Date: Thu, 28 Sep 2006 16:09:20 -0500
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: 2.6.18.git9 SMP x86_64 boot & compilation problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18.git9 SMP x86_64 boot & compilation problem

[xxx@localhost linux-2.6.18]$ make -j 4
   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CHK     include/linux/compile.h
   MODPOST vmlinux
Kernel: arch/x86_64/boot/bzImage is ready  (#1)
   Building modules, stage 2.
   MODPOST 1164 modules
WARNING: arch/x86_64/kernel/cpufreq/acpi-cpufreq.o - Section mismatch:  
reference to .init.data: from .text between 'acpi_cpufreq_cpu_init'  
(at offset 0x3b9) and 'acpi_cpufreq_target'
[xxx@localhost linux-2.6.18]$

boot hungs up !!!
3 last lines from screen at boot time:

...
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS@K] at 0x60,0x64 irq1
PNP: PS/2 controller doesn't have AUX irq: using default 12

last working version is 2.6.18-git6

xboom
art@usfltd.com
