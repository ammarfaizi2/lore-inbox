Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129565AbRBXT0v>; Sat, 24 Feb 2001 14:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129574AbRBXT0l>; Sat, 24 Feb 2001 14:26:41 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:31228 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S129565AbRBXT03>; Sat, 24 Feb 2001 14:26:29 -0500
From: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sat, 24 Feb 2001 19:29:03 +0000
Reply-To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
X-Mailer: PMMail 1.96a For OS/2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: IDE errors on APM resume
Message-Id: <20010224192636Z129565-28373+276@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Toshiba Libretto I get the following error messages after a resume following an apm -s. Base system is SuSE 6.3 but running the 2.4.2 kernel.

IDE experts: is this anything to worry about?

trevor@trevor5: ~> dmesg
Linux version 2.4.2 (root@trevor5) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #5 Sat Feb 24 00:18:47 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000003f10000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 0000000004010000 (ACPI data)
 BIOS-e820: 0000000000020000 @ 0000000004020000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fef80000 (reserved)
 BIOS-e820: 0000000000006e00 @ 00000000fffe0000 (reserved)
 BIOS-e820: 0000000000000200 @ 00000000fffe6e00 (ACPI NVS)
 BIOS-e820: 0000000000009000 @ 00000000fffe7000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 16400
zone(0): 4096 pages.
zone(1): 12304 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=l242 ro root=306 video=vesa:ywrap
Initializing CPU#0
Detected 166.637 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 332.59 BogoMIPS
Memory: 62608k/65600k available (815k kernel code, 2604k reserved, 280k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU: After generic, caps: 008001bf 00000000 00000000 00000000
CPU: Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Mobile Pentium MMX stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfc5f8, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.14)
Starting kswapd v1.8
vesafb: framebuffer at 0xfd000000, mapped to 0xc5002000, size 1984k
vesafb: mode is 800x480x8, linelength=800, pages=4
vesafb: protected mode interface info at c000:8610
vesafb: pmi: set display start = c00c8646, set palette = c00c8698
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=2539
Console: switching to colour frame buffer device 100x30
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Toshiba System Managment Mode driver v1.7 22/6/2000
block: queued sectors max/low 41389kB/13796kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: FUJITSU MHH2064AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12685680 sectors (6495 MB) w/512KiB Cache, CHS=789/255/63
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: No IRQ known for interrupt pin A of device 00:06.0. Please try using pci=biosirq.
PCI: No IRQ known for interrupt pin B of device 00:06.1. Please try using pci=biosirq.
PCI: No IRQ known for interrupt pin A of device 00:13.0. Please try using pci=biosirq.
PCI: No IRQ known for interrupt pin B of device 00:13.1. Please try using pci=biosirq.
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0eb8, PCI irq0
Socket status: 30000007
Yenta IRQ list 0eb8, PCI irq0
Socket status: 30000007
Yenta IRQ list 0eb8, PCI irq0
Socket status: 30000011
Yenta IRQ list 0eb8, PCI irq0
Socket status: 30000219
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 64220k swap-space (priority -1)
cs: IO port probe 0x1000-0x17ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x370-0x377 0x388-0x38f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: 3Com 3c589, io 0x300, irq 3, hw_addr 00:60:97:8B:2B:2B
  8K FIFO split 5:3 Rx:Tx, auto xcvr
inserting floppy driver for 2.4.2
floppy0: pcmcia=1
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
eth0: flipped to 10baseT
eth0: flipped to 10baseT
<apm -s here>
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest } 
hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest } 
hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest } 
hda: drive not ready for command
ide0: unexpected interrupt, status=0xd0, count=1
ide0: reset: success
Trying to free nonexistent resource <000003a8-000003af>
Trying to free nonexistent resource <000003a8-000003af>
eth0: 3Com 3c589, io 0x300, irq 3, hw_addr 00:60:97:8B:2B:2B
  8K FIFO split 5:3 Rx:Tx, auto xcvr                                   
eth0: flipped to 10baseT
inserting floppy driver for 2.4.2
floppy0: pcmcia=1
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A

trevor5:/ # rpm -qf `which apm`
apmd-3.0beta9-3

After the resume, hdparm reports
trevor5:/ # hdparm /dev/hda                               
                                                          
/dev/hda:                                                 
 multcount    =  0 (off)                                  
 I/O support  =  0 (default 16-bit)                       
 unmaskirq    =  0 (off)                                  
 using_dma    =  0 (off)                                  
 keepsettings =  0 (off)                                  
 nowerr       =  0 (off)                                  
 readonly     =  0 (off)                                  
 readahead    =  8 (on)                                   
 geometry     = 789/255/63, sectors = 12685680, start = 0 

but beforehand it says

trevor5:/ # hdparm /dev/hda                               
                                                          
/dev/hda:                                                 
 multcount    =  8 (on)                                   
 I/O support  =  1 (32-bit)                               
 unmaskirq    =  1 (on)                                   
 using_dma    =  0 (off)                                  
 keepsettings =  0 (off)                                  
 nowerr       =  0 (off)                                  
 readonly     =  0 (off)                                  
 readahead    =  8 (on)                                   
 geometry     = 789/255/63, sectors = 12685680, start = 0 


Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

