Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVLVVzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVLVVzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVLVVzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:55:42 -0500
Received: from hermes.domdv.de ([193.102.202.1]:62472 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1030333AbVLVVzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:55:41 -0500
Message-ID: <43AB20DA.2020506@domdv.de>
Date: Thu, 22 Dec 2005 22:55:38 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: 2.6.15rc6: ide oops+panic
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/mixed;
 boundary="------------030900080607070804080608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030900080607070804080608
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Attached are boot messages and panic captured via serial console, as
well as the system config.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------030900080607070804080608
Content-Type: text/plain;
 name="top.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="top.log"

Bootdata ok (command line is BOOT_IMAGE=2.6.15rc6s root=301 video=radeonfb:off console=ttyS0,115200 console=tty0)
Linux version 2.6.15-rc6top (root@gringo) (gcc version 3.4.4) #1 SMP PREEMPT Thu Dec 22 14:23:34 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
 BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
ACPI: [SRAT:0x00] ignored 2 entries of 4 found
SRAT: Node 0 PXM 0 100000-80000000
SRAT: Node 1 PXM 1 80000000-c0000000
SRAT: Node 1 PXM 1 80000000-140000000
SRAT: Node 0 PXM 0 0-80000000
Bootmem setup node 0 0000000000000000-0000000080000000
Bootmem setup node 1 0000000080000000-0000000140000000
ACPI: PM-Timer IO Port: 0x5008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfe9ff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfe9ff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfe9fe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfe9fe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to flat
ACPI: HPET id: 0x102282a0 base: 0xfec01000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3f780000)
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Kernel command line: BOOT_IMAGE=2.6.15rc6s root=301 video=radeonfb:off console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 1992.254 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 4102684k/5242880k available (4188k kernel code, 91168k reserved, 1774k data, 280k init)
Calibrating delay using timer specific routine.. 3988.45 BogoMIPS (lpj=1994226)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.451 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3983.84 BogoMIPS (lpj=1991921)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 246 stepping 08
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 1073 cycles)
Brought up 2 CPUs
time.c: Using HPET based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Root Bridge [PCIB] (0000:04)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfec01000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 32-bit timers, 14318180 Hz
agpgart: Detected AMD 8151 AGP Bridge rev B2
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x295-0x296 has been reserved
PCI: Bridge: 0000:00:06.0
  IO window: 6000-7fff
  MEM window: fe200000-fe3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0a.0
  IO window: 8000-9fff
  MEM window: fe400000-fe4fffff
  PREFETCH window: cde00000-cdefffff
PCI: Bridge: 0000:00:0b.0
  IO window: a000-afff
  MEM window: fe500000-fe8fffff
  PREFETCH window: cdf00000-cdffffff
PCI: Bridge: 0000:04:01.0
  IO window: c000-cfff
  MEM window: fea00000-feafffff
  PREFETCH window: ce100000-ee0fffff
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1135374123.884:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.19.0 20050911 on minor 0: 
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 28 (level, low) -> IRQ 17
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:03:03.1[B] -> GSI 29 (level, low) -> IRQ 18
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
tg3.c:v3.45 (Dec 13, 2005)
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 19
eth2: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:28:25:e3
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth2: dma_rwctrl[763f0000]
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD2500JB-32FUA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD2500JB-32FUA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20268: IDE controller at PCI slot 0000:02:08.0
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 27 (level, low) -> IRQ 20
PDC20268: chipset revision 2
PDC20268: ROM enabled at 0xfe4e0000
PDC20268: 100% native mode on irq 20
    ide2: BM-DMA at 0x8800-0x8807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8808-0x880f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD2500JB-32FUA0, ATA DISK drive
