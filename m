Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUARFQj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 00:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUARFQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 00:16:38 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:36497 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266214AbUARFQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 00:16:28 -0500
Date: Sat, 17 Jan 2004 21:16:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: janfal@arcor.de
Subject: [Bug 1900] New: I'm getting Kernel Oops when trying to	load and configure the adaptec 1460B with aha152x_cs module 
Message-ID: <1210120000.1074402976@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1900

           Summary: I'm getting Kernel Oops when trying to load and
                    configure the adaptec 1460B with aha152x_cs module
    Kernel Version: 2.6.0 and 2.6.1
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: janfal@arcor.de


Distribution:
Hardware Environment:
Adaptec SlimSCSI 1460B Fast SCSI PCMCIA Adapter
Software Environment:
Linux Kernel 2.6.0, pcmcia-cs version 3.2.5
Problem Description:
Adaptec Controller is producoing kernel oops
Steps to reproduce:
booting

dmesg output:
 zonelist for node : 0
Kernel command line: root=/dev/hda8
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1394.781 MHz processor.
Console: colour VGA+ 80x25
Memory: 513852k/523712k available (2611k kernel code, 9104k reserved, 923k data,
164k init, 0k highmem)
Calibrating delay loop... 2752.51 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6150
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa99e, dseg 0x400
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f has been reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Cannot allocate resource region 0 of device 0000:02:06.2
Bluetooth: Core ver 2.3
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1400MHz": max
frequency: 1400000kHz
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
NTFS driver 2.1.5 [Flags: R/O].
Supermount version 2.0.2a for kernel 2.6
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (50 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
nbd: registered device at major 43
b44.c:v0.92 (Nov 4, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:29:dc:e9
PPP generic driver version 2.4.2
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-60, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 > p3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003
UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
specify port
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xd0000c00, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.0
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda8, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda8) for (hda8)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 164k freed
Adding 1020088k swap on /dev/hda7.  Priority:-1 extents:1
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:06.0 [1025:001f]
Yenta: ISA IRQ list 0898, PCI irq10
Socket status: 30000410
Yenta: CardBus bridge found at 0000:02:06.1 [1025:001f]
Yenta: ISA IRQ list 0898, PCI irq10
Socket status: 30000410
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Bluetooth: HCI USB driver ver 2.4
drivers/usb/core/usb.c: registered new driver hci_usb
NTFS volume version 3.1.
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0209000-d02097ff]  Max
Packet=[2048]
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011e15c>] __might_sleep+0xac/0xe0
 [<c0141c48>] kmem_cache_alloc+0x68/0x70
 [<c011e5ca>] dup_task_struct+0x2a/0xe0
 [<c011f2ad>] copy_process+0xcd/0xb40
 [<c011cd6a>] __wake_up_common+0x3a/0x70
 [<c011fd6d>] do_fork+0x4d/0x170
 [<c011bcd8>] recalc_task_prio+0xa8/0x1d0
 [<c010933d>] kernel_thread+0x7d/0x90
 [<e0a77fb0>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
 [<c01092b4>] kernel_thread_helper+0x0/0xc
 [<e0a78433>] nodemgr_add_host+0xe3/0x140 [ieee1394]
 [<e0a77fb0>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
 [<e0a1284d>] ohci_initialize+0x21d/0x230 [ohci1394]
 [<e0a73d16>] highlevel_add_host+0x76/0x80 [ieee1394]
 [<e0a732c0>] hpsb_add_host+0x70/0x90 [ieee1394]
 [<e0a14970>] ohci_irq_handler+0x0/0x7c0 [ohci1394]
 [<e0a14970>] ohci_irq_handler+0x0/0x7c0 [ohci1394]
 [<e0a16b47>] ohci1394_pci_probe+0x407/0x590 [ohci1394]
 [<e0a14970>] ohci_irq_handler+0x0/0x7c0 [ohci1394]
 [<c022593d>] pci_device_probe_static+0x4d/0x70
 [<c022599c>] __pci_device_probe+0x3c/0x50
 [<c02259dc>] pci_device_probe+0x2c/0x50
 [<c027a40d>] bus_match+0x3d/0x70
 [<c027a54c>] driver_attach+0x5c/0xa0
 [<c027a865>] bus_add_driver+0xa5/0xc0
 [<c027acc1>] driver_register+0x31/0x40
 [<c0225bbb>] pci_register_driver+0x5b/0x80
 [<e09bb015>] ohci1394_init+0x15/0x3e [ohci1394]
 [<c01370e5>] sys_init_module+0x135/0x280
 [<c010b40b>] syscall_call+0x7/0xb
 
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e09e5000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000dedd0]
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 3-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Microsoft Microsoft Wireless Intellimouse Explorer®
1.0A] on usb-0000:00:1d.1-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e09c5523
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e09c5523>]    Not tainted
EFLAGS: 00010286
EIP is at scsi_register+0x43/0x70 [scsi_mod]
eax: de8b11b8   ebx: de8b1000   ecx: 00000000   edx: e0aa03d4
esi: e0aa0360   edi: de915a40   ebp: de9157c8   esp: de9157b8
ds: 007b   es: 007b   ss: 0068
Process cardmgr (pid: 5513, threadinfo=de914000 task=df51f320)
Stack: e0aa0360 00000334 00000334 de915a18 de915818 e0a97a6e e0aa0360 00000334
       00000002 00000500 035f0340 de802380 de5b1c00 de9159f8 de5b1c00 de915818
       e09f9410 de5b1c00 00000282 de915878 dfbd0a30 00000000 de915a18 de915a40
