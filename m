Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAJFCw>; Wed, 10 Jan 2001 00:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRAJFCm>; Wed, 10 Jan 2001 00:02:42 -0500
Received: from pl1.hushmail.com ([64.40.111.51]:14867 "EHLO pl1.hushmail.com")
	by vger.kernel.org with ESMTP id <S129764AbRAJFCc>;
	Wed, 10 Jan 2001 00:02:32 -0500
From: noodlez@cyber-rights.net
Message-Id: <200101100501.VAA23068@pl1.hushmail.com>
Content-type: multipart/mixed; boundary="Hushpart_boundary_ectyxwLxwfzAIJkzJlMmflxqTRLgLsYu"
Subject: PROBLEMS: computer crash due to overfilling ramfs; iso9660 CD not read correctly
Mime-version: 1.0
To: linux-kernel@vger.kernel.org
Date: Tue, 9 Jan 2001 23:57:02 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Hushpart_boundary_ectyxwLxwfzAIJkzJlMmflxqTRLgLsYu
Content-type: text/plain

----- Begin Hush Signed Message from noodlez@cyber-rights.net -----

hello.
i just compiled a 2.4.0 kernel from stable sources from ftp.us.kernel.org,
 including reiserfs support from the reiserfs patch (www.namesys.com) .
anyway, i compiled the ramfs (resizeable ramdisk) feature as a module, loaded
the module, and mounted a directory and started copying.  i kept copying
files onto it via 'cp' and after each copy, i would check the ram left using
'top'.  everything was fine until i had 500kb of ram left and i copied a
2mb file.  total freeze.  the only thing that would happen is my keystrokes
would output to the screen, and i could also use ALT + F? to change terminals.
 i used the reset button and everything was back to normal.  i don't know
why that happened.
my next problem is with data CD's (iso9660).  I had the same problem with
2.2.x kernels.  after mounting the data CD, it would list fine, but the
data would be corrupted (BMP and TIFF images would appear with lines through
them, sometimes not even recognized as images; mp3's would sound like they
are combined).  the solution would be to 'umount' the directory, open the
cd-rom a little, and close the tray.  after 'mount'ing it, hopefully it
would be fine.  if not, just pop the drive open again, etc. until it worked.
the distribution is slackware 7.1, but most of my software is hand-compiled.
 i read the REPORTING-BUGS file, and here is some of system info ( i hope
it isn't overkill; i'm sorry if it is):
'dmesg' output:
Linux version 2.4.0 (root@darkstar) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Tue Jan 9 18:50:51 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000001f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000fffe0000 (reserved)
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=new ro root=306
Initializing CPU#0
Detected 233.296 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 465.30 BogoMIPS
Memory: 30236k/32768k available (909k kernel code, 2144k reserved, 288k
data, 196k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU: After generic, caps: 008001bf 00000000 00000000 00000000
CPU: Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16X PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: No IRQ known for interrupt pin A of device 00:0b.0. Please try using
pci=biosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device:  DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: IBM-DTTA-351010, ATA DISK drive
hdd: CREATIVEDVD-ROM DVD2240E 12/24/97, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19807200 sectors (10141 MB) w/466KiB Cache, CHS=1232/255/63
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
scsi0 : AdvanSys SCSI 3.2M: PCI Ultra 240 CDB: IO EC00/F, IRQ 11
  Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: UMAX      Model: Astra 2200        Rev: V2.2
  Type:   Scanner                            ANSI SCSI revision: 02
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
fatfs: bogus cluster size
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 120448k swap-space (priority -1)


'lspci -vvv' output:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev
b3)
        Subsystem: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
 <MAbort+ >SERR- <PERR-
        Latency: 32

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev b4)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
 <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0

00:04.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-
if 00 [VGA])
        Subsystem: S3 Inc. ViRGE/DX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at ebff0000 [disabled] [size=64K]

00:05.0 Multimedia video controller: Auravision VxP524
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ebe00000 (32-bit, non-prefetchable) [size=1M]

00:06.0 SCSI storage controller: Advanced System Products, Inc ABP940-U
/ ABP960-U (rev 03)
        Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
 Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort+ <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 1000ns max), cache line size 04
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at ebfeff00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at ebfd0000 [disabled] [size=64K]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-
if fa)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at ffa0 [size=16]

ver_linux output:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux darkstar 2.4.0 #1 Tue Jan 9 18:50:51 EST 2001 i586 unknown
Kernel modules         2.3.21
Gnu C                  egcs-2.91.66
Gnu Make               3.79
Binutils               2.9.1.0.25
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.6
Mount                  2.10l
Net-tools              1.55
Kbd                    0.99
Sh-utils               2.0
Modules Loaded

support for advansys card is built into the kernel (i don't use any modules
from 2.2.17, all are from 2.4.0)
scsi_mod is built in
sg is a module
sr_mod is a module

thank you for your time and I apologize for the length of this e-mail.

----- Begin Hush Signature v1.3 -----
HDZPudR2GKEoiRlY/km9uBrZ7kKwsgOpKiTMidFB7kEoG05WzzSiMXRHGHPLLH0CPIIn
ouod6cWjjM3GN5uxWsbklG44SRLSt3JrDpF0L10dFgLj5sJeSWdsfYPloICqdvAyxO6g
oQl/YKe3jGtFcRu2/Rnsejj2IlmqUdd3PacEhQHiaGlXAl38I/F+nBv8vrC17DXlVixh
xAuzdD+hYL2gbXNe0rGP7eYPtuSemu0gVibBkutjh4/WfS+op14x5NleatgE6TvWCKJx
4PGHQpg2wi359PNZr8a3EbESsTnQwG6bwurqmq1iBMUvH+Hh1xbsqNQHn4C22sDtaVUA
NriT0td+jwLXCBrJZPTtcKt39IO/zmWnbZ83x087FxDaqMQcCmhfw9pZAIKZfa0KvWp/
8YO/Bxli6MTW/0heZUy13bKdsj6WxjrySPsM+92T6kTbM6NksozkovjCSmyuUJHGsb9c
VWw1sH6eLM3Ay8eWyY7GRRK6wgz1mOHiAKJigPgiBurQ

----- End Hush Signature v1.3 -----

--Hushpart_boundary_ectyxwLxwfzAIJkzJlMmflxqTRLgLsYu--


IMPORTANT NOTICE:  If you are not using HushMail, this message could have been read easily by the many people who have access to your open personal email messages.
Get your FREE, totally secure email address at http://www.hushmail.com.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
