Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbUKXS62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbUKXS62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbUKXS5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 13:57:41 -0500
Received: from alpha.lic1.vsi.ru ([80.82.34.34]:58323 "EHLO alpha.lic1.vsi.ru")
	by vger.kernel.org with ESMTP id S262829AbUKXSyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 13:54:19 -0500
Message-ID: <41A4D09B.4020909@lic1.vsi.ru>
Date: Wed, 24 Nov 2004 21:19:07 +0300
From: "Igor A. Valcov" <viaprog@lic1.vsi.ru>
Reply-To: viaprog@lic1.vsi.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Semen <semen@basdesign.ru>, Sergey Kondratiev <serkon@box.vsi.ru>,
       DeveL <unixuser@mail.ru>, linux-bugs@nvidia.com,
       alan@lxorguk.ukuu.org.uk, amdenis@yandex.ru
Subject: linux-2.6.9-ac10 crash!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Periodically, 2.6.9* kernels crashed.
Installed nvidia drivers 6629 and vmware-worksation-4.5.2-8848.

This messages after last crash:

klogd 1.4.1, log source = /proc/kmsg started.
Linux version 2.6.9-ac10 (root@alpha-viaprog) (gcc version 3.3.4 
20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #1 Fri Nov 19 
22:51:02 MSK 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4880
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=/dev/hda2
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2391.573 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035452k/1048512k available (2128k kernel code, 12476k reserved, 
904k data, 140k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1e0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1, 2 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ttyS4 at I/O 0x9400 (irq = 9) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xf8802000, 00:05:1c:18:5f:50, IRQ 10
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 1
ICH4: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
hdd: ST3120026A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:02:02.0
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
PDC20269: chipset revision 2
PDC20269: 100%% native mode on irq 11
     ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
hde: ST3200822A, ATA DISK drive
ide2 at 0x9800-0x9807,0x9c02 on irq 11
hdg: ST340810A, ATA DISK drive
ide3 at 0xa000-0xa007,0xa402 on irq 11
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdd: max request size: 1024KiB
hdd: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
  /dev/ide/host0/bus1/target1/lun0: p1 p2 p3 p4
hde: max request size: 1024KiB
hde: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, 
UDMA(100)
  /dev/ide/host2/bus0/target0/lun0: p1 p2
hdg: max request size: 128KiB
hdg: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
  /dev/ide/host2/bus1/target0/lun0: p1
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 
EHCI Controller
ehci_hcd 0000:00:1d.7: irq 11, pci mem f880e000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: irq 12, io base 0000b800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: irq 10, io base 0000b000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: irq 10, io base 0000b400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
usb 4-2: new low speed USB device using address 2
input: PC Speaker
Intel 810 + AC97 Audio, version 1.01, 22:48:19 Nov 19 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
i810: Intel ICH4 found at IO 0xd800 and 0xd400, MEM 0xec002000 and 
0xec003000, IRQ 5
i810: Intel ICH4 mmio at 0xf8810000 and 0xf8812000
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:00:1d.2-2
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 6
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:
SLPB PCI0 HUB0 USB0 USB1 USB2 USB3
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
kjournald starting.  Commit interval 5 seconds
Adding 1028152k swap on /dev/hda1.  Priority:43 extents:1
Adding 1004020k swap on /dev/hde1.  Priority:43 extents:1
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
vmmon: module license 'unspecified' taints kernel.
bridge-eth0: already up
process `named' is using obsolete setsockopt SO_BSDCOMPAT
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 12 (level, low) -> IRQ 12
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov 
3 13:12:51 PST 2004

c01388b6
PREEMPT
Modules linked in: nvidia vmnet vmmon
CPU:    0
EIP:    0060:[<c01388b6>]    Tainted: P   VLI
EFLAGS: 00013086   (2.6.9-ac10)
EIP is at __page_cache_release+0x35/0x94
eax: c1394e78   ebx: c1312000   ecx: c1312018   edx: 00200200
esi: c036af04   edi: 00003202   ebp: c1312000   esp: f76abea8
ds: 007b   es: 007b   ss: 0068
Process X (pid: 7065, threadinfo=f76aa000 task=f7b0baa0)
Stack: 000ef000 d8c629fc 00100000 c013c0f8 f76abf08 0000001d 00000040 
ecc08380
        18900067 00000000 b1990000 c0421f40 b1d90000 f76dab1c b1a90000 
c0421f40
        c013c229 00100000 00000000 f763ad00 ec9bd8f8 b1990000 f76dab1c 
b1a90000
Call Trace:
  [<c013c0f8>] zap_pte_range+0x15f/0x251
  [<c013c229>] zap_pmd_range+0x3f/0x5b
  [<c013c282>] unmap_page_range+0x3d/0x63
  [<c013c39e>] unmap_vmas+0xf6/0x1b4
  [<c013ff1c>] unmap_region+0x72/0xd6
  [<c01401a2>] do_munmap+0x101/0x147
  [<c0140228>] sys_munmap+0x40/0x63
  [<c0103e85>] sysenter_past_esp+0x52/0x71
Code: 8b 34 85 60 9e 42 c0 9c 5f fa b8 00 e0 ff ff 21 e0 83 40 14 01 0f 
ba 33 05 19 c0 85 c0 74 2a 8d 4b 18 8b 43 18 8b 51 04 89 50 04 <89> 02 
c7 41 04 00 02 20 00 8b 03 c7 43 18 00 01 10 00 a8 40 74
  <6>note: X[7065] exited with preempt_count 3
  [<c0312795>] schedule+0x4c1/0x4c6
  [<c0217000>] vt_console_print+0x0/0x2da
  [<c011827e>] __call_console_drivers+0x44/0x46
  [<c0118360>] call_console_drivers+0x76/0xfb
  [<c0312d20>] rwsem_down_read_failed+0x8f/0x176
  [<c011b56b>] .text.lock.exit+0x6b/0xc8
  [<c01048a5>] do_divide_error+0x0/0x10e
  [<c01133b3>] do_page_fault+0x0/0x51e
  [<c01133b3>] do_page_fault+0x0/0x51e
  [<c01135b3>] do_page_fault+0x200/0x51e
  [<f8d6f6f9>] _nv001306rm+0x49/0x68 [nvidia]
  [<f8d724b3>] rm_isr+0x13/0x30 [nvidia]
  [<f8f54286>] nv_kern_isr+0xe4/0x124 [nvidia]
  [<c0105ae8>] handle_IRQ_event+0x25/0x51
  [<c01133b3>] do_page_fault+0x0/0x51e
  [<c0104101>] error_code+0x2d/0x38
  [<c01388b6>] __page_cache_release+0x35/0x94
  [<c013c0f8>] zap_pte_range+0x15f/0x251
  [<c013c229>] zap_pmd_range+0x3f/0x5b
  [<c013c282>] unmap_page_range+0x3d/0x63
  [<c013c39e>] unmap_vmas+0xf6/0x1b4
  [<c013ff1c>] unmap_region+0x72/0xd6
  [<c01401a2>] do_munmap+0x101/0x147
  [<c0140228>] sys_munmap+0x40/0x63
  [<c0103e85>] sysenter_past_esp+0x52/0x71
c01378b7
PREEMPT
Modules linked in: nvidia vmnet vmmon
CPU:    0
EIP:    0060:[<c01378b7>]    Tainted: P   VLI
EFLAGS: 00010002   (2.6.9-ac10)
EIP is at free_block+0x44/0xc8
eax: 00310280   ebx: 00200200   ecx: d8814d80   edx: c1000000
esi: c1900600   edi: 00000000   ebp: c190060c   esp: c1957efc
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c1956000 task=c191e020)
Stack: c190061c 00000003 c192c010 c192c010 c192c000 00000003 c1900600 
c0137f29
        c190059c c1900600 c1956000 00000001 c0137fc9 c190059c c1956000 
c1900670
        c191e178 c0429f80 c1956000 c0429f84 00000297 c0125e91 00000000 
c1957f70
Call Trace:
  [<c0137f29>] drain_array_locked+0x6b/0x97
  [<c0137fc9>] cache_reap+0x74/0x1ae
  [<c0125e91>] worker_thread+0x1ad/0x273
  [<c01145f0>] activate_task+0x5c/0x6f
  [<c0137f55>] cache_reap+0x0/0x1ae
  [<c0114ee6>] default_wake_function+0x0/0xc
  [<c0114f25>] __wake_up_common+0x33/0x56
  [<c0114ee6>] default_wake_function+0x0/0xc
  [<c0125ce4>] worker_thread+0x0/0x273
  [<c012968c>] kthread+0x90/0x95
  [<c01295fc>] kthread+0x0/0x95
  [<c0102261>] kernel_thread_helper+0x5/0xb
Code: 8d 85 00 00 00 8d 40 1c 8d 6e 0c 89 04 24 8b 44 24 08 8b 15 f0 f4 
42 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c <8b> 53 
04 8b 03 89 50 04 89 02 c7 43 04 00 02 20 00 2b 4b 0c c7
  <6>note: events/0[3] exited with preempt_count 1
c01389f0
PREEMPT
Modules linked in: nvidia vmnet vmmon
CPU:    0
EIP:    0060:[<c01389f0>]    Tainted: P   VLI
EFLAGS: 00010086   (2.6.9-ac10)
EIP is at release_pages+0xdb/0x16b
eax: 00100100   ebx: c1310240   ecx: c1310258   edx: 00200200
esi: 00000000   edi: c036af04   ebp: c036af04   esp: f766dd3c
ds: 007b   es: 007b   ss: 0068
Process oops (pid: 6955, threadinfo=f766c000 task=f7641aa0)
Stack: f766c000 00000001 f766ddd8 00000000 00000000 f76030b0 c014f472 
f76030b0
        f76030b0 f76030b0 00001000 c0196ab7 c01d6978 00000010 c0429fe0 
c1394cc0
        c036af04 f766c000 c0138bdc 00000002 c0429fe0 f766c000 00000001 
f766ddd0
Call Trace:
  [<c014f472>] try_to_free_buffers+0x59/0x92
  [<c0196ab7>] journal_invalidatepage+0xb6/0x11b
  [<c01d6978>] radix_tree_gang_lookup+0x41/0x59
  [<c0138bdc>] __pagevec_lru_add+0xbd/0xdc
  [<c0138a95>] __pagevec_release+0x15/0x1d
  [<c0138f79>] truncate_inode_pages+0xb5/0x29f
  [<c013d2d2>] vmtruncate+0x86/0x136
  [<c0163b1d>] inode_setattr+0x144/0x161
  [<c018aca1>] ext3_setattr+0xf7/0x1fe
  [<c0163d86>] notify_change+0x1f6/0x22c
  [<c014922a>] do_truncate+0x57/0x90
  [<c0156ff4>] permission+0x5c/0x64
  [<c0158a5d>] may_open+0x1aa/0x222
  [<c0158b75>] open_namei+0xa0/0x5ab
  [<c014a167>] filp_open+0x2d/0x4e
  [<c014a3c4>] get_unused_fd+0x2c/0xc8
  [<c014a512>] sys_open+0x3c/0x76
  [<c0103e85>] sysenter_past_esp+0x52/0x71
Code: 8b 14 24 8b 42 08 a8 08 0f 85 96 00 00 00 89 fd fa 8b 04 24 83 40 
14 01 0f ba 33 05 19 c0 85 c0 74 2a 8d 4b 18 8b 43 18 8b 51 04 <89> 50 
04 89 02 c7 41 04 00 02 20 00 8b 03 c7 43 18 00 01 10 00
  <6>note: oops[6955] exited with preempt_count 1

-- 
Igor A. Valcov
