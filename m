Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSHaLIf>; Sat, 31 Aug 2002 07:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSHaLId>; Sat, 31 Aug 2002 07:08:33 -0400
Received: from emerald3.kumin.ne.jp ([210.132.100.202]:9711 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S316792AbSHaLI3>; Sat, 31 Aug 2002 07:08:29 -0400
Message-Id: <200208311112.AA00120@prism.kumin.ne.jp>
Date: Sat, 31 Aug 2002 20:12:44 +0900
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.32 boot up but hang up
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
In-Reply-To: <200208041100.AA00109@prism.kumin.ne.jp>
References: <200208041100.AA00109@prism.kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update kernel from linux-2.5.31 to linux-2.5.32.
linux-2.5.32 compile finished fine and boot up,
but hang up ( I could not do any keyin from keyboard ) 

I append syslog ( linux-2.5.31, linux-2.5.32 )

====

Aug 31 17:57:30 homesv kernel: Linux version 2.5.31 (root@homesv) (gcc version 2.95.3 20010315 (release)) #1 Sun Aug 25 
14:49:07 JST 2002
Aug 31 17:57:30 homesv kernel: Video mode to be used for restore is f00
Aug 31 17:57:30 homesv kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Aug 31 17:57:30 homesv kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 31 17:57:30 homesv kernel:  BIOS-e820: 0000000000100000 - 0000000005ffd000 (usable)
Aug 31 17:57:30 homesv kernel:  BIOS-e820: 0000000005ffd000 - 0000000005fff000 (ACPI data)
Aug 31 17:57:30 homesv kernel:  BIOS-e820: 0000000005fff000 - 0000000006000000 (ACPI NVS)
Aug 31 17:57:30 homesv kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 31 17:57:30 homesv kernel:  user: 0000000000000000 - 00000000000a0000 (usable)
Aug 31 17:57:30 homesv kernel:  user: 00000000000f0000 - 0000000000100000 (reserved)
Aug 31 17:57:30 homesv kernel:  user: 0000000000100000 - 0000000005ffd000 (usable)
Aug 31 17:57:30 homesv kernel:  user: 0000000005ffd000 - 0000000005fff000 (ACPI data)
Aug 31 17:57:30 homesv kernel:  user: 0000000005fff000 - 0000000006000000 (ACPI NVS)
Aug 31 17:57:30 homesv kernel:  user: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 31 17:57:30 homesv kernel: On node 0 totalpages: 24573
Aug 31 17:57:31 homesv kernel: zone(0): 4096 pages.
Aug 31 17:57:31 homesv kernel: zone(1): 20477 pages.
Aug 31 17:57:31 homesv kernel: zone(2): 0 pages.
Aug 31 17:57:31 homesv kernel: Kernel command line: root=/dev/hda4 mem=98292K
Aug 31 17:57:31 homesv kernel: Local APIC disabled by BIOS -- reenabling.
Aug 31 17:57:31 homesv kernel: Found and enabled local APIC!
Aug 31 17:57:31 homesv kernel: Detected 400.925 MHz processor.
Aug 31 17:57:31 homesv kernel: Console: colour VGA+ 80x25
Aug 31 17:57:31 homesv kernel: Calibrating delay loop... 790.52 BogoMIPS
Aug 31 17:57:31 homesv kernel: Memory: 95276k/98292k available (922k kernel code, 2632k reserved, 257k data, 244k init, 
0k highmem)
Aug 31 17:57:31 homesv kernel: Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Aug 31 17:57:31 homesv kernel: Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Aug 31 17:57:31 homesv kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 31 17:57:32 homesv kernel: CPU: Intel Pentium II (Deschutes) stepping 01
Aug 31 17:57:32 homesv kernel: POSIX conformance testing by UNIFIX
Aug 31 17:57:32 homesv kernel: enabled ExtINT on CPU#0
Aug 31 17:57:32 homesv kernel: ESR value before enabling vector: 00000000
Aug 31 17:57:32 homesv kernel: ESR value after enabling vector: 00000000
Aug 31 17:57:32 homesv kernel: Using local APIC timer interrupts.
Aug 31 17:57:32 homesv kernel: calibrating APIC timer ...
Aug 31 17:57:32 homesv kernel: ..... CPU clock speed is 400.0865 MHz.
Aug 31 17:57:32 homesv kernel: ..... host bus clock speed is 100.0216 MHz.
Aug 31 17:57:32 homesv kernel: cpu: 0, clocks: 100216, slice: 50108
Aug 31 17:57:32 homesv kernel: CPU0<T0:100208,T1:50096,D:4,S:50108,C:100216>
Aug 31 17:57:33 homesv kernel: Initializing RT netlink socket
Aug 31 17:57:33 homesv kernel: PCI: Probing PCI hardware
Aug 31 17:57:33 homesv kernel: PCI: Probing PCI hardware (bus 00)
Aug 31 17:57:33 homesv kernel: Starting kswapd
Aug 31 17:57:33 homesv kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Aug 31 17:57:33 homesv kernel: biovec: init pool 0, 1 entries, 12 bytes
Aug 31 17:57:33 homesv kernel: biovec: init pool 1, 4 entries, 48 bytes
Aug 31 17:57:33 homesv kernel: biovec: init pool 2, 16 entries, 192 bytes
Aug 31 17:57:33 homesv kernel: biovec: init pool 3, 64 entries, 768 bytes
Aug 31 17:57:34 homesv kernel: biovec: init pool 4, 128 entries, 1536 bytes
Aug 31 17:57:34 homesv named[46]: db.127.0.0:1: no TTL specified; using SOA MINTTL instead
Aug 31 17:57:34 homesv kernel: biovec: init pool 5, 256 entries, 3072 bytes
Aug 31 17:57:34 homesv named[46]: db.192.168.0:1: no TTL specified; using SOA MINTTL instead
Aug 31 17:57:34 homesv named[46]: db.homenet.soho:1: no TTL specified; using SOA MINTTL instead
Aug 31 17:57:34 homesv kernel: block: 256 slots per queue, batch=32
Aug 31 17:57:34 homesv kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Aug 31 17:57:35 homesv kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
Aug 31 17:57:35 homesv kernel: hda: QUANTUM FIREBALL CR13.0A, DISK drive
Aug 31 17:57:35 homesv kernel: hdb: Maxtor 53073H6, DISK drive
Aug 31 17:57:35 homesv kernel: hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
Aug 31 17:57:35 homesv kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 31 17:57:35 homesv kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 31 17:57:36 homesv kernel: hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Aug 31 17:57:36 homesv kernel: VFS: Mounted root (ext2 filesystem) readonly.
Aug 31 17:57:36 homesv kernel: Freeing unused kernel memory: 244k freed
Aug 31 17:57:42 homesv squid[80]: Starting Squid Cache version 2.4.STABLE7 for i686-pc-linux-gnu... 
Aug 31 18:18:48 homesv kernel: Linux version 2.5.32 (root@homesv) (gcc version 2.95.3 20010315 (release)) #1 Sat Aug 31 
18:15:51 JST 2002
Aug 31 18:18:48 homesv kernel: Video mode to be used for restore is 303
Aug 31 18:18:48 homesv kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Aug 31 18:18:48 homesv kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 31 18:18:48 homesv kernel:  BIOS-e820: 0000000000100000 - 0000000005ffd000 (usable)
Aug 31 18:18:48 homesv kernel:  BIOS-e820: 0000000005ffd000 - 0000000005fff000 (ACPI data)
Aug 31 18:18:48 homesv kernel:  BIOS-e820: 0000000005fff000 - 0000000006000000 (ACPI NVS)
Aug 31 18:18:48 homesv kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 31 18:18:48 homesv kernel:  user: 0000000000000000 - 00000000000a0000 (usable)
Aug 31 18:18:48 homesv kernel:  user: 00000000000f0000 - 0000000000100000 (reserved)
Aug 31 18:18:48 homesv kernel:  user: 0000000000100000 - 0000000005ffd000 (usable)
Aug 31 18:18:49 homesv kernel:  user: 0000000005ffd000 - 0000000005fff000 (ACPI data)
Aug 31 18:18:49 homesv kernel:  user: 0000000005fff000 - 0000000006000000 (ACPI NVS)
Aug 31 18:18:49 homesv kernel:  user: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 31 18:18:49 homesv kernel: On node 0 totalpages: 24573
Aug 31 18:18:49 homesv kernel: zone(0): 4096 pages.
Aug 31 18:18:49 homesv kernel: zone(1): 20477 pages.
Aug 31 18:18:49 homesv kernel: zone(2): 0 pages.
Aug 31 18:18:49 homesv kernel: Kernel command line: root=/dev/hda4 vga=771 mem=98292K
Aug 31 18:18:49 homesv kernel: Local APIC disabled by BIOS -- reenabling.
Aug 31 18:18:49 homesv kernel: Found and enabled local APIC!
Aug 31 18:18:49 homesv kernel: Detected 400.984 MHz processor.
Aug 31 18:18:49 homesv kernel: Console: colour dummy device 80x25
Aug 31 18:18:49 homesv kernel: Calibrating delay loop... 790.52 BogoMIPS
Aug 31 18:18:49 homesv kernel: Memory: 95204k/98292k available (960k kernel code, 2704k reserved, 271k data, 268k init, 
0k highmem)
Aug 31 18:18:49 homesv kernel: Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Aug 31 18:18:49 homesv kernel: Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Aug 31 18:18:49 homesv kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 31 18:18:50 homesv kernel: CPU: Intel Pentium II (Deschutes) stepping 01
Aug 31 18:18:50 homesv kernel: POSIX conformance testing by UNIFIX
Aug 31 18:18:50 homesv kernel: enabled ExtINT on CPU#0
Aug 31 18:18:50 homesv kernel: ESR value before enabling vector: 00000000
Aug 31 18:18:50 homesv kernel: ESR value after enabling vector: 00000000
Aug 31 18:18:50 homesv kernel: Using local APIC timer interrupts.
Aug 31 18:18:50 homesv kernel: calibrating APIC timer ...
Aug 31 18:18:50 homesv kernel: ..... CPU clock speed is 400.0852 MHz.
Aug 31 18:18:50 homesv kernel: ..... host bus clock speed is 100.0212 MHz.
Aug 31 18:18:50 homesv kernel: cpu: 0, clocks: 100212, slice: 50106
Aug 31 18:18:50 homesv kernel: CPU0<T0:100208,T1:50096,D:6,S:50106,C:100212>
Aug 31 18:18:51 homesv kernel: Initializing RT netlink socket
Aug 31 18:18:51 homesv kernel: PCI: Probing PCI hardware
Aug 31 18:18:51 homesv kernel: PCI: Probing PCI hardware (bus 00)
Aug 31 18:18:51 homesv kernel: Starting kswapd
Aug 31 18:18:51 homesv kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Aug 31 18:18:51 homesv kernel: biovec: init pool 0, 1 entries, 12 bytes
Aug 31 18:18:51 homesv kernel: biovec: init pool 1, 4 entries, 48 bytes
Aug 31 18:18:52 homesv kernel: biovec: init pool 2, 16 entries, 192 bytes
Aug 31 18:18:52 homesv kernel: biovec: init pool 3, 64 entries, 768 bytes
Aug 31 18:18:52 homesv kernel: biovec: init pool 4, 128 entries, 1536 bytes
Aug 31 18:18:52 homesv named[46]: db.127.0.0:1: no TTL specified; using SOA MINTTL instead
Aug 31 18:18:52 homesv kernel: biovec: init pool 5, 256 entries, 3072 bytes
Aug 31 18:18:52 homesv named[46]: db.192.168.0:1: no TTL specified; using SOA MINTTL instead
Aug 31 18:18:52 homesv named[46]: db.homenet.soho:1: no TTL specified; using SOA MINTTL instead
Aug 31 18:18:53 homesv kernel: Console: switching to colour frame buffer device 100x37
Aug 31 18:18:53 homesv kernel: block: 256 slots per queue, batch=32
Aug 31 18:18:53 homesv kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Aug 31 18:18:53 homesv kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
Aug 31 18:18:54 homesv kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 31 18:18:54 homesv kernel: PIIX4: IDE controller on PCI bus 00 dev 21
Aug 31 18:18:54 homesv kernel: PIIX4: chipset revision 1
Aug 31 18:18:54 homesv kernel: PIIX4: not 100%% native mode: will probe irqs later
Aug 31 18:18:54 homesv kernel:     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
Aug 31 18:18:54 homesv kernel:     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
Aug 31 18:18:54 homesv kernel: hda: QUANTUM FIREBALL CR13.0A, ATA DISK drive
Aug 31 18:18:54 homesv kernel: hdb: Maxtor 53073H6, ATA DISK drive
Aug 31 18:18:54 homesv kernel: hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
Aug 31 18:18:54 homesv kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 31 18:18:54 homesv kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 31 18:18:54 homesv kernel: blk: queue c02a3824, I/O limit 4095Mb (mask 0xffffffff)
Aug 31 18:18:54 homesv kernel: hda: host protected area => 1
Aug 31 18:18:54 homesv kernel: blk: queue c02a39a8, I/O limit 4095Mb (mask 0xffffffff)
Aug 31 18:18:54 homesv kernel: hdb: host protected area => 1
Aug 31 18:18:54 homesv kernel: hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Aug 31 18:18:55 homesv kernel: VFS: Mounted root (ext2 filesystem) readonly.
Aug 31 18:18:55 homesv kernel: Freeing unused kernel memory: 268k freed
Aug 31 18:19:03 homesv squid[80]: Starting Squid Cache version 2.4.STABLE7 for i686-pc-linux-gnu... 

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
