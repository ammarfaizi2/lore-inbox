Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUJaQnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUJaQnk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 11:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUJaQnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 11:43:40 -0500
Received: from mx.ipex.cz ([212.71.175.4]:17359 "EHLO adriana.gin.cz")
	by vger.kernel.org with ESMTP id S261276AbUJaQnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 11:43:25 -0500
Message-ID: <41851626.4090203@seznam.cz>
Date: Sun, 31 Oct 2004 17:43:18 +0100
From: Robert Zacek <robert.zacek@seznam.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sis900 phy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i've problem with sis900 on acer aspire 1703_SM2.6,
limited rate:
max rx 50K/s
max tx 400K/s

what about patches here http://teg.homeunix.org/sis900.html?
any fix?

thanks

--lspci--
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100 Ethernet (rev 91)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0028
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 173 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 2000 [size=256]
        Region 1: Memory at e4005000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
--lspci--

--dmesg--
Linux version 2.6.9 (root@darkstar) (gcc version 3.2.2) #3 Sun Oct 31 
17:57:50 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fdf0000 (usable)
 BIOS-e820: 000000001fdf0000 - 000000001fdfb000 (ACPI data)
 BIOS-e820: 000000001fdfb000 - 000000001fe00000 (ACPI NVS)
 BIOS-e820: 000000001fe00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
509MB LOWMEM available.
On node 0 totalpages: 130544
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126448 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=sis2 root=1605
Initializing CPU#0
CPU 0 irqstacks, hard=c045c000 soft=c045b000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2601.132 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513508k/522176k available (2347k kernel code, 8112k reserved, 
929k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5128.19 BogoMIPS (lpj=2564096)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9c6, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
PCI: Using IRQ router SIS [1039/0962] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: IRQ 0 for device 0000:00:02.3 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: IRQ 0 for device 0000:00:02.6 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 5 for device 0000:00:02.6
PCI: Sharing IRQ 5 with 0000:00:02.7
PCI: IRQ 0 for device 0000:00:03.3 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try 
pci=usepirqmask
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1099242210.754:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
i8042.c: Detected active multiplexing controller, rev 1.9.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:02.6 (0000 -> 0001)
PCI: Found IRQ 5 for device 0000:00:02.6
PCI: Sharing IRQ 5 with 0000:00:02.7
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
Probing IDE interface ide1...
hdc: ST380012A, ATA DISK drive
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 1024KiB
hdc: 156301488 sectors (80026 MB) w/1024KiB Cache, CHS=16383/255/63
hdc: cache flushes supported
 hdc: hdc1 hdc2 < hdc5 hdc6 >
hda: ATAPI 31X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
PCI: Enabling device 0000:00:03.3 (0000 -> 0002)
PCI: IRQ 0 for device 0000:00:03.3 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Assigned IRQ 10 for device 0000:00:03.3
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 10, pci mem e0800000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 
07:17:53 2004 UTC).
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)
PCI: Found IRQ 5 for device 0000:00:02.7
PCI: Sharing IRQ 5 with 0000:00:02.6
intel8x0_measure_ac97_clock: measured 49322 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: SiS SI7012 at 0x1c00, irq 5
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4079 buckets, 32632 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
kjournald starting.  Commit interval 5 seconds
Adding 2040212k swap on /dev/hdc6.  Priority:-1 extents:1
EXT3 FS on hdc5, internal journal
sis900.c: v1.08.07 11/02/2003
PCI: Found IRQ 10 for device 0000:00:04.0
/**************************************************************************/
eth0: Unknown PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x2000, IRQ 10, 00:c0:9f:2b:a8:63.
/**************************************************************************/
spurious 8259A interrupt: IRQ7.




