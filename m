Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129713AbRBUCiG>; Tue, 20 Feb 2001 21:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131259AbRBUCh5>; Tue, 20 Feb 2001 21:37:57 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:17934 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129713AbRBUCho>;
	Tue, 20 Feb 2001 21:37:44 -0500
Message-ID: <3A9329DD.FEE6D5B0@sh0n.net>
Date: Tue, 20 Feb 2001 21:37:17 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.4.2-pre4 - kernel BUG at inode.c:885!
Content-Type: multipart/mixed;
 boundary="------------C03D05E7CAF1A6F06E1DF699"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C03D05E7CAF1A6F06E1DF699
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

My friend has Linux on an Pentium Overdrive system I've attached the
dmesg and kern.log files.

Shawn.

--------------C03D05E7CAF1A6F06E1DF699
Content-Type: text/plain; charset=iso-8859-15;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.2-pre4 (root@stucko) (gcc version 2.95.3 20010125 (prerelease)) #1 Mon Feb 19 18:37:12 EST 2001
BIOS-provided physical RAM map:
 BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-88: 0000000001700000 @ 0000000000100000 (usable)
On node 0 totalpages: 6144
zone(0): 4096 pages.
zone(1): 2048 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 BOOT_FILE=/vmlinuz
Initializing CPU#0
Detected 83.524 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 166.29 BogoMIPS
Memory: 22012k/24576k available (1069k kernel code, 2176k reserved, 422k data, 56k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 0000013f 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 0000013f 00000000 00000000 00000000
CPU: After generic, caps: 0000013f 00000000 00000000 00000000
CPU: Common caps: 0000013f 00000000 00000000 00000000
CPU: Intel OverDrive PODP5V83 stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
isapnp: Scanning for Pnp cards...
isapnp: Card 'Adaptec AVA-1505AI'
isapnp: Card '3Com 3C509B EtherLink III'
isapnp: 2 Plug & Play cards detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 14528kB/4842kB, 64 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: ST3491A D, ATA DISK drive
hdb: QUANTUM PD210A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 836070 sectors (428 MB) w/120KiB Cache, CHS=899/15/62
hdb: 408564 sectors (209 MB) w/32KiB Cache, CHS=873/13/36
Partition check:
 hda: hda1 hda2
 hdb: hdb1 hdb2
paride: epat registered as protocol 0
pd: pd version 1.05, major 45, cluster 64, nice 0
pda: Sharing parport0 at 0x378
pda: epat 1.01, Shuttle EPAT chip c6 at 0x378, mode 1 (5/3), delay 1
pda: AVATAR  AR2250, master, 489472 blocks [239M], (956/16/32), removable media
 pda: unknown partition table
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
eth0: 3c509 at 0x220, 10baseT port, address  00 a0 24 46 41 c0, IRQ 5.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
Serial driver version 5.02 (2000-08-09) with ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 3M
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
[drm:radeon_init] *ERROR* Cannot initialize agpgart module.
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
eth0: Setting Rx mode to 1 addresses.

--------------C03D05E7CAF1A6F06E1DF699
Content-Type: text/plain; charset=iso-8859-15;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.log"

Feb 20 21:31:59 stucko kernel: Loaded 8964 symbols from /boot/System.map-2.4.2-pre4.
Feb 20 21:31:59 stucko kernel: Symbols match kernel version 2.4.2.
Feb 20 21:31:59 stucko kernel: No module symbols loaded.
Feb 20 21:31:59 stucko kernel: Linux version 2.4.2-pre4 (root@stucko) (gcc version 2.95.3 20010125 (prerelease)) #1 Mon Feb 19 18:37:12 EST 2001
Feb 20 21:31:59 stucko kernel: BIOS-provided physical RAM map:
Feb 20 21:31:59 stucko kernel:  BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
Feb 20 21:31:59 stucko kernel:  BIOS-88: 0000000001700000 @ 0000000000100000 (usable)
Feb 20 21:31:59 stucko kernel: On node 0 totalpages: 6144
Feb 20 21:31:59 stucko kernel: zone(0): 4096 pages.
Feb 20 21:31:59 stucko kernel: zone(1): 2048 pages.
Feb 20 21:31:59 stucko kernel: zone(2): 0 pages.
Feb 20 21:31:59 stucko kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=302 BOOT_FILE=/vmlinuz
Feb 20 21:31:59 stucko kernel: Initializing CPU#0
Feb 20 21:31:59 stucko kernel: Detected 83.524 MHz processor.
Feb 20 21:31:59 stucko kernel: Console: colour VGA+ 80x25
Feb 20 21:31:59 stucko kernel: Calibrating delay loop... 166.29 BogoMIPS
Feb 20 21:31:59 stucko kernel: Memory: 22012k/24576k available (1069k kernel code, 2176k reserved, 422k data, 56k init, 0k highmem)
Feb 20 21:31:59 stucko kernel: Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Feb 20 21:31:59 stucko kernel: Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Feb 20 21:31:59 stucko kernel: Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Feb 20 21:31:59 stucko kernel: Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Feb 20 21:31:59 stucko kernel: CPU: Before vendor init, caps: 0000013f 00000000 00000000, vendor = 0
Feb 20 21:31:59 stucko kernel: Intel Pentium with F0 0F bug - workaround enabled.
Feb 20 21:31:59 stucko kernel: CPU: After vendor init, caps: 0000013f 00000000 00000000 00000000
Feb 20 21:31:59 stucko kernel: CPU: After generic, caps: 0000013f 00000000 00000000 00000000
Feb 20 21:31:59 stucko kernel: CPU: Common caps: 0000013f 00000000 00000000 00000000
Feb 20 21:31:59 stucko kernel: CPU: Intel OverDrive PODP5V83 stepping 02
Feb 20 21:31:59 stucko kernel: Checking 'hlt' instruction... OK.
Feb 20 21:31:59 stucko kernel: POSIX conformance testing by UNIFIX
Feb 20 21:31:59 stucko kernel: isapnp: Scanning for Pnp cards...
Feb 20 21:31:59 stucko kernel: isapnp: Card 'Adaptec AVA-1505AI'
Feb 20 21:31:59 stucko kernel: isapnp: Card '3Com 3C509B EtherLink III'
Feb 20 21:31:59 stucko kernel: isapnp: 2 Plug & Play cards detected total
Feb 20 21:31:59 stucko kernel: Linux NET4.0 for Linux 2.4
Feb 20 21:31:59 stucko kernel: Based upon Swansea University Computer Society NET3.039
Feb 20 21:31:59 stucko kernel: Starting kswapd v1.8
Feb 20 21:31:59 stucko kernel: parport0: PC-style at 0x378 [PCSPP(,...)]
Feb 20 21:31:59 stucko kernel: Detected PS/2 Mouse Port.
Feb 20 21:31:59 stucko kernel: pty: 256 Unix98 ptys configured
Feb 20 21:31:59 stucko kernel: block: queued sectors max/low 14528kB/4842kB, 64 slots per queue
Feb 20 21:31:59 stucko kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Feb 20 21:31:59 stucko kernel: ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
Feb 20 21:31:59 stucko kernel: hda: ST3491A D, ATA DISK drive
Feb 20 21:31:59 stucko kernel: hdb: QUANTUM PD210A, ATA DISK drive
Feb 20 21:31:59 stucko kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 20 21:31:59 stucko kernel: hda: 836070 sectors (428 MB) w/120KiB Cache, CHS=899/15/62
Feb 20 21:31:59 stucko kernel: hdb: 408564 sectors (209 MB) w/32KiB Cache, CHS=873/13/36
Feb 20 21:31:59 stucko kernel: Partition check:
Feb 20 21:31:59 stucko kernel:  hda: hda1 hda2
Feb 20 21:31:59 stucko kernel:  hdb: hdb1 hdb2
Feb 20 21:31:59 stucko kernel: paride: epat registered as protocol 0
Feb 20 21:31:59 stucko kernel: pd: pd version 1.05, major 45, cluster 64, nice 0
Feb 20 21:31:59 stucko kernel: pda: Sharing parport0 at 0x378
Feb 20 21:31:59 stucko kernel: pda: epat 1.01, Shuttle EPAT chip c6 at 0x378, mode 1 (5/3), delay 1
Feb 20 21:31:59 stucko kernel: pda: AVATAR  AR2250, master, 489472 blocks [239M], (956/16/32), removable media
Feb 20 21:31:59 stucko kernel:  pda: unknown partition table
Feb 20 21:31:59 stucko kernel: Floppy drive(s): fd0 is 1.44M
Feb 20 21:31:59 stucko kernel: FDC 0 is an 8272A
Feb 20 21:31:59 stucko kernel: eth0: 3c509 at 0x220, 10baseT port, address  00 a0 24 46 41 c0, IRQ 5.
Feb 20 21:31:59 stucko kernel: 3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
Feb 20 21:31:59 stucko kernel: Serial driver version 5.02 (2000-08-09) with ISAPNP enabled
Feb 20 21:31:59 stucko kernel: ttyS00 at 0x03f8 (irq = 4) is a 16450
Feb 20 21:31:59 stucko kernel: ttyS01 at 0x02f8 (irq = 3) is a 16450
Feb 20 21:31:59 stucko kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Feb 20 21:31:59 stucko kernel: agpgart: Maximum main memory to use for agp memory: 3M
Feb 20 21:31:59 stucko kernel: agpgart: no supported devices found.
Feb 20 21:31:59 stucko kernel: [drm] Initialized tdfx 1.0.0 20000928 on minor 63
Feb 20 21:31:59 stucko kernel: [drm:radeon_init] *ERROR* Cannot initialize agpgart module.
Feb 20 21:31:59 stucko kernel: SCSI subsystem driver Revision: 1.00
Feb 20 21:31:59 stucko kernel: request_module[scsi_hostadapter]: Root fs not mounted
Feb 20 21:31:59 stucko kernel: request_module[scsi_hostadapter]: Root fs not mounted
Feb 20 21:31:59 stucko kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 20 21:31:59 stucko kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Feb 20 21:31:59 stucko kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Feb 20 21:31:59 stucko kernel: TCP: Hash tables configured (established 2048 bind 2048)
Feb 20 21:31:59 stucko kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Feb 20 21:31:59 stucko kernel: VFS: Mounted root (ext2 filesystem) readonly.
Feb 20 21:31:59 stucko kernel: Freeing unused kernel memory: 56k freed
Feb 20 21:31:59 stucko kernel: eth0: Setting Rx mode to 1 addresses.
Feb 20 21:35:16 stucko kernel: Unable to identify CD-ROM format.
Feb 20 21:37:05 stucko kernel: VFS: Disk change detected on device pd(45,1)
Feb 20 21:37:05 stucko kernel: pda: AVATAR  AR2250, master, 489472 blocks [239M], (956/16/32), removable media
Feb 20 21:37:05 stucko kernel:  pda: pda1
Feb 20 21:37:05 stucko kernel: EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
Feb 20 21:37:28 stucko kernel: EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
Feb 20 21:38:01 stucko kernel: pda: do_pd_read_drq: status = 0x10150 = SEEK READY AMNF TMO
Feb 20 21:38:01 stucko kernel: pda: do_pd_read_drq: status = 0x10150 = SEEK READY AMNF TMO
Feb 20 21:38:29 stucko kernel: pda: do_pd_write_drq: status = 0x10150 = SEEK READY AMNF TMO
Feb 20 21:38:30 stucko last message repeated 20 times
Feb 20 21:38:30 stucko kernel: pda: do_pd_write_drq: status = 0x12051 = ERR SEEK READY MC TMO
Feb 20 21:38:30 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:30 stucko last message repeated 4 times
Feb 20 21:38:30 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 327690
Feb 20 21:38:30 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:30 stucko last message repeated 5 times
Feb 20 21:38:30 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 344074
Feb 20 21:38:30 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:31 stucko last message repeated 5 times
Feb 20 21:38:31 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 360458
Feb 20 21:38:31 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:31 stucko last message repeated 5 times
Feb 20 21:38:31 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 360460
Feb 20 21:38:31 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:31 stucko last message repeated 5 times
Feb 20 21:38:31 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 376842
Feb 20 21:38:31 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:31 stucko last message repeated 5 times
Feb 20 21:38:31 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 393226
Feb 20 21:38:31 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:32 stucko last message repeated 5 times
Feb 20 21:38:32 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 393228
Feb 20 21:38:32 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:32 stucko last message repeated 5 times
Feb 20 21:38:32 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 425994
Feb 20 21:38:37 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:37 stucko last message repeated 5 times
Feb 20 21:38:37 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 114700
Feb 20 21:38:39 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:40 stucko last message repeated 5 times
Feb 20 21:38:40 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 147466
Feb 20 21:38:40 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:40 stucko last message repeated 5 times
Feb 20 21:38:40 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 180234
Feb 20 21:38:40 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:40 stucko last message repeated 5 times
Feb 20 21:38:40 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 180236
Feb 20 21:38:40 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:41 stucko last message repeated 5 times
Feb 20 21:38:41 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 213002
Feb 20 21:38:41 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:41 stucko last message repeated 5 times
Feb 20 21:38:41 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 213004
Feb 20 21:38:41 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:41 stucko last message repeated 5 times
Feb 20 21:38:41 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 213006
Feb 20 21:38:41 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:41 stucko last message repeated 5 times
Feb 20 21:38:41 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 229386
Feb 20 21:38:41 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:42 stucko last message repeated 5 times
Feb 20 21:38:42 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 229388
Feb 20 21:38:42 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:42 stucko last message repeated 5 times
Feb 20 21:38:42 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 229390
Feb 20 21:38:42 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:42 stucko last message repeated 5 times
Feb 20 21:38:42 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 262156
Feb 20 21:38:42 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:43 stucko last message repeated 5 times
Feb 20 21:38:43 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 262158
Feb 20 21:38:43 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:43 stucko last message repeated 5 times
Feb 20 21:38:44 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 278540
Feb 20 21:38:44 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:44 stucko last message repeated 5 times
Feb 20 21:38:44 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 278542
Feb 20 21:38:44 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:44 stucko last message repeated 5 times
Feb 20 21:38:44 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 278544
Feb 20 21:38:44 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:45 stucko last message repeated 5 times
Feb 20 21:38:45 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 376844
Feb 20 21:38:45 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:45 stucko last message repeated 5 times
Feb 20 21:38:45 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 376846
Feb 20 21:38:45 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:45 stucko last message repeated 5 times
Feb 20 21:38:45 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 409610
Feb 20 21:38:45 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:45 stucko last message repeated 5 times
Feb 20 21:38:45 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 409612
Feb 20 21:38:46 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:46 stucko last message repeated 5 times
Feb 20 21:38:46 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 409614
Feb 20 21:38:46 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:46 stucko last message repeated 5 times
Feb 20 21:38:46 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 409616
Feb 20 21:38:46 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:47 stucko last message repeated 5 times
Feb 20 21:38:47 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 442378
Feb 20 21:38:47 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:47 stucko last message repeated 5 times
Feb 20 21:38:47 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 442380
Feb 20 21:38:47 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:47 stucko last message repeated 5 times
Feb 20 21:38:47 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 442382
Feb 20 21:38:47 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:48 stucko last message repeated 5 times
Feb 20 21:38:48 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 442384
Feb 20 21:38:48 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:48 stucko last message repeated 5 times
Feb 20 21:38:48 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 16394
Feb 20 21:38:48 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:48 stucko last message repeated 5 times
Feb 20 21:38:48 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 16396
Feb 20 21:38:48 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:51 stucko last message repeated 5 times
Feb 20 21:38:51 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 16398
Feb 20 21:38:51 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:51 stucko last message repeated 5 times
Feb 20 21:38:51 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 65546
Feb 20 21:38:51 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:51 stucko last message repeated 5 times
Feb 20 21:38:51 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 81930
Feb 20 21:38:51 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:38:52 stucko last message repeated 5 times
Feb 20 21:38:52 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 81932
Feb 20 21:42:17 stucko kernel: pda: do_pd_read: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:17 stucko last message repeated 5 times
Feb 20 21:42:17 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 344074
Feb 20 21:42:17 stucko kernel: EXT2-fs error (device pd(45,1)): ext2_write_inode: unable to read inode block - inode=42847, block=172037
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 131082
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 131084
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 294922
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 458762
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 2
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32782
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32784
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32786
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32792
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32794
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32796
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32798
Feb 20 21:42:24 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:42:24 stucko last message repeated 5 times
Feb 20 21:42:24 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32800
Feb 20 21:43:38 stucko kernel: pda: do_pd_read_drq: status = 0x12051 = ERR SEEK READY MC TMO
Feb 20 21:43:38 stucko kernel: pda: do_pd_read: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:43:38 stucko last message repeated 4 times
Feb 20 21:43:38 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 131082
Feb 20 21:43:38 stucko kernel: pda: do_pd_read: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:43:38 stucko last message repeated 5 times
Feb 20 21:43:38 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 131082
Feb 20 21:43:38 stucko kernel: EXT2-fs error (device pd(45,1)): ext2_write_inode: unable to read inode block - inode=16326, block=65541
Feb 20 21:43:38 stucko kernel: EXT2-fs error (device pd(45,1)): ext2_write_inode: unable to read inode block - inode=16327, block=65541
Feb 20 21:43:38 stucko kernel: pda: do_pd_read: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:43:38 stucko last message repeated 5 times
Feb 20 21:43:38 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 131074
Feb 20 21:43:38 stucko kernel: EXT2-fs error (device pd(45,1)): read_block_bitmap: Cannot read block bitmap - block_group = 8, block_bitmap = 65537
Feb 20 21:43:38 stucko kernel: pda: do_pd_read: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:43:38 stucko last message repeated 5 times
Feb 20 21:43:38 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 131076
Feb 20 21:43:38 stucko kernel: EXT2-fs error (device pd(45,1)): read_inode_bitmap: Cannot read inode bitmap - block_group = 8, inode_bitmap = 65538
Feb 20 21:43:38 stucko kernel: kernel BUG at inode.c:885!
Feb 20 21:43:38 stucko kernel: invalid operand: 0000
Feb 20 21:43:38 stucko kernel: CPU:    0
Feb 20 21:43:38 stucko kernel: EIP:    0010:[iput+218/348]
Feb 20 21:43:38 stucko kernel: EFLAGS: 00010282
Feb 20 21:43:38 stucko kernel: eax: 0000001b   ebx: c0663280   ecx: c1374000   edx: c0263608
Feb 20 21:43:38 stucko kernel: esi: c0267220   edi: c0612120   ebp: c05c1fa4   esp: c05c1f50
Feb 20 21:43:38 stucko kernel: ds: 0018   es: 0018   ss: 0018
Feb 20 21:43:38 stucko kernel: Process rm (pid: 309, stackpage=c05c1000)
Feb 20 21:43:38 stucko kernel: Stack: c0216722 c02167a2 00000375 c0612120 c0663280 c013cb26 c0663280 00000000 
Feb 20 21:43:38 stucko kernel:        c066ada0 c0136a56 c0612120 c0612120 c0612120 c111e000 c0136b33 c066ada0 
Feb 20 21:43:38 stucko kernel:        c0612120 c05c0000 0805218b 00000000 bffffa64 c0612220 c14cca20 c111e000 
Feb 20 21:43:38 stucko kernel: Call Trace: [d_delete+78/112] [vfs_unlink+246/300] [sys_unlink+167/284] [system_call+51/64] 
Feb 20 21:43:38 stucko kernel: 
Feb 20 21:43:38 stucko kernel: Code: 0f 0b 83 c4 0c eb 6f 39 1b 74 3b f6 83 ec 00 00 00 07 75 26 
Feb 20 21:43:53 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:43:53 stucko last message repeated 5 times
Feb 20 21:43:53 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 32778
Feb 20 21:43:58 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:43:58 stucko last message repeated 5 times
Feb 20 21:43:58 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 131610
Feb 20 21:44:08 stucko kernel: pda: do_pd_write: status = 0x2051 = ERR SEEK READY MC
Feb 20 21:44:08 stucko last message repeated 5 times
Feb 20 21:44:08 stucko kernel: end_request: I/O error, dev 2d:01 (PD), sector 2

--------------C03D05E7CAF1A6F06E1DF699--

