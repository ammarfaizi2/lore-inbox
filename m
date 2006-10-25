Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbWJYUII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbWJYUII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWJYUII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:08:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:23220 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S965206AbWJYUIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:08:04 -0400
Message-ID: <453FC465.2030603@gmail.com>
Date: Wed, 25 Oct 2006 22:09:09 +0200
From: giggz <giggzounet@gmail.com>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re : PROBLEM : Bus is hidden behind transparent bridge
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=A030AFA6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is the begenning of the log with pci=assign-busses

Oct 25 22:02:19 localhost syslogd 1.4.1#20: restart.
Oct 25 22:02:19 localhost kernel: klogd 1.4.1#20, log source =
/proc/kmsg started.
Oct 25 22:02:20 localhost kernel: Linux version 2.6.18.1-17
(giggz@debian) (gcc version 4.1.2 20061007 (prerelease) (Debian
4.1.1-16)) #1 PREEMPT Sat Oct 21 07:51:02 CEST 2006
Oct 25 22:02:20 localhost kernel: BIOS-provided physical RAM map:
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 0000000000000000 -
000000000009f800 (usable)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 000000000009f800 -
00000000000a0000 (reserved)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 00000000000d8000 -
00000000000e0000 (reserved)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 00000000000e4000 -
0000000000100000 (reserved)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 0000000000100000 -
000000007ff70000 (usable)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 000000007ff70000 -
000000007ff7b000 (ACPI data)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 000000007ff7b000 -
000000007ff80000 (ACPI NVS)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 000000007ff80000 -
0000000080000000 (reserved)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 00000000ff800000 -
00000000ffc00000 (reserved)
Oct 25 22:02:20 localhost kernel:  BIOS-e820: 00000000fffff000 -
0000000100000000 (reserved)
Oct 25 22:02:20 localhost kernel: 1151MB HIGHMEM available.
Oct 25 22:02:20 localhost kernel: 896MB LOWMEM available.
Oct 25 22:02:20 localhost kernel: DMI present.
Oct 25 22:02:20 localhost kernel: ACPI: PM-Timer IO Port: 0x1008
Oct 25 22:02:20 localhost kernel: Allocating PCI resources starting at
88000000 (gap: 80000000:7f800000)
Oct 25 22:02:20 localhost kernel: Detected 1794.338 MHz processor.
Oct 25 22:02:20 localhost kernel: Built 1 zonelists.  Total pages: 524144
Oct 25 22:02:20 localhost kernel: Kernel command line: root=/dev/hda1 ro
pci=assign-busses
Oct 25 22:02:20 localhost kernel: Local APIC disabled by BIOS -- you can
enable it with "lapic"
Oct 25 22:02:20 localhost kernel: Enabling fast FPU save and restore...
done.
Oct 25 22:02:20 localhost kernel: Enabling unmasked SIMD FPU exception
support... done.
Oct 25 22:02:20 localhost kernel: Initializing CPU#0
Oct 25 22:02:20 localhost kernel: PID hash table entries: 4096 (order:
12, 16384 bytes)
Oct 25 22:02:20 localhost kernel: Console: colour VGA+ 80x25
Oct 25 22:02:20 localhost kernel: Dentry cache hash table entries:
131072 (order: 7, 524288 bytes)
Oct 25 22:02:20 localhost kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Oct 25 22:02:20 localhost kernel: Memory: 2075696k/2096576k available
(1631k kernel code, 19724k reserved, 483k data, 148k init, 1179072k highmem)
Oct 25 22:02:20 localhost kernel: Checking if this processor honours the
WP bit even in supervisor mode... Ok.
Oct 25 22:02:20 localhost kernel: Calibrating delay using timer specific
routine.. 3589.52 BogoMIPS (lpj=1794763)
Oct 25 22:02:20 localhost kernel: Security Framework v1.0.0 initialized
Oct 25 22:02:20 localhost kernel: Capability LSM initialized
Oct 25 22:02:20 localhost kernel: Mount-cache hash table entries: 512
Oct 25 22:02:20 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Oct 25 22:02:20 localhost kernel: CPU: L2 cache: 2048K
Oct 25 22:02:20 localhost kernel: Intel machine check architecture
supported.
Oct 25 22:02:20 localhost kernel: Intel machine check reporting enabled
on CPU#0.
Oct 25 22:02:20 localhost kernel: CPU: Intel(R) Pentium(R) M processor
1.80GHz stepping 06
Oct 25 22:02:20 localhost kernel: Checking 'hlt' instruction... OK.
Oct 25 22:02:20 localhost kernel: ACPI: Core revision 20060707
Oct 25 22:02:20 localhost kernel: ACPI: setting ELCR to 0200 (from 0c00)
Oct 25 22:02:20 localhost kernel: NET: Registered protocol family 16
Oct 25 22:02:20 localhost kernel: ACPI: bus type pci registered
Oct 25 22:02:20 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xfd7d5, last bus=2
Oct 25 22:02:20 localhost kernel: PCI: Using configuration type 1
Oct 25 22:02:20 localhost kernel: Setting up standard PCI resources
Oct 25 22:02:20 localhost kernel: ACPI: Interpreter enabled
Oct 25 22:02:20 localhost kernel: ACPI: Using PIC for interrupt routing
Oct 25 22:02:20 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct 25 22:02:20 localhost kernel: PCI quirk: region 1000-107f claimed by
ICH4 ACPI/GPIO/TCO
Oct 25 22:02:20 localhost kernel: PCI quirk: region 1180-11bf claimed by
ICH4 GPIO
Oct 25 22:02:20 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller
0000:00:1f.1
Oct 25 22:02:20 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs
10 *11)
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs
10 *11)
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs
10) *11
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs
10 11) *0, disabled.
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs
10 11) *0, disabled.
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs
10 11) *0, disabled.
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs
*10 11)
Oct 25 22:02:20 localhost kernel: ACPI: Embedded Controller [EC0] (gpe
28) interrupt mode.
Oct 25 22:02:20 localhost kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Oct 25 22:02:20 localhost kernel: pnp: PnP ACPI init
Oct 25 22:02:20 localhost kernel: pnp: PnP ACPI: found 10 devices
Oct 25 22:02:20 localhost kernel: PnPBIOS: Disabled by ACPI PNP
Oct 25 22:02:20 localhost kernel: PCI: Using ACPI for IRQ routing
Oct 25 22:02:20 localhost kernel: PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Oct 25 22:02:20 localhost kernel: PCI: Bridge: 0000:00:01.0
Oct 25 22:02:20 localhost kernel:   IO window: 3000-3fff
Oct 25 22:02:20 localhost kernel:   MEM window: d0100000-d01fffff
Oct 25 22:02:20 localhost kernel:   PREFETCH window: d8000000-dfffffff
Oct 25 22:02:20 localhost kernel: PCI: Bus 3, cardbus bridge: 0000:02:09.0
Oct 25 22:02:20 localhost kernel:   IO window: 00004000-000040ff
Oct 25 22:02:20 localhost kernel:   IO window: 00004400-000044ff
Oct 25 22:02:20 localhost kernel:   PREFETCH window: 88000000-89ffffff
Oct 25 22:02:20 localhost kernel:   MEM window: 8e000000-8fffffff
Oct 25 22:02:20 localhost kernel: PCI: Bus 7, cardbus bridge: 0000:02:09.1
Oct 25 22:02:20 localhost kernel:   IO window: 00004800-000048ff
Oct 25 22:02:20 localhost kernel:   IO window: 00004c00-00004cff
Oct 25 22:02:20 localhost kernel:   PREFETCH window: 8a000000-8bffffff
Oct 25 22:02:20 localhost kernel:   MEM window: 90000000-91ffffff
Oct 25 22:02:20 localhost kernel: PCI: Bridge: 0000:00:1e.0
Oct 25 22:02:20 localhost kernel:   IO window: 4000-4fff
Oct 25 22:02:20 localhost kernel:   MEM window: d0200000-d02fffff
Oct 25 22:02:20 localhost kernel:   PREFETCH window: 88000000-8cffffff
Oct 25 22:02:20 localhost kernel: PCI: Enabling device 0000:00:1e.0
(0005 -> 0007)
Oct 25 22:02:20 localhost kernel: PCI: Enabling device 0000:02:09.0
(0000 -> 0003)
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKF]
enabled at IRQ 11
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt 0000:02:09.0[A] ->
Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt Link [LNKB]
enabled at IRQ 10
Oct 25 22:02:20 localhost kernel: ACPI: PCI Interrupt 0000:02:09.1[B] ->
Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 25 22:02:20 localhost kernel: NET: Registered protocol family 2
Oct 25 22:02:20 localhost kernel: IP route cache hash table entries:
32768 (order: 5, 131072 bytes)
Oct 25 22:02:20 localhost kernel: TCP established hash table entries:
262144 (order: 8, 1048576 bytes)
Oct 25 22:02:20 localhost kernel: TCP bind hash table entries: 65536
(order: 6, 262144 bytes)
Oct 25 22:02:20 localhost kernel: TCP: Hash tables configured
(established 262144 bind 65536)
Oct 25 22:02:20 localhost kernel: TCP reno registered
Oct 25 22:02:20 localhost kernel: Simple Boot Flag at 0x36 set to 0x1
Oct 25 22:02:20 localhost kernel: Machine check exception polling timer
started.
Oct 25 22:02:20 localhost kernel: highmem bounce pool size: 64 pages
Oct 25 22:02:20 localhost kernel: Initializing Cryptographic API
Oct 25 22:02:20 localhost kernel: io scheduler noop registered
Oct 25 22:02:20 localhost kernel: io scheduler anticipatory registered
Oct 25 22:02:20 localhost kernel: io scheduler deadline registered
Oct 25 22:02:20 localhost kernel: io scheduler cfq registered (default)
- --
GT> kwyxz: hum, tu sais comment buter des zombies sous nux ?
k> GT: en root, tu tapes "init 6"  <-- GT has quit (EOF From client)
k> Hop, plus de zombies !
- -+- kwyxz in Guide du Fmblien Assassin : "Bande de zombies !" -+-
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFP8RlRvQAQ6Awr6YRAsPvAJ9IxN6XtRkOlthFRbsrf1YI2XTDpgCgpDJ8
AfzRORfAGkMtWkBQ8DhSNNs=
=sTyO
-----END PGP SIGNATURE-----
