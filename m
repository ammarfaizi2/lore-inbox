Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312872AbSDBSDW>; Tue, 2 Apr 2002 13:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312883AbSDBSDN>; Tue, 2 Apr 2002 13:03:13 -0500
Received: from adsl-66-124-75-211.dsl.sntc01.pacbell.net ([66.124.75.211]:61454
	"EHLO yenveedu.com") by vger.kernel.org with ESMTP
	id <S312872AbSDBSDH>; Tue, 2 Apr 2002 13:03:07 -0500
Date: Tue, 2 Apr 2002 23:33:05 +0530
From: Dionysius Wilson Almeida <dwilson@yenveedu.com>
To: linux-kernel@vger.kernel.org
Subject: Problem : QLogic QLA104x PCI SCSI Adapter with HP CDWriter+ 9200
Message-ID: <20020402233305.A19116@yenveedu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii

Hi Everyone,

I'm using QLogic QLA104x PCI SCSI Adapter with HP CDWriter+ 9200.
The QLogic BIOS version is 6.14, ISP Firmware 4.50.

During the bootup, I see :

scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 

But eventually it recognizes the CD Writer and configures it.

I'm able to burn CD also without much difficulty although sometimes during
the fixating stage, it gives error.

The problem comes when I try to mount either the newly burnt CD or for
that matter any other CDs.  I've also verified that the newly burnt CD works
by putting that CD in my laptop which runs the same kernel with same options
enabled like : SCSI support, SCSI CDROM support etc.

So far I've been unable to understand what is wrong and how to correct this
situation.

Just another piece of information : On the same system with Win98, Windows
shows every CD that i put in this drive as some CDDA image.

Please help me as I've been unable to get any meaningful help from HP support.
They say that it's an issue with my SCSI adapter.

I'm attaching the bootup message and also the message which gets written to
syslog when i try to mount any CD.

Thanks for your time and help,

-Wilson

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"

Linux version 2.4.17 (dwilson@lenny) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #2 Wed Mar 13 20:15:49 IST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
On node 0 totalpages: 130800
zone(0): 4096 pages.
zone(1): 126704 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: mem=523200K
Initializing CPU#0
Detected 601.378 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1199.30 BogoMIPS
Memory: 512212k/523200k available (1471k kernel code, 10600k reserved, 438k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 601.3833 MHz.
..... host bus clock speed is 100.2304 MHz.
cpu: 0, clocks: 1002304, slice: 501152
CPU0<T0:1002304,T1:501152,D:0,S:501152,C:1002304>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb2d0, last bus=1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.09 <tigran@veritas.com>
Starting kswapd
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
i810_rng hardware driver 0.9.6 loaded
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 96147U8, ATA DISK drive
hdc: ST38410A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 120060864 sectors (61471 MB) w/2048KiB Cache, CHS=7473/255/63
hdc: 16841664 sectors (8623 MB) w/512KiB Cache, CHS=16708/16/63
Partition check:
 hda: hda1 hda2 hda3
 hdc: [PTBL] [1048/255/63] hdc1 hdc2 < hdc5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: Detected an Intel i810 Chipset.
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on Intel i810 @ 0xd0000000 64MB
[drm] Initialized i810 1.1.0 20010616 on minor 0
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 01:09.0
PCI: Sharing IRQ 11 with 00:1f.5
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 48 irq 11 MEM base 0xe08a5000
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
scsi : aborting command due to timeout : pid 6, scsi0, channel 0, id 6, lun 0 0x12 00 00 00 ff 00 
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 265064k swap-space (priority -1)
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
reiserfs: checking transaction log (device 3a:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:04) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Found IRQ 5 for device 01:0b.0
PCI: Sharing IRQ 5 with 00:1f.2
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  Index #1 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
tulip0:  Index #3 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
tulip0:  Index #4 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
tulip0:  MII transceiver #1 config 3100 status 7809 advertising 01e1.
eth0: Davicom DM9102/DM9102A rev 49 at 0xc400, 00:80:AD:83:DD:44, IRQ 5.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
apm: overridden by ACPI.
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 01:09.0
PCI: Setting latency timer of device 00:1f.5 to 64
mtrr: base(0xd0000000) is not aligned on a size(0x180000) boundary

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="error-message.log"

Apr  2 23:19:16 lenny kernel: SCSI cdrom error : host 0 channel 0 id 6 lun 0 return code = 28000002
Apr  2 23:19:16 lenny kernel: Info fld=0x10, Current sd0b:00: sns = f0  4
Apr  2 23:19:16 lenny kernel: ASC=44 ASCQ=54
Apr  2 23:19:16 lenny kernel: Raw sense data:0xf0 0x00 0x04 0x00 0x00 0x00 0x10 0x12 0x00 0x00 0x00 0x00 0x44 0x54 0x00 0x00 0x00 0x00 0x00 0x00 0x54 0x04 0x00 0x00 0x00 0x00
Apr  2 23:19:16 lenny kernel:  I/O error: dev 0b:00, sector 64
Apr  2 23:19:16 lenny kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16


--AqsLC8rIMeq19msA--
