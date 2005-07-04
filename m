Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVGDQUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVGDQUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVGDQUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:20:23 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:38788 "EHLO
	vrapenec.doma") by vger.kernel.org with ESMTP id S261416AbVGDQOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:14:06 -0400
Message-ID: <42C96047.60602@ribosome.natur.cuni.cz>
Date: Mon, 04 Jul 2005 18:13:59 +0200
From: Martin Mokrejs <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050531
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Two 2.6.13-rc1 kernel crashes
Content-Type: multipart/mixed;
 boundary="------------010502070207000707010008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502070207000707010008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
  I use on i686 architecture Gentoo linux with XFS filesystem.
Recently it happened to me 3 time that the machine locked,
although at least once sys-rq+b worked. Here is the log
from remote console. I don't remeber having such problems
with 2.6.12-rc6-git2, which was my previous testing kernel.
The problems appear under heavy load when I compile/install
some packages and maybe it's just a bad coincidence or not,
when I move my usb mouse in fvwm2 environment. The machine
locks.
Any clues? Please Cc: me in replies.
Martin

--------------010502070207000707010008
Content-Type: text/plain;
 name="crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="crash.txt"

Linux version 2.6.13-rc1 (root@aquarius) (gcc version 3.4.4 (Gentoo 3.4.4, ssp-3.4.4-1.0, pie-8.7.8)) #2 Mon Jul 4 01:13:46 CEST 2005
BIOS-provided physical RAM map:                                                   
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)                          
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)                        
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bff30000 (usable)
 BIOS-e820: 00000000bff30000 - 00000000bff40000 (ACPI data)
 BIOS-e820: 00000000bff40000 - 00000000bfff0000 (ACPI NVS)
 BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c0000000 (gap: c0000000:3fb80000)
