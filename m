Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbTLFQDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 11:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbTLFQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 11:03:16 -0500
Received: from burp.tkv.asdf.org ([212.16.99.49]:32927 "EHLO burp.tkv.asdf.org")
	by vger.kernel.org with ESMTP id S265203AbTLFQDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 11:03:14 -0500
Date: Sat, 6 Dec 2003 18:03:12 +0200
Message-Id: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org>
From: Markku Savela <msa@burp.tkv.asdf.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11, TSC cannot be used as a timesource.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen some references to above problem, but no clear answer. The
'ntpd' is complaining a lot...

I have ASUS P4S800. Here is some extracts from dmesg (I can provide
more complete dump, if anyone wants something specific.)

Linux version 2.6.0-test11 (root@moth) (gcc version 3.3.2 (Debian)) #2 SMP Thu Dec 4 22:32:52 EET 2003
...
Kernel command line: BOOT_IMAGE=Linux-2 ro root=301
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2400.326 MHz processor.
...
CPU: Hyper-Threading is disabled
...
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 365.75 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
...
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2399.0868 MHz.
..... host bus clock speed is 99.0994 MHz.
Starting migration thread for cpu 0
CPUS done 2
...
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Cannot allocate resource region 4 of device 0000:00:02.1
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=15000 from BIOS
radeonfb: probed DDR SGRAM 32768k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
radeonfb: ATI Radeon VE QY DDR SGRAM 32 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
...
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
...
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
...
Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
set_rtc_mmss: can't update from 59 to 0