ide2 at 0x9800-0x9807,0x9402 on irq 20
hdg: PLEXTOR DVDR PX-708A, ATAPI CD/DVD-ROM drive
ide3 at 0x9000-0x9007,0x8c02 on irq 20
hda: max request size: 1024KiB
hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: max request size: 1024KiB
hdc: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 >
hde: max request size: 1024KiB
hde: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 >
hdg: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
st: Version 20050830, fixed bufsize 32768, s/g segs 256
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:01:0c.0[A] -> GSI 19 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[fe3fd000-fe3fd7ff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
usbmon: debugfs is not available
GSI 22 sharing vector 0xD9 and IRQ 22
ACPI: PCI Interrupt 0000:01:0a.2[C] -> GSI 18 (level, low) -> IRQ 22
ehci_hcd 0000:01:0a.2: EHCI Host Controller
ehci_hcd 0000:01:0a.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:01:0a.2: irq 22, io mem 0xfe3fdc00
ehci_hcd 0000:01:0a.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 21
ohci_hcd 0000:01:00.0: OHCI Host Controller
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.0: irq 21, io mem 0xfe3fe000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 21
ohci_hcd 0000:01:00.1: OHCI Host Controller
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:01:00.1: irq 21, io mem 0xfe3ff000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:01:0a.0: OHCI Host Controller
ohci_hcd 0000:01:0a.0: new USB bus registered, assigned bus number 4
ohci_hcd 0000:01:0a.0: irq 16, io mem 0xfe3fb000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
hub 4-0:1.0: over-current change on port 1
GSI 23 sharing vector 0xE1 and IRQ 23
ACPI: PCI Interrupt 0000:01:0a.1[B] -> GSI 17 (level, low) -> IRQ 23
ohci_hcd 0000:01:0a.1: OHCI Host Controller
ohci_hcd 0000:01:0a.1: new USB bus registered, assigned bus number 5
ohci_hcd 0000:01:0a.1: irq 23, io mem 0xfe3fc000
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 4-1: new full speed USB device using ohci_hcd and address 2
hub 4-0:1.0: over-current change on port 2
USB Universal Host Controller Interface driver v2.3
Initializing USB Mass Storage driver...
hub 4-0:1.0: over-current change on port 3
scsi0 : SCSI emulation for USB Mass Storage devices
hub 5-0:1.0: over-current change on port 1
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  6072.000 MB/sec
raid5: using function: generic_sse (6072.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21 2005 UTC).
ACPI: PCI Interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 23
input: AT Translated Set 2 keyboard as /class/input/input0
intel8x0_measure_ac97_clock: measured 51379 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: AMD AMD8111 with AD1981B at 0xb800, irq 23
u32 classifier
    OLD policer on 
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 288 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
hub 5-0:1.0: over-current change on port 2
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hde6 ...
md:  adding hde6 ...
md: hde3 has different UUID to hde6
md:  adding hdc6 ...
md: hdc3 has different UUID to hde6
md:  adding hda6 ...
md: hda3 has different UUID to hde6
md: created md1
md: bind<hda6>
md: bind<hdc6>
md: bind<hde6>
md: running: <hde6><hdc6><hda6>
raid5: device hde6 operational as raid disk 2
raid5: device hdc6 operational as raid disk 1
raid5: device hda6 operational as raid disk 0
raid5: allocated 3212kB for md1
raid5: raid level 5 set md1 active with 3 out of 3 devices, algorithm 0
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hda6
 disk 1, o:1, dev:hdc6
 disk 2, o:1, dev:hde6
md: considering hde3 ...
md:  adding hde3 ...
md:  adding hdc3 ...
md:  adding hda3 ...
md: created md0
md: bind<hda3>
md: bind<hdc3>
md: bind<hde3>
md: running: <hde3><hdc3><hda3>
raid5: device hde3 operational as raid disk 2
raid5: device hdc3 operational as raid disk 1
raid5: device hda3 operational as raid disk 0
raid5: allocated 3212kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 0
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hda3
 disk 1, o:1, dev:hdc3
 disk 2, o:1, dev:hde3
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 280k freed
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at drivers/ide/ide-io.c:63
invalid operand: 0000 [1] PREEMPT SMP 
CPU 0 
Modules linked in: snd_usb_audio snd_usb_lib snd_rawmidi snd_hwdep
Pid: 0, comm: swapper Not tainted 2.6.15-rc6top #1
RIP: 0010:[<ffffffff8038e995>] <ffffffff8038e995>{__ide_end_request+53}
RSP: 0018:ffffffff806d67d0  EFLAGS: 00010046
RAX: 0000000001000479 RBX: ffff810002f7b490 RCX: 0000000000000008
RDX: 0000000000000000 RSI: ffff810002f7b490 RDI: ffffffff80730d98
RBP: 0000000000000000 R08: 000000003b9aca00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000064 R12: ffffffff80730d98
R13: 0000000000000008 R14: 0000000000000001 R15: ffffffff80730c80
FS:  00002aaaab1aaae0(0000) GS:ffffffff80751800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaafbb7b0 CR3: 000000007e0e0000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff8075a000, task ffffffff805d36c0)
Stack: ffff810002f7b490 ffff81013feeacd0 ffff810002f5a550 0000000000000050 
       0000000000000050 ffffffff80299aae 0000000000000246 ffff81013feeacd0 
       ffffffff80730d98 ffffffff8038f0f2 
