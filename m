Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290811AbSBFVJX>; Wed, 6 Feb 2002 16:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290810AbSBFVJR>; Wed, 6 Feb 2002 16:09:17 -0500
Received: from h108-129-61.datawire.net ([207.61.129.108]:28173 "HELO
	mail.datawire.net") by vger.kernel.org with SMTP id <S290811AbSBFVI7>;
	Wed, 6 Feb 2002 16:08:59 -0500
Subject: IBM ThinkPad - Redundant entry in serial pci_table
From: Shawn Starr <shawn.starr@datawire.net>
To: Linux <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 06 Feb 2002 16:12:11 -0500
Message-Id: <1013029931.15007.2.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (115d,000c,8086,2408)
to serial-pci-info@lists.sourceforge.net.
  options:  [pci] [cardbus] [pm]

Linux kernel 2.4.17 vanilla

lspci -vv output:

-----
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=07, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 09)
	Subsystem: Intel Corporation: Unknown device 2408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8120000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:03.1 Serial controller: Xircom: Unknown device 000c (prog-if 02
[16550])
	Subsystem: Intel Corporation: Unknown device 2408
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1840 [size=8]
	Region 1: Memory at e8121000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: IBM: Unknown device 0153
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8122000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1850 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1860 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-/IX (rev
13) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 017f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2

----

dmesg output:

Linux version 2.4.17 (root@somemachine) (gcc version 2.95.3 20010315
(release)) #2 SMP Tue Jan 29 18:13:06 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Kernel command line: ro root=/dev/hda4
Initializing CPU#0
Detected 796.541 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1589.24 BogoMIPS
Memory: 254716k/262080k available (1717k kernel code, 6976k reserved,
488k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.10 usecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
NTFS driver v1.1.21 [Flags: R/O]
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (115d,000c,8086,2408)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
lp0: using parport0 (polling).
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1850-0x1857, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1858-0x185f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-220, ATA DISK drive
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2584/240/63,
UDMA(33)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 < hda5 > hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
eth0: OEM i82557/i82558 10/100 Ethernet, 00:10:A4:8F:44:39, IRQ 11.
  Board assembly 000695-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel 440BX @ 0xf8000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
ide-floppy driver 0.97.sv
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:02.0
PCI: Sharing IRQ 11 with 00:05.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Found IRQ 11 for device 00:02.1
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
usb-uhci.c: $Revision: 1.268 $ time 18:09:15 Jan 29 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1860, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF cff52ee0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: 1860
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cff52ee0
usb.c: call_policy add, num 1 -- no FS yet
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2047 buckets, 16376 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Adding Swap: 529192k swap-space (priority -1)
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
snd: cs461x: hack for Thinkpad 600X/A20/T20 enabled
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: SPCR_RUNFR never reset
snd: cs461x: AC'97 write problem, reg = 0x0, val = 0x0
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7c
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7e
snd: The AC'97 access is not valid, removing mixer.
snd: cs461x: AC'97 write problem, reg = 0x26, val = 0x300
snd: Sound Fusion CS461x soundcard #1 not found or device busy
snd: cs461x: hack for Thinkpad 600X/A20/T20 enabled
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: SPCR_RUNFR never reset
snd: cs461x: AC'97 write problem, reg = 0x0, val = 0x0
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7c
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7e
snd: The AC'97 access is not valid, removing mixer.
snd: cs461x: AC'97 write problem, reg = 0x26, val = 0x300
snd: Sound Fusion CS461x soundcard #1 not found or device busy
snd: cs461x: hack for Thinkpad 600X/A20/T20 enabled
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: SPCR_RUNFR never reset
snd: cs461x: AC'97 write problem, reg = 0x0, val = 0x0
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7c
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7e
snd: The AC'97 access is not valid, removing mixer.
snd: cs461x: AC'97 write problem, reg = 0x26, val = 0x300
snd: Sound Fusion CS461x soundcard #1 not found or device busy
snd: cs461x: hack for Thinkpad 600X/A20/T20 enabled
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: SPCR_RUNFR never reset
snd: cs461x: AC'97 write problem, reg = 0x0, val = 0x0
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7c
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7e
snd: The AC'97 access is not valid, removing mixer.
snd: cs461x: AC'97 write problem, reg = 0x26, val = 0x300
snd: Sound Fusion CS461x soundcard #1 not found or device busy
keyboard: unknown scancode e0 63
keyboard: unknown scancode e0 63
snd: cs461x: hack for Thinkpad 600X/A20/T20 enabled
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x26
snd: cs461x: SPCR_RUNFR never reset
snd: cs461x: AC'97 write problem, reg = 0x0, val = 0x0
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7c
snd: cs461x: AC'97 read problem (ACCTL_DCV), reg = 0x7e
snd: The AC'97 access is not valid, removing mixer.
snd: cs461x: AC'97 write problem, reg = 0x26, val = 0x300
snd: Sound Fusion CS461x soundcard #1 not found or device busy
VFS: Disk change detected on device ide1(22,0)

-- 
Shawn Starr
Software Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008

