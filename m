Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVKIPUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVKIPUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVKIPUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:20:25 -0500
Received: from pm-mx6.mgn.net ([195.46.220.208]:50821 "EHLO pm-mx6.mx.noos.fr")
	by vger.kernel.org with ESMTP id S1751404AbVKIPUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:20:24 -0500
Date: Wed, 9 Nov 2005 16:20:10 +0100
From: Damien Wyart <damien.wyart@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CD Writer won't eject
Message-ID: <20051109152010.GA20694@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've noticed since a few days that my CD writer refuses to eject, either
by pushing the button or running the eject command. At first I did not
notice anything in the logs. Rebooting made the door of the drive work
again for a few hours, then it locked each time. Two days ago I noticed
a message from the kernel which seems related.

I include dmesg and related error message. For now I run 2.6.14rc5
because I am waiting for Namesys to release a clean reiser4 patch for
2.6.14. Does the problem ring a bell to someone ? I will try wil 2.6.14
ASAP. Maybe the drive itself is broken (it burns ok after rebooting, so
it is not completely broken).

Thanks in advance for any advice,

-- 
Damien Wyart

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.14-rc5-git-23102005dw (root@brouette) (gcc version 4.0.2 (Debian 4.0.2-2)) #1 SMP Sun Oct 23 20:33:45 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff74000 (usable)
 BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACPI NVS)
 BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACPI data)
 BIOS-e820: 000000003ff97000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 262004
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32628 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
ACPI: RSDT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1ca
ACPI: FADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1fe
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc929b
ACPI: MADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd272
ACPI: BOOT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd2de
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/sdb2 ro vga=0x31B selinux=0 elevator=cfq video=vesafb:mtrr:2 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2992.973 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034508k/1048016k available (2401k kernel code, 12684k reserved, 713k data, 192k init, 130512k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5988.77 BogoMIPS (lpj=2994389)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5984.17 BogoMIPS (lpj=2992085)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Total of 2 processors activated (11972.94 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0a: ioport range 0x800-0x85f could not be reserved
pnp: 00:0a: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0a: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fd000000-feafffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fcf00000-fcffffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Simple Boot Flag at 0x7a set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Loading Reiser4. See www.namesys.com for a description of Reiser4.
Initializing Cryptographic API
vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, using 10240k, total 131072k
vesafb: mode is 1280x1024x32, linelength=5120, pages=0
vesafb: protected mode interface info at c000:f080
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 169
e100: eth0: e100_probe: addr 0xfcfff000, irq 169, MAC addr 00:0C:F1:B6:BA:54
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide1...
hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW SW-252S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 16X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.12 loaded.
ata_piix version 1.04
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 177
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 177
ata1: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 144531250 sectors: lba48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 144531250 sectors: lba48
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/100
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
input: AT Translated Set 2 keyboard on isa0060/serio0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
logips2pp: Detected unknown logitech mouse model 63
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 185, io mem 0xffa80800
USB Universal Host Controller Interface driver v2.3
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 193, io base 0x0000ff80
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 201, io base 0x0000ff60
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
usb 2-1: new full speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 177, io base 0x0000ff40
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 193, io base 0x0000ff20
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 209
Adding 2048248k swap on /dev/sdb10.  Priority:-1 extents:1 across:2048248k
EXT3 FS on sdb2, internal journal
ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
ReiserFS: sdb5: using ordered data mode
ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb5: checking transaction log (sdb5)
ReiserFS: sdb5: Using r5 hash to sort names
ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
ReiserFS: sdb6: using ordered data mode
ReiserFS: sdb6: journal params: device sdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb6: checking transaction log (sdb6)
ReiserFS: sdb6: Using r5 hash to sort names
JFS: nTxBlock = 8087, nTxLock = 64696
SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
XFS mounting filesystem sdb9
Ending clean XFS mount for filesystem: sdb9
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

hdd: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdd: DMA disabled
hdd: ATAPI reset timed-out, status=0x80
hdc: DMA disabled
ide1: reset timed-out, status=0x90
hdd: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdd: drive not ready for command
hdd: ATAPI reset timed-out, status=0x80
ide1: reset timed-out, status=0x90
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c015e14e
*pde = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in: nls_iso8859_1 nls_cp437 vfat fat nvidia xfs jfs snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_ac97_bus snd_page_alloc snd_util_mem snd_hwdep uhci_hcd ehci_hcd snd usbcore soundcore parport_pc parport
CPU:    0
EIP:    0060:[<c015e14e>]    Tainted: P      VLI
EFLAGS: 00010286   (2.6.14-rc5-git-23102005dw) 
EIP is at create_empty_buffers+0x2c/0x8b
eax: 00000000   ebx: c1358d80   ecx: 00000010   edx: 00000010
esi: 00000000   edi: 00000000   ebp: f7b4d56c   esp: cd5e9c9c
ds: 007b   es: 007b   ss: 0068
Process kded (pid: 2523, threadinfo=cd5e8000 task=f78caa50)
Stack: c1358d80 00010000 00000001 c1358d80 c1358d80 f7b4d618 c015ee12 c1358d80 
       00010000 00000000 cd5e9d18 cd5e9cd4 f7b4d61c 00000000 00000001 c0241d4c 
       c18f0880 00000020 00010000 c0242026 f7b4d61c 00000008 da40b5b8 00000000 
Call Trace:
 [<c015ee12>] block_read_full_page+0x336/0x358
 [<c0241d4c>] radix_tree_node_alloc+0x1c/0x63
 [<c0242026>] radix_tree_insert+0x10c/0x148
 [<c013bdac>] add_to_page_cache+0xa2/0xb3
 [<c01431d3>] read_pages+0xda/0x12a
 [<c0163245>] blkdev_get_block+0x0/0x59
 [<c0143393>] __do_page_cache_readahead+0x170/0x175
 [<c01434de>] blockable_page_cache_readahead+0x63/0xc8
 [<c01436d7>] page_cache_readahead+0xf0/0x18a
 [<c013c821>] do_generic_mapping_read+0x4e6/0x66f
 [<c013cc0e>] __generic_file_aio_read+0x177/0x235
 [<c013c9aa>] file_read_actor+0x0/0xed
 [<c013cdf1>] generic_file_read+0xc3/0xe1
 [<c015a6e4>] __dentry_open+0x17e/0x1ff
 [<c015a7e6>] filp_open+0x81/0x88
 [<c0130413>] autoremove_wake_function+0x0/0x4b
 [<c015b346>] vfs_read+0x9d/0x177
 [<c015b70e>] sys_read+0x4b/0x74
 [<c0102d1f>] sysenter_past_esp+0x54/0x75
Code: 56 53 83 ec 0c 8b 5c 24 1c 8b 74 24 24 c7 44 24 08 01 00 00 00 8b 44 24 20 89 44 24 04 89 1c 24 e8 5f f5 ff ff 89 c7 eb 02 89 d0 <09> 30 8b 50 04 85 d2 75 f5 89 78 04 8b 43 10 83 c0 44 e8 33 8c 
 

--5mCyUwZo2JvN/JJP--