Built 1 zonelists
Kernel command line: root=/dev/sda2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792 idebus=66
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
ide_setup: idebus=66
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3228.252 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3112324k/3144896k available (2926k kernel code, 31420k reserved, 1612k data, 172k init, 2227392k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6464.39 BogoMIPS (lpj=12928798)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:08: ioport range 0x680-0x6ff has been reserved
pnp: 00:08: ioport range 0x290-0x297 has been reserved
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
SGI XFS with no debug enabled
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 160x64
radeonfb (0000:01:00.0): ATI Radeon Ya 
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 17
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 17
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 17
ata1: dev 0 ATA, max UDMA/133, 586072368 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: ST3300831AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
st: Version 20050501, fixed bufsize 32768, s/g segs 256
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 20 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:03:03.0, from 11 to 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[18]  MMIO=[feaff800-feafffff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ieee1394: Loaded AMDTP driver
ieee1394: Loaded CMP driver
usbmon: debugs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Using IPI Shortcut mode
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K ILAN 
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
input: AT Translated Set 2 keyboard on isa0060/serio0
UDF-fs: No VRS found
XFS mounting filesystem sda2
Starting XFS recovery on filesystem: sda2 (dev: sda2)
Ending XFS recovery on filesystem: sda2 (dev: sda2)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
Adding 11896124k swap on /dev/sda3.  Priority:-1 extents:1
------------[ cut here ]------------
kernel BUG at kernel/sched.c:2731!
invalid operand: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: radeon drm parport_pc lp parport snd_rtctimer snd_seq_virmidi snd_seq_midi snd_rawmidi snd_intel8x0 snd_ac97_codec sndt
CPU:    0
EIP:    0060:[<c011bdf6>]    Not tainted VLI
EFLAGS: 00010297   (2.6.13-rc1) 
EIP is at sub_preempt_count+0x27/0x3f
eax: 00000000   ebx: f7750e7c   ecx: f7750e8c   edx: 00000001
esi: 00000000   edi: 00000001   ebp: f79a3d74   esp: f79a3d74
ds: 007b   es: 007b   ss: 0068
Process xfsbufd (pid: 168, threadinfo=f79a2000 task=f788ab10)
Stack: f79a3d9c c02d5e15 f7755ef8 f77903fc f7750e8c e76bb080 00000002 f79a3dec 
       f7750e8c 00000008 f79a3e0c c02d5f0f 00000010 f7750e7c f7750e8c 00000008 
       f79a2000 e76bb080 00000001 00000000 f788ab10 c0132aee f79a3dec f79a3dec 
Call Trace:
 [<c0103e0c>] show_stack+0x7a/0x90
 [<c0103f91>] show_registers+0x156/0x1ce
 [<c0104196>] die+0xf4/0x17e
 [<c01042a1>] do_trap+0x81/0xb8
 [<c010457b>] do_invalid_op+0xa3/0xad
 [<c0103a6b>] error_code+0x4f/0x54
 [<c02d5e15>] get_request+0x29e/0x2d1
 [<c02d5f0f>] get_request_wait+0xc7/0x11a
 [<c02d67e9>] __make_request+0x95/0x462
 [<c02d6ebf>] generic_make_request+0x71/0x1e7
 [<c02d7089>] submit_bio+0x54/0xd4
 [<c021f424>] _pagebuf_ioapply+0x16e/0x290
 [<c021f581>] pagebuf_iorequest+0x3b/0x152
 [<c0224bc1>] xfs_bdstrat_cb+0x34/0x41
 [<c021fe5c>] xfsbufd+0x16c/0x208
 [<c0101355>] kernel_thread_helper+0x5/0xb
Code: 40 c0 eb e1 55 89 c2 b8 00 e0 ff ff 21 e0 8b 40 14 89 e5 39 d0 7c 14 81 fa fe 00 00 00 76 16 b8 00 e0 ff ff 21 e0 29 50 14 5d c3 <0 
 <1>Unable to handle kernel paging request at virtual address f79a3dec
 printing eip:
c0132a27
*pde = 00637067
Oops: 0002 [#2]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: radeon drm parport_pc lp parport snd_rtctimer snd_seq_virmidi snd_seq_midi snd_rawmidi snd_intel8x0 snd_ac97_codec sndt
CPU:    0
EIP:    0060:[<c0132a27>]    Not tainted VLI                                                           
EFLAGS: 00010046   (2.6.13-rc1)                                                                        
EIP is at prepare_to_wait_exclusive+0x37/0x7f                                                          
eax: f79a3dec   ebx: f6133b30   ecx: 00000001   edx: f6133b3c                                          
esi: f7750ea8   edi: 00000002   ebp: f6133aec   esp: f6133adc                                          
ds: 007b   es: 007b   ss: 0068                                                                         
Process rm (pid: 11326, threadinfo=f6132000 task=e5545b10)                                             
Stack: 00000002 f6133b3c f7750e8c 00000008 f6133b5c c02d5efa 00000010 f7750e7c                         
       f7750e8c 00000008 f6132000 c29b90d0 00000001 00000000 e5545b10 c0132aee                         
       f6133b3c f6133b3c c013fad6 00011220 00011220 00000001 e5545b10 c0132aee                         
Call Trace:                                                                                            
 [<c0103e0c>] show_stack+0x7a/0x90                                                                     
 [<c0103f91>] show_registers+0x156/0x1ce                                                               
 [<c0104196>] die+0xf4/0x17e                                                                           
 [<c0117655>] do_page_fault+0x434/0x613                                                                
 [<c0103a6b>] error_code+0x4f/0x54                                                                     
 [<c02d5efa>] get_request_wait+0xb2/0x11a                                                              
 [<c02d67e9>] __make_request+0x95/0x462                                                                
 [<c02d6ebf>] generic_make_request+0x71/0x1e7                                                          
 [<c02d7089>] submit_bio+0x54/0xd4                                                                     
 [<c021f424>] _pagebuf_ioapply+0x16e/0x290                                                             
 [<c021f581>] pagebuf_iorequest+0x3b/0x152                                                             
 [<c0203993>] xlog_bdstrat_cb+0x19/0x4a
 [<c020423f>] xlog_sync+0x225/0x4a1
 [<c0205c24>] xlog_state_release_iclog+0xce/0x116
 [<c020493d>] xlog_write+0x3bd/0x4b1
 [<c0203502>] xfs_log_write+0x46/0x75
 [<c0210b6c>] xfs_trans_commit+0x102/0x3d3
 [<c02188f1>] xfs_remove+0x315/0x41c
 [<c0222edd>] linvfs_unlink+0x21/0x5b
 [<c016aefe>] vfs_unlink+0x159/0x194
 [<c016afd5>] sys_unlink+0x9c/0x108
 [<c0102f67>] sysenter_past_esp+0x54/0x75
Code: 89 7d fc 89 4d f0 89 c6 89 d3 83 0a 01 9c 5f fa b8 01 00 00 00 e8 87 93 fe ff 8d 53 0c 39 53 0c 75 0e 8b 46 04 89 73 0c 89 56 04 <8 
 <6>note: rm[11326] exited with preempt_count 2
scheduling while atomic: rm/0x10000002/11326
 [<c0103e39>] dump_stack+0x17/0x19
 [<c03d9fe3>] schedule+0x58d/0x653
 [<c03da8b3>] cond_resched+0x25/0x40
 [<c014b455>] unmap_vmas+0x15e/0x209
 [<c014fbc5>] exit_mmap+0x7d/0x156



--------------010502070207000707010008--
