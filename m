Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWKBOwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWKBOwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWKBOwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:52:12 -0500
Received: from cernmx03.cern.ch ([137.138.166.166]:62002 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1751111AbWKBOwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:52:10 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type;
	b=CtqBERqAFuJNZ0AgyxxtLjUEMMmOw6Kg5lQMSqWfp6zfIQ9FXCrxD13UOqhodUEYYAy+slS6UqoKeo7tiipDHK7gHYUffl6O2gYV2FbeioyJ3+kAUMQAQiEF6IsFMaJO;
Keywords: CERN SpamKiller Note: -49 Charset: west-latin
X-Filter: CERNMX03 CERN MX v2.0 060921.0942 Release
From: Martin Weber <Martin.Weber@cern.ch>
Organization: RWTH Aachen
To: Linux List <linux-kernel@vger.kernel.org>
Subject: bus hidden behind transparent bridge
Date: Thu, 2 Nov 2006 16:05:48 +0100
User-Agent: KMail/1.9.1
X-Face: ULps1'$vijmn.0n2esJBV6~3TZEWaOGi6}g13GH{7g2[3qU+`tG}@N4i']B8Ba~v*CC.nF
	<O/g;0:;ovG7kSc~M$/[jneF|?o4VqVpQ}.Fg^:_`^Hy_FM?B)^Gp%*t%vhzyW=z3(^a~f
	+Zo9}j8O]Pk.[C-_!;4W$B_}PK_vxR]y0Anf("m!L&FLj!F|zvV_t/n&7AmgU8d\}DZFJ9
	8{Q&AE@AdRYX:bu*G#T#s%CEcwl0P@qeVEj;o2J5q]Z9w2j*>uaN9@gkj\(Q":0oB>@!$F
	SK<QP"0<~&Z(/HCiXeFc5w=jC<rW+4T-_;w*@[p`VP3@u:e5pbK^VD;"Uar:BI`W2g
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MlgSF8oQiOFEWrR"
Message-Id: <200611021605.48753.Martin.Weber@cern.ch>
X-OriginalArrivalTime: 02 Nov 2006 14:52:06.0495 (UTC) FILETIME=[772DF6F0:01C6FE8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_MlgSF8oQiOFEWrR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear linux-kernel developers,

I got the following request from the kernel:

Nov  2 10:24:29 wonderland PCI: Transparent bridge - 0000:00:1e.0
Nov  2 10:24:29 wonderland PCI: Bus #04 (-#07) is hidden behind transparent 
bridge #02 (-#04) (try 'pci=assign-busses')
Nov  2 10:24:29 wonderland Please report the result to linux-kernel to fix 
this permanently

So I ran with the given option and attach the output. Hope it helps.

Best regards,

Martin Weber

-- 
Martin Weber           Office: +49-241-80-27183
I. Physik. Inst. B        Fax: +49-241-80-22661
RWTH Aachen
D-52056 Aachen           http://home.cern.ch/Martin.Weber

--Boundary-00=_MlgSF8oQiOFEWrR
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.17-gentoo-r8-mkw (root@wonderland) (gcc version 4.1.1 (Gentoo 4.1.1)) #3 PREEMPT Wed Oct 25 09:17:38 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000dc000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
 BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffff000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126832 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6630
ACPI: RSDT (v001 PTLTD  CooperSp 0x06040000  LTP 0x00000000) @ 0x1ff7696c
ACPI: FADT (v001 INTEL  ODEM     0x06040000 PTL  0x00000050) @ 0x1ff7bed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: SSDT (v001  INTEL  EISTRef 0x00000001 INTL 0x02002015) @ 0x1ff7699c
ACPI: DSDT (v001 INTEL  ODEM     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:df800000)
Built 1 zonelists
Kernel command line: root=/dev/hda5 resume=/dev/hda2 showopts pci=assign-busses
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01402000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 1495.285 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515004k/523712k available (2530k kernel code, 8160k reserved, 732k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2993.13 BogoMIPS (lpj=5986276)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0820)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9d3, last bus=4
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Enabled i801 SMBus device
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28) interrupt mode.
ACPI: Power Resource [CFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 3, cardbus bridge: 0000:02:01.0
  IO window: 00004400-000044ff
  IO window: 00004800-000048ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 7, cardbus bridge: 0000:02:01.1
  IO window: 00004c00-00004cff
  IO window: 00001400-000014ff
  PREFETCH window: 32000000-33ffffff
  MEM window: 38000000-39ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: d0200000-d02fffff
  PREFETCH window: 30000000-33ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt 0000:02:01.1[B] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:02:01.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Initializing Cryptographic API
io scheduler noop registered (default)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xe0000000
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=215.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: Samsung LTN150P1-L02    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 175x65
radeonfb (0000:01:00.0): ATI Radeon \c 
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (off)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (51 C)
Asus Laptop ACPI Extras version 0.29
  Samsung P30 detected, supported
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL8139 at 0xe0814800, 00:00:f0:7f:06:8c, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: SAMSUNG HM120JC, ATA DISK drive
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Synaptics Touchpad, model: 1, fw: 4.6, id: 0x925ea1, caps: 0x80471b/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
hdc: DV-W22E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 1419kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
Yenta: CardBus bridge found at 0000:02:01.0 [144d:c00c]
Yenta: ISA IRQ mask 0x0c98, PCI irq 5
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
ACPI: PCI Interrupt 0000:02:01.1[B] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
Yenta: CardBus bridge found at 0000:02:01.1 [144d:c00c]
Yenta: ISA IRQ mask 0x0c98, PCI irq 5
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xd0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 5, io base 0x00001800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55520 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with STAC9750,51 at 0xd0000c00, irq 5
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
EXT3 FS on hda5, internal journal
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, git-1.2.2
ipw2100: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 755044k swap on /dev/hda2.  Priority:-1 extents:1 across:755044k
eth0: link down
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
[drm] Initialized radeon 1.24.0 20060225 on minor 0
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x2000000
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x2000000
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x2000000
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x2000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 2 usecs
cisco_ipsec: module license 'Proprietary' taints kernel.
Cisco Systems VPN Client Version 4.7.00 (0640) kernel module loaded

--Boundary-00=_MlgSF8oQiOFEWrR--
