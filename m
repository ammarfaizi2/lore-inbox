Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWCaTU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWCaTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWCaTU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:20:28 -0500
Received: from nproxy.gmail.com ([64.233.182.186]:51595 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751431AbWCaTU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:20:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=e1aih3OjTy+SU/q/meb9npbmV4wh+a3rSDjSTPTVv6RYdcxt+WlTeYfrqDVJktgZSnai2sVJk9XUF7+NU74WyXYsXEyycZCi7Vdpz3ZPAf7XLFfdy98w4IAt8q85FkB5494WfM2O0akftu1Tw4j2+EuoBV6gbzeOUP2Cl1FwDJM=
Message-ID: <c87e555d0603311120n52e78493u610de7a8474e65d3@mail.gmail.com>
Date: Fri, 31 Mar 2006 21:20:25 +0200
From: "Maurizio Lombardi" <m.lombardi85@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI Error (Method parse/execution failed) with 2.6.16 kernel
Cc: linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18680_13478065.1143832825342"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18680_13478065.1143832825342
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGksCgpJIGhhZCBzb21lIHByb2JsZW1zIHN3aXRjaGluZyBmcm9tIDIuNi4xNS42IHRvIDIuNi4x
NiBrZXJuZWwgdmVyc2lvbi4KQXQgYm9vdCBzb21ldGltZXMgaSBnZXQgc29tZSBlcnJvcnMgYWJv
dXQgQUNQSSwgeW91IGNhbiBmaW5kIGxvZ3MgYXMgYXR0YWNobWVudC4KQXMgYSByZXN1bHQsIHNv
bWV0aW1lcyBteSBsYXB0b3AgaXMgdW5hYmxlIHRvIHJlYWQgYmF0dGVyeSByZW1haW5pbmcKY2Fw
YWNpdHkgbGV2ZWwuCgpEbyB5b3Uga25vdyBob3cgdG8gZml4IHRoaXMgcHJvYmxlbT8KCgotLQot
LS0tLS0tLS0tLS0tLS0tLS0tLQpNYXVyaXppbyBMb21iYXJkaQpMaW51eCAyLjYuMTYKLS0tLS0t
LS0tLS0tLS0tLS0tLS0K
------=_Part_18680_13478065.1143832825342
Content-Type: application/octet-stream; name=dmesg
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elgwbzig
Content-Disposition: attachment; filename="dmesg"

Linux version 2.6.16 (rokeby@darkstar) (gcc version 3.3.4) #3 Wed Mar 22 13:13:48 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
 BIOS-e820: 000000000f6f0000 - 000000000f6ff000 (ACPI data)
 BIOS-e820: 000000000f6ff000 - 000000000f700000 (ACPI NVS)
 BIOS-e820: 000000000f700000 - 000000000f800000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
246MB LOWMEM available.
On node 0 totalpages: 63216
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 59120 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7290
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0f6f8b67
ACPI: FADT (v001 ATI    Raptor   0x06040000 ATI  0x000f4240) @ 0x0f6fee2b
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0f6fee9f
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0f6feec7
ACPI: DSDT (v001    ATI U1_M1535 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 10000000 (gap: 0f800000:f07c0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.16 ro root=301
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (011ef000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1855.214 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 247460k/252864k available (1712k kernel code, 4852k reserved, 628k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3713.82 BogoMIPS (lpj=7427650)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP2500+ stepping 00
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e28)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
Boot video device is 0000:01:05.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 6 10) *9
ACPI: Embedded Controller [EC0] (gpe 24) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:07: ioport range 0x40b-0x40b has been reserved
pnp: 00:07: ioport range 0x480-0x48f has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:07: ioport range 0x8000-0x807f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: e4100000-e41fffff
  PREFETCH window: ec000000-edffffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:0a.0 to 64
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler cfq registered (default)
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0xec000000, mapped to 0xd0080000, using 3072k, total 8128k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:51a9
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:5:5, shift=0:10:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (52 C)
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKG] -> GSI 3 (level, low) -> IRQ 3
0000:00:08.0: ttyS1 at I/O 0x8828 (irq = 3) is a 8250
0000:00:08.0: ttyS2 at I/O 0x8840 (irq = 3) is a 8250
0000:00:08.0: ttyS3 at I/O 0x8850 (irq = 3) is a 8250
Couldn't register serial port 0000:00:08.0: -28
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
natsemi eth0: NatSemi DP8381[56] at 0xe4003000 (0000:00:12.0), 00:0f:20:c7:7f:8d, IRQ 11, port TP.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
alim15x3: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: ST94019A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD+RW ND-5100A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Detected 1855.236 MHz processor.
powernow: No PST tables match this cpuid (0x7a0)
powernow: This is indicative of a broken BIOS.
powernow: Trying ACPI perflib
powernow: Minimum speed 530 MHz. Maximum speed 1855 MHz.
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 MDEM  LAN  LID 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ACPI: read EC, OB not full
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [AE_NOT_CONFIGURED] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.PCI0.ISA_.EC0_.SMRD] (Node c122bbe0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.PCI0.ISA_.EC0_.SMSL] (Node c122bb80), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.PCI0.ISA_.EC0_._Q09] (Node c122bae0), AE_TIME
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 594396k swap on /dev/hda2.  Priority:-1 extents:1 across:594396k
Linux agpgart interface v0.101 (c) Dave Jones
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 5 (level, low) -> IRQ 5
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKU] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 10, io mem 0xe4000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
agpgart: Detected Ati IGP320/M chipset
agpgart: AGP aperture is 64M @ 0xe8000000
input: PC Speaker as /class/input/input2
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]

------=_Part_18680_13478065.1143832825342--