Call Trace: <IRQ> <ffffffff80299aae>{blk_pre_flush_end_io+110}
       <ffffffff8038f0f2>{ide_end_drive_cmd+946} <ffffffff8038f6f0>{drive_cmd_intr+288}
       <ffffffff8038f5d0>{drive_cmd_intr+0} <ffffffff80390850>{ide_intr+400}
       <ffffffff8015c7bc>{handle_IRQ_event+44} <ffffffff8015c8a1>{__do_IRQ+177}
       <ffffffff80110c9f>{do_IRQ+47} <ffffffff8010e2d8>{ret_from_intr+0}
       <ffffffff80390ad0>{ide_outb+0} <ffffffff80390ad6>{ide_outb+6}
       <ffffffff803995b1>{ide_do_rw_disk+529} <ffffffff8049a036>{ip_rcv+1302}
       <ffffffff80120000>{__ioremap+512} <ffffffff80390160>{ide_do_request+1648}
       <ffffffff8038f0f2>{ide_end_drive_cmd+946} <ffffffff80390895>{ide_intr+469}
       <ffffffff8015c7bc>{handle_IRQ_event+44} <ffffffff8015c8a1>{__do_IRQ+177}
       <ffffffff80110c9f>{do_IRQ+47} <ffffffff8010e2d8>{ret_from_intr+0}
        <EOI> <ffffffff8010ebf1>{kernel_thread+129} <ffffffff80390ad0>{ide_outb+0}
       <ffffffff8010bd96>{default_idle+54} <ffffffff8010c012>{cpu_idle+98}
       <ffffffff8075c835>{start_kernel+485} <ffffffff8075c294>{_sinittext+660}
       

Code: 0f 0b 68 61 85 57 80 c2 3f 00 90 a8 02 74 0c 85 ed 7f 08 44 
RIP <ffffffff8038e995>{__ide_end_request+53} RSP <ffffffff806d67d0>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0 
Modules linked in: snd_usb_audio snd_usb_lib snd_rawmidi snd_hwdep
Pid: 0, comm: swapper Not tainted 2.6.15-rc6top #1
RIP: 0010:[<ffffffff801198f4>] <ffffffff801198f4>{__smp_call_function+116}
RSP: 0018:ffffffff806d6488  EFLAGS: 00000097
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000002
RDX: 0000ffff0000ffff RSI: 0000000000000000 RDI: ffffffff807560d8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff80119a40
R13: 0000000000000000 R14: ffffffff805526dd R15: ffffffff80730c80
FS:  00002aaaab1aaae0(0000) GS:ffffffff80751800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaafbb7b0 CR3: 000000007e0e0000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff8075a000, task ffffffff805d36c0)
Stack: ffffffff80119a40 0000000000000000 ffffffff00000000 ffffffff00000000 
       0000000000000400 0000000000000000 0000000000000000 ffffffff805d36c0 
       000000000000000b ffffffff80119aa0 
