Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbTCIOg5>; Sun, 9 Mar 2003 09:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbTCIOg5>; Sun, 9 Mar 2003 09:36:57 -0500
Received: from c10-rba-60.absamail.co.za ([196.39.56.60]:36100 "EHLO
	mail.codefountain.com") by vger.kernel.org with ESMTP
	id <S262515AbTCIOgy>; Sun, 9 Mar 2003 09:36:54 -0500
Date: Sun, 9 Mar 2003 16:51:06 +0200
From: Craig Schlenter <craig.schlenter@absamail.co.za>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] oops with linux-2.5.64 + cset-1.1068.1.17-to-1.1166.gz
Message-ID: <20030309145105.GA11044@codefountain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Anyone interested in a kernel BUG at include/linux/dcache.h:266?

Oops and dmesg is shown below. I can supply more info if needed
but mail responses will be sluggish as I can only check this
email account once per day, sorry.

I think it happened when I control-C'ed wvdial to drop the
ppp connection. 2.5.63 was fine IIRC but it hadn't been used
much on the box (which functions as a dialup firewall on
ancient hardware).

Thank you!

--Craig

Linux version 2.5.64 (root@[snip].com) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #4 Sun Mar 9 15:10:18 SAST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000001000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
16MB LOWMEM available.
On node 0 totalpages: 4096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.5.64 ro root=301 BOOT_FILE=/boot/vmlinuz-2.5.64
Initializing CPU#0
PID hash table entries: 128 (order 7: 1024 bytes)
Detected 100.239 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 196.60 BogoMIPS
Memory: 13616k/16384k available (1234k kernel code, 2356k reserved, 431k data, 260k init, 0k highmem)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 05
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: BIOS32 entry (0xc00fa000) in high memory, cannot use.
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs:  13 entries (12 bytes)
biovec pool[1]:   4 bvecs:   6 entries (48 bytes)
biovec pool[2]:  16 bvecs:   3 entries (192 bytes)
biovec pool[3]:  64 bvecs:   1 entries (768 bytes)
biovec pool[4]: 128 bvecs:   0 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   0 entries (3072 bytes)
Linux Plug and Play Support v0.95 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
block request queues:
 24 requests per read queue
 24 requests per write queue
 3 requests per batch
 enter congestion at 2
 exit congestion at 4
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Cannot allocate resource region 0 of device 00:00.0
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 00 e8 a2 43 c0
eth0: NE2000 found at 0x300, using IRQ 10.
apm: BIOS version 1.1 Flags 0x0a (Driver version 1.16ac)
Journalled Block Device driver loaded
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pty: 2048 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/epic100.html
  (unofficial 2.4.x kernel port, version 1.11+LK1.1.14, Aug 4, 2002)
epic100(00:0d.0): MII transceiver #3 control 3000 status 7849.
epic100(00:0d.0): Autonegotiation advertising 01e1 link partner 0001.
eth1: SMSC EPIC/100 83c170 at 0x1000, IRQ 11, 00:04:e2:09:db:04.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: WDC AC2700F, ATA DISK drive
hdb: 36X CD-ROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 1427328 sectors (731 MB) w/64KiB Cache, CHS=1416/16/63
 hda: hda1 hda2 < hda5 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Adding 98744k swap on /dev/hda5.  Priority:-1 extents:1
spurious 8259A interrupt: IRQ7.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (128 buckets, 1024 max) - 300 bytes per conntrack
Module iptable_nat cannot be unloaded due to unsafe usage in include/linux/module.h:423
Module iptable_filter cannot be unloaded due to unsafe usage in include/linux/module.h:423
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
Module ppp_async cannot be unloaded due to unsafe usage in include/linux/module.h:457
Module bsd_comp cannot be unloaded due to unsafe usage in include/linux/module.h:457
Module ppp_deflate cannot be unloaded due to unsafe usage in include/linux/module.h:457
------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:266!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0167e19>]    Not tainted
EFLAGS: 00010246
EIP is at sysfs_remove_dir+0x19/0x11a
eax: 00000000   ebx: c0891984   ecx: 00000000   edx: 00000000
esi: c0c4a940   edi: 00000000   ebp: 00000100   esp: c08c7f04
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 649, threadinfo=c08c6000 task=c09a4cc0)
Stack: c0891984 c0891800 00000000 00000100 c0191f4b c0891984 c0891984 c0191f6b 
       c0891984 c0891800 c01ecb5b c0891984 c0891800 c0039b60 4004743c ffffffea 
       c1869d58 c0891800 c0891800 c02df8a0 c0039b60 c1867b54 c0039b60 c18531f0 
Call Trace:
 [<c0191f4b>] kobject_del+0xb/0x20
 [<c0191f6b>] kobject_unregister+0xb/0x20
 [<c01ecb5b>] unregister_netdevice+0x1ab/0x270
 [<c1869d58>] ppp_shutdown_interface+0xb8/0x120 [ppp_generic]
 [<c1867b54>] ppp_ioctl+0x784/0x7a0 [ppp_generic]
 [<c18531f0>] ppp_asynctty_ioctl+0x0/0x170 [ppp_async]
 [<c1853360>] ppp_asynctty_poll+0x0/0x10 [ppp_async]
 [<c1853380>] ppp_asynctty_receive+0x0/0xa0 [ppp_async]
 [<c1853370>] ppp_asynctty_room+0x0/0x10 [ppp_async]
 [<c1853420>] ppp_asynctty_wakeup+0x0/0x50 [ppp_async]
 [<c014e11c>] sys_ioctl+0x8c/0x220
 [<c0108fe7>] syscall_call+0x7/0xb

Code: 0f 0b 0a 01 f6 2d 24 c0 ff 06 8b 46 04 83 c8 08 85 f6 89 46 
 
