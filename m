Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUIRWSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUIRWSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 18:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIRWSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 18:18:33 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:63682 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S268145AbUIRWRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 18:17:39 -0400
Message-ID: <2755554.1095545857871.JavaMail.keripukki@jippii.fi>
Date: Sun, 19 Sep 2004 01:17:37 +0300 (EEST)
From: keripukki@jippii.fi
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Disabling IRQ #11 after couple of hours
Mime-Version: 1.0
Content-Type: text/plain; Charset=iso-8859-1; Format=Flowed
Content-Transfer-Encoding: 8BIT
X-Mailer: Saunalahti webmail - http://www.saunalahti.fi
X-Originating-IP: 213.216.233.250
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I use computer for couple of hours, it suddenly starts lagging and 
I'm getting message 'Disabling IRQ #11'. Then I have to reset computer. 
I also get these messages:

end_request: I/O error, dev hde, sector 126792951
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126792951
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

... the message above about 50 times ...

end_request: I/O error, dev hde, sector 202904167
EXT3-fs error (device hde1): ext3_readdir: directory #11141435 contains 
a hole at offset 0
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
end_request: I/O error, dev hde, sector 127164895
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7915824 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126615879
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_get_inode_loc: unable to read inode 
block - inode=7914482, block=15826977
end_request: I/O error, dev hde, sector 126877775
printk: 3 messages suppressed.
Buffer I/O error on device hde1, logical block 15859714
lost page write due to I/O error on hde1
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
end_request: I/O error, dev hde, sector 126615655
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_get_inode_loc: unable to read inode 
block - inode=7913586, block=15826949
end_request: I/O error, dev hde, sector 126616255
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_get_inode_loc: unable to read inode 
block - inode=7915970, block=15827024
end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126757887
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_readdir: directory #7914705 contains a 
hole at offset 0
end_request: I/O error, dev hde, sector 126757887
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7914705 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126785535
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7914623 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126757887
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_readdir: directory #7914705 contains a 
hole at offset 0
end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 126792951
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7913590 
offset 0

end_request: I/O error, dev hde, sector 128328663
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7914710 
offset 0

end_request: I/O error, dev hde, sector 126786023
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_find_entry: reading directory #7915963 
offset 0

end_request: I/O error, dev hde, sector 126353575
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_get_inode_loc: unable to read inode 
block - inode=7897448, block=15794189
end_request: I/O error, dev hde, sector 126353559
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs error (device hde1): ext3_get_inode_loc: unable to read inode 
block - inode=7897407, block=15794187
Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
 [<c01117e4>] __might_sleep+0xb2/0xd3
 [<e09ec2c7>] drm_free+0xb7/0x150 [fglrx]
 [<e09dda7c>] __ke_down_struct_sem+0x2a/0x44 [fglrx]
 [<e09ee06f>] firegl_remove_all_drawables+0x3f/0x100 [fglrx]
 [<e09efd26>] firegl_release_helper+0x546/0x750 [fglrx]
 [<e09e0992>] firegl_takedown+0x32/0xaa0 [fglrx]
 [<e09e00cf>] firegl_release+0x12f/0x190 [fglrx]
 [<c01541ed>] sys_fstat64+0x37/0x39
 [<c014b450>] __fput+0x112/0x124
 [<c0149c02>] filp_close+0x59/0x86
 [<c0149c92>] sys_close+0x63/0x96
 [<c0103eaf>] syscall_call+0x7/0xb
end_request: I/O error, dev hde, sector 4287
Buffer I/O error on device hde1, logical block 528
lost page write due to I/O error on hde1
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11

------------

On boot I get this:

Linux version 2.6.8-gentoo-r3 (root@mikonkone) (gcc version 3.3.4 
20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #5 Thu Sep 16 
14:40:21 Local time zone must be set--see zic manu
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f74b0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7e00
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda3
Initializing CPU#0
CPU 0 irqstacks, hard=c0498000 soft=c0497000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2088.265 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514656k/524224k available (2578k kernel code, 8804k reserved, 
935k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4120.57 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1095517384.008:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xa000, 00:04:61:52:9c:0a, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST330621A, ATA DISK drive
hdb: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0c.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 11
    ide2: MMIO-DMA , BIOS settings: hde:DMA, hdf:DMA
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y120M0, ATA DISK drive
ide2 at 0xe0848080-0xe0848087,0xe084808a on irq 11
hdg: no response (status = 0xfe)
hdg: no response (status = 0xfe), resetting drive
hdg: no response (status = 0xfe)
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/512KiB Cache, CHS=58168/16/63, UDMA(100)
 hda: hda1 hda2 hda3
hde: max request size: 64KiB
hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63
 hde: hde1
irq 11: nobody cared!
 [<c01056f1>] __report_bad_irq+0x2a/0x8b
 [<c01057db>] note_interrupt+0x6f/0x9f
 [<c0105ac3>] do_IRQ+0x17c/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0117c2f>] __do_softirq+0x2f/0x80
 [<c01062c2>] do_softirq+0x43/0x52
 =======================
 [<c0105a9c>] do_IRQ+0x155/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0101f71>] default_idle+0x23/0x26
 [<c0101fcf>] cpu_idle+0x2c/0x35
 [<c047068b>] start_kernel+0x165/0x17f
 [<c04702e5>] unknown_bootoption+0x0/0x149
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
Disabling IRQ #11
hde: lost interrupt
irq 11: nobody cared!
 [<c01056f1>] __report_bad_irq+0x2a/0x8b
 [<c01057db>] note_interrupt+0x6f/0x9f
 [<c0105ac3>] do_IRQ+0x17c/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0105687>] handle_IRQ_event+0x24/0x64
 [<c0105a13>] do_IRQ+0xcc/0x1a8
 =======================
 [<c0270e15>] task_no_data_intr+0x0/0x95
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0270e15>] task_no_data_intr+0x0/0x95
 [<c026ca3b>] ide_timer_expiry+0x118/0x220
 [<c026c923>] ide_timer_expiry+0x0/0x220
 [<c011ba2a>] run_timer_softirq+0xce/0x1ae
 [<c0117c7e>] __do_softirq+0x7e/0x80
 [<c01062c2>] do_softirq+0x43/0x52
 =======================
 [<c0105a9c>] do_IRQ+0x155/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0101f71>] default_idle+0x23/0x26
 [<c0101fcf>] cpu_idle+0x2c/0x35
 [<c047068b>] start_kernel+0x165/0x17f
 [<c04702e5>] unknown_bootoption+0x0/0x149
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
Disabling IRQ #11
hdb: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
libata version 1.02 loaded.
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11] 
MMIO=[eb002000-eb0027ff] Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 5, pci mem e085e000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 5, pci mem e0860000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 11, pci mem e0862000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
USB Universal Host Controller Interface driver v2.2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 
14:31:44 2004 UTC).
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49347 usecs
intel8x0: clocking to 47373
ALSA device list:
  #0: NVidia nForce2 at 0xec001000, irq 5
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 498952k swap on /dev/hda2.  Priority:-1 extents:1
hde: sata_error = 0x00090000, watchdog = 1, siimage_mmio_ide_dma_test_irq
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0004610000052c50]
hde: dma_timer_expiry: dma status == 0x61
hde: DMA timeout error
hde: dma timeout error: status=0xd0 { Busy }

hde: DMA disabled
ide2: reset phy, status=0x00000113, siimage_reset
ide2: reset timed-out, status=0xd0
hde: status timeout: status=0xd0 { Busy }

ide2: reset phy, status=0x00000113, siimage_reset
hde: drive not ready for command
irq 11: nobody cared!
 [<c01056f1>] __report_bad_irq+0x2a/0x8b
 [<c01057db>] note_interrupt+0x6f/0x9f
 [<c0105ac3>] do_IRQ+0x17c/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0117c2f>] __do_softirq+0x2f/0x80
 [<c01062c2>] do_softirq+0x43/0x52
 =======================
 [<c0105a9c>] do_IRQ+0x155/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0101f71>] default_idle+0x23/0x26
 [<c0101fcf>] cpu_idle+0x2c/0x35
 [<c047068b>] start_kernel+0x165/0x17f
 [<c04702e5>] unknown_bootoption+0x0/0x149
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
ide2: reset phy dead, status=0x00000000
ide2: host reset_poll failure for hde.
hde: status timeout: status=0xd0 { Busy }