Call Trace: <IRQ> <ffffffff80119a40>{smp_really_stop_cpu+0} <ffffffff80119aa0>{smp_send_stop+64}
       <ffffffff80135ca1>{panic+225} <ffffffff8010f543>{show_stack+211}
       <ffffffff8010f639>{show_registers+233} <ffffffff8013869f>{do_exit+143}
       <ffffffff80315327>{do_unblank_screen+119} <ffffffff8010f8f1>{die+81}
       <ffffffff8010fd41>{do_invalid_op+145} <ffffffff8038e995>{__ide_end_request+53}
       <ffffffff80136a1d>{printk+141} <ffffffff804d2b54>{ip_refrag+36}
       <ffffffff8010eaa1>{error_exit+0} <ffffffff8038e995>{__ide_end_request+53}
       <ffffffff80299aae>{blk_pre_flush_end_io+110} <ffffffff8038f0f2>{ide_end_drive_cmd+946}
       <ffffffff8038f6f0>{drive_cmd_intr+288} <ffffffff8038f5d0>{drive_cmd_intr+0}
       <ffffffff80390850>{ide_intr+400} <ffffffff8015c7bc>{handle_IRQ_event+44}
       <ffffffff8015c8a1>{__do_IRQ+177} <ffffffff80110c9f>{do_IRQ+47}
       <ffffffff8010e2d8>{ret_from_intr+0} <ffffffff80390ad0>{ide_outb+0}
       <ffffffff80390ad6>{ide_outb+6} <ffffffff803995b1>{ide_do_rw_disk+529}
       <ffffffff8049a036>{ip_rcv+1302} <ffffffff80120000>{__ioremap+512}
       <ffffffff80390160>{ide_do_request+1648} <ffffffff8038f0f2>{ide_end_drive_cmd+946}
       <ffffffff80390895>{ide_intr+469} <ffffffff8015c7bc>{handle_IRQ_event+44}
       <ffffffff8015c8a1>{__do_IRQ+177} <ffffffff80110c9f>{do_IRQ+47}
       <ffffffff8010e2d8>{ret_from_intr+0}  <EOI> <ffffffff8010ebf1>{kernel_thread+129}
       <ffffffff80390ad0>{ide_outb+0} <ffffffff8010bd96>{default_idle+54}
       <ffffffff8010c012>{cpu_idle+98} <ffffffff8075c835>{start_kernel+485}
       <ffffffff8075c294>{_sinittext+660} 

Code: 39 d8 74 08 f3 90 eb f4 66 66 66 90 85 ed 74 0e 8b 44 24 14 
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 NMI Watchdog detected LOCKUP on CPU 1
CPU 1 
Modules linked in: snd_usb_audio snd_usb_lib snd_rawmidi snd_hwdep
Pid: 0, comm: swapper Not tainted 2.6.15-rc6top #1
RIP: 0010:[<ffffffff80513975>] <ffffffff80513975>{_spin_lock_irqsave+117}
RSP: 0018:ffff81013fc5fed8  EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffffffff80755e40 RCX: 0000000000000001
RDX: ffff810002ca3e28 RSI: 0000000000000000 RDI: ffffffff80755e40
RBP: 0000000000000000 R08: ffff810002ca2000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000005023 R12: ffff810002ca3e28
R13: 000000000000000f R14: 0000000000000000 R15: ffff810002ca3e28
FS:  00002aaaab0146d0(0000) GS:ffffffff80751880(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000004810b0 CR3: 000000013e467000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff810002ca2000, task ffff810002c9c080)
Stack: 0000000000000046 ffff810002f67b40 ffff810002f6f400 ffffffff803906ef 
       ffff81013fc5fef8 ffff81013fc5fef8 ffff810002f67b40 0000000000000000 
       ffff810002ca3e28 000000000000000f 
Call Trace: <IRQ> <ffffffff803906ef>{ide_intr+47} <ffffffff8015c7bc>{handle_IRQ_event+44}
       <ffffffff8015c8a1>{__do_IRQ+177} <ffffffff80110c9f>{do_IRQ+47}
       <ffffffff8010e2d8>{ret_from_intr+0}  <EOI> <ffffffff8010bd96>{default_idle+54}
       <ffffffff8010c012>{cpu_idle+98} <ffffffff80767ff9>{start_secondary+1257}
       

Code: f3 90 8b 03 85 c0 7e f1 65 48 8b 04 25 10 00 00 00 ff 80 44 
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 

--------------030900080607070804080608
Content-Type: application/x-gunzip;
 name="config.top.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.top.gz"

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
C53NG8GaAAA=
--------------030900080607070804080608--
