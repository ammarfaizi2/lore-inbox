Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbTHCAZi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 20:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270455AbTHCAZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 20:25:38 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:53713 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S270453AbTHCAZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 20:25:28 -0400
Date: Sun, 3 Aug 2003 02:24:38 +0200
To: linux-kernel@vger.kernel.org
Subject: ACPI Error with 2.4.20-pre10 on ibm thinkpad
Message-ID: <20030803002438.GA15097@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19j6fu-0003vk-00*jfKUD5LNxFA* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




		hy,

I try to use acpi on my new IBM thinkpad r40 but it won't work:

Kernel: 2.4.22-pre10

Config: 

CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_RELAXED_AML=y


I got this errors: 


Linux version 2.4.22-pre10 (ruben@work) (gcc-Version 3.3.1 20030626 (Debian prerelease)) #1 Sam Aug 2 23:03:02 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff79000 (ACPI data)
 BIOS-e820: 000000001ff79000 - 000000001ff7b000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 130912
zone(0): 4096 pages.
zone(1): 126816 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f6d40
ACPI: XSDT (v001 IBM    TP-1P    00000.04352) @ 0x1ff6f4f3
ACPI: FADT (v003 IBM    TP-1P    00000.04352) @ 0x1ff6f600
ACPI: SSDT (v001 IBM    TP-1P    00000.04352) @ 0x1ff6f7b4
ACPI: ECDT (v001 IBM    TP-1P    00000.04352) @ 0x1ff78e96
ACPI: TCPA (v001 IBM    TP-1P    00000.04352) @ 0x1ff78ee8
ACPI: BOOT (v001 IBM    TP-1P    00000.04352) @ 0x1ff78fd8
ACPI: DSDT (v001 IBM    TP-1P    00000.04352) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: BOOT_IMAGE=Linux ro root=302
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1498.758 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2988.44 BogoMIPS
Memory: 514204k/523648k available (2185k kernel code, 9056k reserved, 773k data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: a7e9fbbf 00000000 00000000 00000000
CPU:             Common caps: a7e9fbbf 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1498.7099 MHz.
..... host bus clock speed is 99.9140 MHz.
cpu: 0, clocks: 999140, slice: 499570
CPU0<T0:999136,T1:499552,D:14,S:499570,C:999140>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfd936, last bus=5
PCI: Using configuration type 1
ACPI: Found ECDT
schedule_task(): keventd has not started
    ACPI-0165: *** Warning: The ACPI AML in your computer contains errors, please nag the manufacturer to correct it.
    ACPI-0168: *** Warning: Allowing relaxed access to fields; turn on CONFIG_ACPI_DEBUG for details.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
schedule_task(): keventd has not started
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
kmod: failed to exec /sbin/modprobe -s -k parport_lowlevel, errno = 2
lp: driver loaded but no devices found
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
i810_rng: RNG not detected
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel(R) 855PM chipset
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] AGP 0.99 on Unknown @ 0xd0000000 256MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-60B, ATA DISK drive
blk: queue c0434aa0, I/O limit 4095Mb (mask 0xffffffff)
hdc: MATSHITADVD-RAM UJ-810, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117210240 sectors (60012 MB) w/2048KiB Cache, CHS=7752/240/63, UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Intel 810 + AC97 Audio, version 0.24, 23:08:14 Aug  2 2003
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xc0000c00 and 0xc0000800, IRQ 5
i810: Intel ICH4 mmio at 0xe0868c00 and 0xe086a800
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 9, pci mem e086c000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
host/uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
host/uhci.c: USB UHCI at I/O 0x1820, IRQ 11
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
host/uhci.c: USB UHCI at I/O 0x1840, IRQ 10
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 14
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O LAN OSM (C) 1999 University of Helsinki.
i2o_scsi.c: Version 0.0.1
  chain_pool: 0 bytes @ dfd24680
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding Swap: 1050836k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
usb.c: registered new driver usbkbd
usbkbd.c: :USB HID Boot Protocol keyboard driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0098, PCI irq11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node c15ba320), AE_TIME
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node c15bbec0), AE_TIME
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node c15ba220), AE_TIME
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_PR_.CPU_._PPC] (Node c158d960), AE_TIME
ACPI: Processor [CPU] (supports C1 C2 C3, 6 performance states, 8 throttling states)
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_TZ_.THM0._TMP] (Node c15b5920), AE_TIME



After this I try patching 2.4.20-pre10 with the latest acpi patches result :


        -o vmlinux
arch/i386/kernel/kernel.o(.text.init+0x3c44): In function `abit_apic_required':
: undefined reference to `enable_apic_up'
arch/i386/kernel/kernel.o(.text.init+0x3c82): In function `abit_apic_required':
: undefined reference to `enable_apic_up'
arch/i386/kernel/kernel.o(.text.init+0x3fc0): In function `force_apic':
: undefined reference to `enable_apic_up'
make: *** [vmlinux] Error 1



The config was nearly the same.



			thanks for help

			Ruben



-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