ide2: reset phy, status=0x00000000, siimage_reset
ide2: reset phy dead, status=0x00000000
hde: drive not ready for command
irq 11: nobody cared!
 [<c01056f1>] __report_bad_irq+0x2a/0x8b
 [<c01057db>] note_interrupt+0x6f/0x9f
 [<c0105ac3>] do_IRQ+0x17c/0x1a8
 [<c026e06a>] reset_pollfunc+0x0/0x1b9
 [<c010401c>] common_interrupt+0x18/0x20
 [<c026e06a>] reset_pollfunc+0x0/0x1b9
 [<c026ca3b>] ide_timer_expiry+0x118/0x220
 [<c026c923>] ide_timer_expiry+0x0/0x220
 [<c011ba2a>] run_timer_softirq+0xce/0x1ae
 [<c0117c7e>] __do_softirq+0x7e/0x80
 [<c01062c2>] do_softirq+0x43/0x52
 =======================
 [<c0105a9c>] do_IRQ+0x155/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0101f71>] default_idle+0x23/0x26
 [<c0101fcf>] cpu_idle+0x2c/0x35
 [<c047068b>] start_kernel+0x165/0x17f
 [<c04702e5>] unknown_bootoption+0x0/0x149
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
ide2: reset phy dead, status=0x00000000
ide2: host reset_poll failure for hde.
end_request: I/O error, dev hde, sector 65
irq 11: nobody cared!
 [<c01056f1>] __report_bad_irq+0x2a/0x8b
 [<c01057db>] note_interrupt+0x6f/0x9f
 [<c0105ac3>] do_IRQ+0x17c/0x1a8
 [<c026e06a>] reset_pollfunc+0x0/0x1b9
 [<c010401c>] common_interrupt+0x18/0x20
 [<c026e06a>] reset_pollfunc+0x0/0x1b9
 [<c026ca3b>] ide_timer_expiry+0x118/0x220
 [<c026c923>] ide_timer_expiry+0x0/0x220
 [<c011ba2a>] run_timer_softirq+0xce/0x1ae
 [<c0117c7e>] __do_softirq+0x7e/0x80
 [<c01062c2>] do_softirq+0x43/0x52
 =======================
 [<c0105a9c>] do_IRQ+0x155/0x1a8
 [<c010401c>] common_interrupt+0x18/0x20
 [<c0101f71>] default_idle+0x23/0x26
 [<c0101fcf>] cpu_idle+0x2c/0x35
 [<c047068b>] start_kernel+0x165/0x17f
 [<c04702e5>] unknown_bootoption+0x0/0x149
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
EXT3-fs: unable to read superblock
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c026cbed>] (ide_intr+0x0/0x18e)
[<c029fa97>] (ohci_irq_handler+0x0/0x80e)
[<c02b208f>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #11
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 6727 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
/dev/vmnet: open called by PID 6738 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 6897 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 6918 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened

---


Kernel version is 2.6.8-gentoo. I can't give better from /proc/version 
because I'm running with different (2.4) kernel now.

I have EPOX 8RDA3+ and I have tested using kernel without usb and acpi 
(which I thought would cause problem) but I still got same errors.

lspci -vvv

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [40] AGP version 3.0
Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ 
AGP3+ Rate=x4,x8
Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
        Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
(rev c1)
        Subsystem: Unknown device 1695:1000
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev c1)
        Subsystem: Unknown device 1695:1000
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev c1)
        Subsystem: Unknown device 1695:1000
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev c1)
        Subsystem: Unknown device 1695:1000
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev c1)
        Subsystem: Unknown device 1695:1000
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: Unknown device 1695:1000
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Unknown device 1695:1000
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at e000 [size=32]
        Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1695:1000
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ec003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1695:1000
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at ec004000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 20 [EHCI])
        Subsystem: Unknown device 1695:1000
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 5
        Region 0: Memory at ec005000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
        Subsystem: Unknown device 1695:1000
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at e400 [size=8]
        Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 
AC97 Audio Controler (MCP) (rev a1)
        Subsystem: Unknown device 1695:1001
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d000 [size=256]
        Region 1: I/O ports at d400 [size=128]
        Region 2: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: ea000000-ebffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) 
(prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device 1695:1000
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) 
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: c0000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Unknown device 1695:9001
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a000 [size=256]
        Region 1: Memory at eb000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:0c.0 RAID bus controller: Silicon Image, Inc. (formerly CMD 
Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 
02)
Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 
SATARaid Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 01
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a400 [size=8]
        Region 1: I/O ports at a800 [size=4]
        Region 2: I/O ports at ac00 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at b400 [size=16]
        Region 5: Memory at eb001000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:01:0d.0 FireWire (IEEE 1394): Agere Systems (former Lucent 
Microelectronics) FW323 (rev 61) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1695:9015
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 6000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at eb002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 VGA compatible controller: ATI Technologies Inc RV350 AP 
[Radeon 9600] (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd PowerColor R96A-C3N
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at e9000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- 
FW+ AGP3+ Rate=x4,x8
Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.1 Display controller: ATI Technologies Inc RV350 AP [Radeon 
9600] (Secondary)
        Subsystem: C.P. Technology Co. Ltd PowerColor R96A-C3N (Secondary)
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Region 0: Memory at d0000000 (32-bit, prefetchable) [disabled] 
[size=256M]
Region 1: Memory at e9010000 (32-bit, non-prefetchable) [disabled] 
[size=64K]
        Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

__
Älä maksa tekstiviesteistä! Saunalahden Tekstari-GSM-liittymällä lähetät tekstiviestit maksutta kaikkiin liittymiin (1000 kpl/kk).
http://saunalahti.fi

