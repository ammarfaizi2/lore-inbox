Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUHXFRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUHXFRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUHXFRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:17:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:63718 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266565AbUHXFRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:17:24 -0400
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Date: Tue, 24 Aug 2004 07:17:16 +0200
User-Agent: KMail/1.7
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_c9sKBWv6C2vZACA"
Message-Id: <200408240717.16884.warpy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_c9sKBWv6C2vZACA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
kernel 2.6.8.1-mm2 now booting here without pci=routeirq and
nv_enable_pci.patch. :-)


-- 
Michael Geithe



--Boundary-00=_c9sKBWv6C2vZACA
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-2.6.8.1-mm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-2.6.8.1-mm2"

                      ) @ 0x000fa380
ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMIINT INTEL875 0x00000011 MSFT 0x00000097) @ 0x3fff0030
ACPI: MADT (v001 AMIINT INTEL875 0x00000009 MSFT 0x00000097) @ 0x3fff00c0
ACPI: DSDT (v001  INTEL     I875 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda1 acpi_os_name=Linux floppy=no_acpi video=vesafb:ypan,vram:16 vga=0x317
floppy0: no_acpi=1
CPU 0 irqstacks, hard=c03ca000 soft=c03c8000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2801.068 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035616k/1048512k available (1967k kernel code, 12316k reserved, 666k data, 188k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5537.79 BogoMIPS (lpj=2768896)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: Overriding _OS definition Linux
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1462.66 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c03cb000 soft=c03c9000
Initializing CPU#1
Calibrating delay loop... 5586.94 BogoMIPS (lpj=2793472)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11124.73 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:  online
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHB._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
vesafb: framebuffer at 0xe0000000, mapped to 0xf8880000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:e9d0
vesafb: pmi: set display start = c00cea15, set palette = c00cea9a
vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03
vesafb: scrolling: ypan using protected mode interface, yres_virtual=8192
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
Starting balanced_irq
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1, 8 throttling states)
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
eth0: 0000:02:08.0, 00:0C:76:27:61:10, IRQ 20.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xed626fe2).
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD600AB-00CDB0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST340015A, ATA DISK drive
hdd: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1
hdc: max request size: 128KiB
hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
scsi0 : AdvanSys SCSI 3.3K: PCI Ultra: IO 0xC800-0xC80F, IRQ 0x13
  Vendor: YAMAHA    Model: CDR400t           Rev: 1.0q
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 6x/6x writer xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 5
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding 847720k swap on /dev/hdc3.  Priority:-1 extents:1
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27 07:55:38 PDT 2004
ReiserFS: hdc2: found reiserfs format "3.6" with standard journal
ReiserFS: hdc2: using ordered data mode
ReiserFS: hdc2: journal params: device hdc2, size 8192, journal first block 18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc2: checking transaction log (hdc2)
ReiserFS: hdc2: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000e000
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000e400
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000e800
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000ec00
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
usb 1-1: new full speed USB device using address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
scsi1 : SCSI emulation for USB Mass Storage devices
usb 2-1: new low speed USB device using address 2
  Vendor: SAMSUNG   Model: SV1296A           Rev:  0 0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 25238304 512-byte hdwr sectors (12922 MB)
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usb 4-2: new low speed USB device using address 2
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.3-2
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f9a2cc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 1-1: USB disconnect, address 2
usb 4-2: USB disconnect, address 2
usb 2-1: USB disconnect, address 2
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:01.2[B] -> GSI 18 (level, low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[feaff000-feaff7ff]  Max Packet=[2048]
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 18
bttv0: Bt878 (rev 17) at 0000:02:02.0, irq: 18, latency: 32, mmio: 0xefefe000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ff67ff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=25 tuner=1 radio=no stereo=no
bttv0: using tuner=1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: Ignoring new-style parameters in presence of obsolete ones
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 1 (Philips PAL_I (FI1246 and compatibles)) by bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
usb 5-1: new high speed USB device using address 2
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: SAMSUNG   Model: SV1296A           Rev:  0 0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 25238304 512-byte hdwr sectors (12922 MB)
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
USB Mass Storage device found at 2
usb 2-1: new low speed USB device using address 3
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0151028a1f]
usb 4-2: new low speed USB device using address 3
input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.3-2
hdd: CHECK for good STATUS


--Boundary-00=_c9sKBWv6C2vZACA--
