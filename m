Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSGVLXO>; Mon, 22 Jul 2002 07:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGVLXO>; Mon, 22 Jul 2002 07:23:14 -0400
Received: from 67-tor-2.acn.waw.pl ([62.121.69.67]:15744 "EHLO
	67-tor-2.acn.waw.pl") by vger.kernel.org with ESMTP
	id <S316755AbSGVLXF>; Mon, 22 Jul 2002 07:23:05 -0400
Date: Mon, 22 Jul 2002 13:32:59 +0000
From: Karol Olechowskii <karol_olechowski@acn.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: Athlon XP 1800+ segemntation fault
Message-ID: <20020722133259.A1226@acc69-67.acn.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
Organization: Polish-Japanese Institute of Information Technology
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello 

Few days ago I've bought new processor Athlon XP 1800+ to my computer
(MSI K7D Master with 256 MB PC2100 DDR).Before that I've got Athlon ThunderBird
900 processor and everything had been working well till I change to the new one.
Now for every few minutes I've got segmetation fault or immediate system reboot.
Could anyone tell me what's goin' on?

thanks
Karol Olechowski

Kernels log:

Unable to handle kernel paging request at virtual address 087fde40
Jul 21 11:26:01 alpha kernel:  printing eip:
Jul 21 11:26:01 alpha kernel: c01a2942
Jul 21 11:26:01 alpha kernel: *pde = 00000000
Jul 21 11:26:01 alpha kernel: Oops: 0000
Jul 21 11:26:01 alpha kernel: CPU:    0
Jul 21 11:26:01 alpha kernel: EIP:    0010:[<c01a2942>]    Tainted: P
Jul 21 11:26:01 alpha kernel: EFLAGS: 00010002
Jul 21 11:26:01 alpha kernel: eax: c6852f00   ebx: c6852f00   ecx: 00000000   edx: ce562978
Jul 21 11:26:01 alpha kernel: esi: 087fde40   edi: c9461ee0   ebp: ce562000   esp: c9461eb4
Jul 21 11:26:01 alpha kernel: ds: 0018   es: 0018   ss: 0018
Jul 21 11:26:01 alpha kernel: Process bash (pid: 628, stackpage=c9461000)
Jul 21 11:26:01 alpha kernel: Stack: c9461ee0 c9461f4c c6852f24 c01a2a08 c6852f00 c9461ee0 087fde40 bffff268
Jul 21 11:26:01 alpha kernel:        bffff28c ce562000 c9461f28 00001500 00000005 000004bf 00000b3b 7f1c0300
Jul 21 11:26:01 alpha kernel:        01000415 1a131100 170f1200 2f000016 c01a2cbb ce562000 c9461f28 ce562000
Jul 21 11:26:01 alpha kernel: Call Trace:    [<c01a2a08>] [<c01a2cbb>] [<c01a2fe1>] [<c019fb2b>] [<c0141ec9>]
Jul 21 11:26:01 alpha kernel:   [<c01086e7>]
Jul 21 11:26:01 alpha kernel:
Jul 21 11:26:01 alpha kernel: Code: 8b 16 89 d0 f7 d0 23 03 23 17 09 d0 89 03 8b 56 04 89 d0 f7
Jul 21 11:26:01 alpha kernel:  <1>Unable to handle kernel paging request at virtual address 0800000c
Jul 21 11:26:01 alpha kernel:  printing eip:
Jul 21 11:26:01 alpha kernel: c0141a10
Jul 21 11:26:01 alpha kernel: *pde = 00000000
Jul 21 11:26:01 alpha kernel: Oops: 0000
Jul 21 11:26:01 alpha kernel: CPU:    0
Jul 21 11:26:01 alpha kernel: EIP:    0010:[<c0141a10>]    Tainted: P
Jul 21 11:26:01 alpha kernel: EFLAGS: 00010006
Jul 21 11:26:01 alpha kernel: eax: ffffffff   ebx: 00000000   ecx: ce56212c   edx: 08000000
Jul 21 11:26:01 alpha kernel: esi: 00000000   edi: ce56212c   ebp: cebcc1c0   esp: c9461c94
Jul 21 11:26:01 alpha kernel: ds: 0018   es: 0018   ss: 0018
Jul 21 11:26:01 alpha kernel: Process bash (pid: 628, stackpage=c9461000)
Jul 21 11:26:01 alpha kernel: Stack: ce562000 cebcc1c0 00000000 c730b940 00000000 c019f170 ffffffff cebcc1c0
Jul 21 11:26:01 alpha kernel:        00000000 ce56212c ce562000 c86648c0 c1346380 c019e876 ffffffff cebcc1c0
Jul 21 11:26:01 alpha kernel:        00000000 ce562000 c026ad72 cebcc1c0 c86648c0 c1346380 c730b940 00005000
Jul 21 11:26:01 alpha kernel: Call Trace:    [<c019f170>] [<c019e876>] [<c012f6ab>] [<c012fb23>] [<c01236d0>]
Jul 21 11:26:01 alpha kernel:   [<c0123b32>] [<c019f05a>] [<c013620c>] [<c01351c5>] [<c0119a78>] [<c011a05f>]
Jul 21 11:26:01 alpha kernel:   [<c0108cb6>] [<c0113d17>] [<c0113a10>] [<c011f27c>] [<c011f35d>] [<c011f7dd>]
Jul 21 11:26:01 alpha kernel:   [<c011f8a4>] [<c01087d8>] [<c01a2942>] [<c01a2a08>] [<c01a2cbb>] [<c01a2fe1>]
Jul 21 11:26:01 alpha kernel:   [<c019fb2b>] [<c0141ec9>] [<c01086e7>]
Jul 21 11:26:01 alpha kernel:
Jul 21 11:26:01 alpha kernel: Code: 39 6a 0c 75 22 85 f6 75 cb 8b 42 08 89 01 a1 b0 dd 2f c0 52
Jul 21 11:26:01 alpha kernel:  <1>Unable to handle kernel paging request at virtual address 08000000
Jul 21 11:26:01 alpha kernel:  printing eip:
Jul 21 11:26:01 alpha kernel: c0141a93
Jul 21 11:26:01 alpha kernel: *pde = 0eb0e067
Jul 21 11:26:01 alpha kernel: *pte = 00000000
Jul 21 11:26:01 alpha kernel: Oops: 0000
Jul 21 11:26:01 alpha kernel: CPU:    0
Jul 21 11:26:01 alpha kernel: EIP:    0010:[<c0141a93>]    Tainted: P
Jul 21 11:26:01 alpha kernel: EFLAGS: 00010206
Jul 21 11:26:01 alpha kernel: eax: 08000000   ebx: 08000000   ecx: ce56212c   edx: 0000001d
Jul 21 11:26:01 alpha kernel: esi: 00020001   edi: 0000001d   ebp: cbc82168   esp: ce653e18
Jul 21 11:26:01 alpha kernel: ds: 0018   es: 0018   ss: 0018
Jul 21 11:26:01 alpha kernel: Process mc (pid: 626, stackpage=ce653000)
Jul 21 11:26:01 alpha kernel: Stack: ce56200a ce562000 00000000 c0141af6 08000000 0000001d 00020001 c01a1507
Jul 21 11:26:01 alpha kernel:        ce56212c 0000001d 00020001 00000001 ce562000 00000000 080b1009 00000010
Jul 21 11:26:01 alpha kernel:        0a000017 00000001 00000001 00000000 00000000 cbc82168 c031c0c0 ce653fc4
Jul 21 11:26:01 alpha kernel: Call Trace:    [<c0141af6>] [<c01a1507>] [<c012f3b4>] [<c01a3e83>] [<c01a2692>]
Jul 21 11:26:01 alpha kernel:   [<c019e268>] [<c01a24e0>] [<c0135716>] [<c01086e7>]
Jul 21 11:26:01 alpha kernel:
Jul 21 11:26:01 alpha kernel: Code: 81 3b 01 46 00 00 74 15 68 c0 14 25 c0 e8 2b 5a fd ff 83 c4


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Description: Athlon XP 1800+ segemntation fault
Content-Disposition: attachment; filename=index


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sys_info.txt"

Linux version 2.4.19-rc2-ac2 (root@alpha) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Fri Jul 19 17:52:30 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 vga=0x305
Initializing CPU#0
Detected 1533.426 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 256140k/262080k available (1315k kernel code, 5552k reserved, 563k data, 100k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 4096 (order: 3, 32768 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=32017 max_file_pages=0 max_inodes=0 max_dentries=32017
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb130, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router default [1022/700c] at 00:00.0
BIOS failed to enable PCI standards compliance, fixing this error.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
vesafb: framebuffer at 0xe8000000, mapped to 0xd0800000, size 65536k
vesafb: mode is 1024x768x8, linelength=1024, pages=4
vesafb: protected mode interface info at c000:c2e0
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
lp0: using parport0 (polling).
amd768_rng: AMD768 system management I/O registers at 0x600.
amd768_rng hardware driver 0.1.0 loaded
AMD768_pm: AMD768 system management I/O registers at 0x600.
block: 496 slots per queue, batch=124
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: C/H/S=38309/16/255 from BIOS ignored
hda: ST380021A, ATA DISK drive
hdc: LG DVD-ROM DRD-841B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST CD-RW GCE-8240B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:06.0: 3Com PCI 3c905C Tornado at 0xd800. Vers LK1.1.18-ac
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 64M @ 0xf0000000
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LG        Model: DVD-ROM DRD-841B  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HL-DT-ST  Model: CD-RW GCE-8240B   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 0x/38x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/40x writer cd/rw xa/form2 cdda tray
Creative EMU10K1 PCI Audio Driver, version 0.19, 17:53:22 Jul 19 2002
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xd000-0xd01f, IRQ 3
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 100k freed
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
devfs_register(nvidiactl): could not append to parent, err: -17
devfs_register(nvidia0): could not append to parent, err: -17
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(ed)

--zhXaljGHf11kAtnf--