Call Trace:
 [<e0a97a6e>] aha152x_probe_one+0x1e/0x440 [aha152x_cs]
 [<e09f9410>] CardServices+0x210/0x357 [pcmcia_core]
 [<e0a974ae>] aha152x_config_cs+0x2de/0x380 [aha152x_cs]
 [<c01f6a6a>] ip_check_balance+0x2ea/0xbb0
 [<c011be01>] try_to_wake_up+0x1/0x160
 [<e09ae7c6>] yenta_set_mem_map+0x196/0x1e0 [yenta_socket]
 [<e09f10be>] set_cis_map+0x3e/0x120 [pcmcia_core]
 [<e09f12b9>] read_cis_mem+0x119/0x190 [pcmcia_core]
 [<e09f1592>] read_cis_cache+0x102/0x190 [pcmcia_core]
 [<e09f1f99>] pcmcia_get_tuple_data+0x89/0x90 [pcmcia_core]
 [<e09f32b8>] pcmcia_parse_tuple+0x108/0x180 [pcmcia_core]
 [<e09f33a4>] read_tuple+0x74/0x80 [pcmcia_core]
 [<e09ae7c6>] yenta_set_mem_map+0x196/0x1e0 [yenta_socket]
 [<c011b4f1>] __ioremap+0xe1/0x120
 [<e0a9764f>] aha152x_event+0x6f/0x120 [aha152x_cs]
 [<e09f335e>] read_tuple+0x2e/0x80 [pcmcia_core]
 [<e09f1592>] read_cis_cache+0x102/0x190 [pcmcia_core]
 [<e09f1eb2>] pcmcia_get_next_tuple+0x272/0x2d0 [pcmcia_core]
 [<e09f34af>] pcmcia_validate_cis+0xff/0x1e0 [pcmcia_core]
 [<c01f53a6>] create_virtual_node+0x346/0x530
 [<c0201315>] pathrelse_and_restore+0x45/0x50
 [<c01e97e3>] do_balance+0xc3/0x110
 [<e09f7ea9>] pcmcia_register_client+0x269/0x2c0 [pcmcia_core]
 [<e09ae7c6>] yenta_set_mem_map+0x196/0x1e0 [yenta_socket]
 [<e09f93ab>] CardServices+0x1ab/0x357 [pcmcia_core]
 [<e0a970fe>] aha152x_attach+0xfe/0x140 [aha152x_cs]
 [<e0a975e0>] aha152x_event+0x0/0x120 [aha152x_cs]
 [<e09f711a>] pcmcia_bind_device+0x6a/0xb0 [pcmcia_core]
 [<e09c049c>] bind_request+0x10c/0x230 [ds]
 [<e09f5ff5>] pcmcia_get_socket_by_nr+0x25/0xb0 [pcmcia_core]
 [<e09c106c>] ds_ioctl+0x52c/0x670 [ds]
 [<c0316930>] sock_def_readable+0x80/0x90
 [<c0364291>] unix_dgram_sendmsg+0x451/0x540
 [<c031303e>] sock_sendmsg+0x8e/0xb0
 [<c011ca29>] schedule+0x2f9/0x590
 [<c011ce21>] __wake_up_locked+0x21/0x30
 [<c011cd10>] default_wake_function+0x0/0x20
 [<c0146aae>] zap_pmd_range+0x4e/0x70
 [<c0146b1e>] unmap_page_range+0x4e/0x80
 [<c0146c4d>] unmap_vmas+0xfd/0x220
 [<c014a3a8>] unmap_vma+0x48/0x90
 [<c014a40f>] unmap_vma_list+0x1f/0x30
 [<c014a85a>] do_munmap+0x13a/0x180
 [<c0168500>] sys_ioctl+0x100/0x2a0
 [<c010b40b>] syscall_call+0x7/0xb
 
Code: 89 01 89 d8 8b 75 fc 8b 5d f8 89 ec 5d c3 8b 46 04 c7 04 24
 <6>b44: eth0: Link is down.
b44: eth0: Link is up at 10 Mbps, half duplex.
b44: eth0: Flow control is off for TX and off for RX.
blk: queue dfc5f200, I/O limit 4095Mb (mask 0xffffffff)
NET: Registered protocol family 23
nsc-ircc, Found chip at base=0x04e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500


