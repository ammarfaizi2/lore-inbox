Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUFCOw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUFCOw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265594AbUFCOwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:52:25 -0400
Received: from mail1.highwayone.de ([62.138.2.165]:19349 "HELO
	mail1.highwayone.de") by vger.kernel.org with SMTP id S264108AbUFCOoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:44:19 -0400
To: linux-kernel@vger.kernel.org
From: jfock@abas-projektierung.de
Subject: Problem Stress.sh and ops
Date: 03 Jun 2004 14:44:10 UT
X-Priority: 3 (Normal)
Importance: normal
X-Mailer: DvISE by Tobit Software, Germany (0224.434647444B47474D4E51)
X-David-Sym: 0
X-David-Flags: 0
Message-ID: <0002350A.40BF5559@192.168.222.11>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_000_0002350A.40BF5559"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_0002350A.40BF5559
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7Bit

hello
i have installd on a test-server RedHat 9.0 Kernel 2.6.7-rc1-mm1.
on /dev/sdb1 i have created a reiserfs4 partition. My kernel boot with this
Partition ok.When i started a shellscript then after a time i get kernel ops
but my system not chrashd if i stop then shellcript my system run normaly
here are the dmesg:
Linux version 2.6.7-rc1-mm1 (root@testold) (gcc version 3.2.2 20030222 (Red Hat
Linux 3.2.2-5)) #1 Thu Jun 3 14:31:21 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001feeb000 (usable)
 BIOS-e820: 000000001feeb000 - 000000001feef000 (ACPI data)
 BIOS-e820: 000000001feef000 - 000000001feff000 (reserved)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
510MB LOWMEM available.
On node 0 totalpages: 130795
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126699 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI disabled because your bios is from 1999 and too old
You can enable it with acpi=force
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/sda3
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1002.362 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 514252k/523180k available (2500k kernel code, 8176k reserved, 876k data,
 356k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1986.56 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0da0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus fe [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@sa
w.sw.com.sg> and others
PCI: Found IRQ 9 for device 0000:01:0b.0
PCI: Sharing IRQ 9 with 0000:00:1f.4
eth0: 0000:01:0b.0, 00:90:27:A2:57:24, I/O at 0xd800, IRQ 9.
  Board assembly 721383-007, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
e100: Intel(R) PRO/100 Network Driver, 3.0.18
e100: Copyright(c) 1999-2004 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
GDT-HA: Storage RAID Controller Driver. Version: 3.04
PCI: Found IRQ 9 for device 0000:01:09.0
GDT-HA: Found 1 PCI Storage RAID Controllers
Configuring GDT-PCI HA at 1/9 IRQ 9
GDT-HA 0: Name: GDT6518RD
scsi0 : GDT6518RD
  Vendor: ICP       Model: Host Drive  #00   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ICP       Model: Host Drive  #03   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 35824950 512-byte hdwr sectors (18342 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 70846650 512-byte hdwr sectors (36273 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 3, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 356k freed
EXT3 FS on sda3, internal journal
Adding 1052248k swap on /dev/sda2.  Priority:-1 extents:1
spurious 8259A interrupt: IRQ7.
Debug: sleeping function called from invalid context at include/asm/semaphore.h:
119
in_atomic():1, irqs_disabled():0
 [<c01159a8>] __might_sleep+0xb6/0xd7
 [<c01832d5>] make_space_tail+0x5a/0x5c
 [<c01bb9ec>] load_and_lock_bnode+0x27/0xf5
 [<c01bbb01>] search_one_bitmap_forward+0x3c/0x1b8
 [<c01bbe5f>] bitmap_alloc_forward+0xa8/0x154
 [<c01bc0c7>] alloc_blocks_forward+0x69/0x141
 [<c0189916>] reiser4_alloc_blocks+0x8a/0x17d
 [<c019dd88>] ef_prepare+0x110/0x270
 [<c019d09c>] emergency_flush+0xf0/0x300
 [<c0194ac9>] reiser4_writepage+0x160/0x204
 [<c013a5fb>] shrink_list+0x519/0x643
 [<c0139526>] __pagevec_lru_add+0xc3/0xe3
 [<c013a8b0>] shrink_cache+0x18b/0x3f5
 [<c013b243>] shrink_caches+0x79/0x7d
 [<c013b2e7>] try_to_free_pages+0xa0/0x16e
 [<c0133c04>] __alloc_pages+0x21c/0x3a0
 [<c01b1bea>] append_one_block+0x45/0xee
 [<c012ffa0>] find_or_create_page+0x71/0x7b
 [<c017fc9c>] jnode_get_page_locked+0xf6/0x112
 [<c01b24fc>] extent_write_flow+0x1b5/0x625
 [<c01b2a7a>] write_extent+0x0/0x43
 [<c01bf6e4>] append_and_or_overwrite+0x1ad/0x352
 [<c01bf8fb>] write_flow+0x72/0x74
 [<c01bfae3>] write_file+0x63/0x81
 [<c01bfc51>] write_unix_file+0x150/0x201
 [<c019c450>] reiser4_write+0x61/0x9e
 [<c019c3ef>] reiser4_write+0x0/0x9e
 [<c014b4ca>] vfs_write+0xbd/0x110
 [<c014b5ae>] sys_write+0x38/0x59
 [<c0105e93>] syscall_call+0x7/0xb

Debug: sleeping function called from invalid context at include/asm/semaphore.h:
119
in_atomic():1, irqs_disabled():0
 [<c01159a8>] __might_sleep+0xb6/0xd7
 [<c02c03d4>] as_merged_request+0x46/0x1cc
 [<c01bb9ec>] load_and_lock_bnode+0x27/0xf5
 [<c01bbb01>] search_one_bitmap_forward+0x3c/0x1b8
 [<c01bbe5f>] bitmap_alloc_forward+0xa8/0x154
 [<c01bc0c7>] alloc_blocks_forward+0x69/0x141
 [<c0189916>] reiser4_alloc_blocks+0x8a/0x17d
 [<c019dd88>] ef_prepare+0x110/0x270
 [<c019d09c>] emergency_flush+0xf0/0x300
 [<c0194ac9>] reiser4_writepage+0x160/0x204
 [<c013a5fb>] shrink_list+0x519/0x643
 [<c02c03d4>] as_merged_request+0x46/0x1cc
 [<c0139623>] __pagevec_lru_add_active+0xdd/0xfd
 [<c013a8b0>] shrink_cache+0x18b/0x3f5
 [<c0150025>] __bio_add_page+0x118/0x11d
 [<c013b243>] shrink_caches+0x79/0x7d
 [<c013b2e7>] try_to_free_pages+0xa0/0x16e
 [<c0133c04>] __alloc_pages+0x21c/0x3a0
 [<c02ec6d5>] scsi_io_completion+0x1a6/0x420
 [<c01368ee>] do_page_cache_readahead+0x137/0x197
 [<c0136b09>] page_cache_readahead+0x1bb/0x214
 [<c01b2be6>] call_page_cache_readahead+0x8e/0xa0
 [<c01b2c66>] read_extent+0x6e/0x212
 [<c01b3601>] init_coord_extension_extent+0xa4/0x10f
 [<c01b2bf8>] read_extent+0x0/0x212
 [<c01bf45b>] read_unix_file+0x30b/0x3e7
 [<c01b2bf8>] read_extent+0x0/0x212
 [<c019449c>] end_bio_single_page_read+0x0/0x91
 [<c013266a>] mempool_free+0x4f/0xa3
 [<c0189e46>] all_grabbed2free+0x31/0x39
 [<c019c3c0>] reiser4_read+0x61/0x90
 [<c014b316>] vfs_read+0xbd/0x110
 [<c011b84e>] __do_softirq+0x7a/0x7c
 [<c014b555>] sys_read+0x38/0x59
 [<c0105e93>] syscall_call+0x7/0xb

Debug: sleeping function called from invalid context at include/asm/semaphore.h:
119
in_atomic():1, irqs_disabled():0
 [<c01159a8>] __might_sleep+0xb6/0xd7
 [<c01bb9ec>] load_and_lock_bnode+0x27/0xf5
 [<c01bbb01>] search_one_bitmap_forward+0x3c/0x1b8
 [<c01bbe5f>] bitmap_alloc_forward+0xa8/0x154
 [<c01bc0c7>] alloc_blocks_forward+0x69/0x141
 [<c0189916>] reiser4_alloc_blocks+0x8a/0x17d
 [<c019dd88>] ef_prepare+0x110/0x270
 [<c019d09c>] emergency_flush+0xf0/0x300
 [<c0194ac9>] reiser4_writepage+0x160/0x204
 [<c019ce88>] reiser4_releasepage+0x12e/0x16e
 [<c019cd5a>] reiser4_releasepage+0x0/0x16e
 [<c013a5fb>] shrink_list+0x519/0x643
 [<c01393c2>] __pagevec_release+0x15/0x1d
 [<c013a8b0>] shrink_cache+0x18b/0x3f5
 [<c013b243>] shrink_caches+0x79/0x7d
 [<c013b2e7>] try_to_free_pages+0xa0/0x16e
 [<c0133c04>] __alloc_pages+0x21c/0x3a0
 [<c01b1bea>] append_one_block+0x45/0xee
 [<c012ffa0>] find_or_create_page+0x71/0x7b
 [<c017fc9c>] jnode_get_page_locked+0xf6/0x112
 [<c01b24fc>] extent_write_flow+0x1b5/0x625
 [<c01b2a7a>] write_extent+0x0/0x43
 [<c01bf6e4>] append_and_or_overwrite+0x1ad/0x352
 [<c01bf8fb>] write_flow+0x72/0x74
 [<c01bfae3>] write_file+0x63/0x81
 [<c01bfc51>] write_unix_file+0x150/0x201
 [<c019c450>] reiser4_write+0x61/0x9e
 [<c0126337>] rcu_process_callbacks+0xd6/0x115
 [<c019c3ef>] reiser4_write+0x0/0x9e
 [<c014b4ca>] vfs_write+0xbd/0x110
 [<c011b84e>] __do_softirq+0x7a/0x7c
 [<c014b5ae>] sys_write+0x38/0x59
 [<c0105e93>] syscall_call+0x7/0xb

Debug: sleeping function called from invalid context at include/asm/semaphore.h:
119
in_atomic():1, irqs_disabled():0
 [<c01159a8>] __might_sleep+0xb6/0xd7
 [<c02bfee1>] as_add_request+0x16a/0x1b8
 [<c01bb9ec>] load_and_lock_bnode+0x27/0xf5
 [<c01bbb01>] search_one_bitmap_forward+0x3c/0x1b8
 [<c02b87eb>] __elv_add_request+0x3c/0x54
 [<c01bbe5f>] bitmap_alloc_forward+0xa8/0x154
 [<c01bc0c7>] alloc_blocks_forward+0x69/0x141
 [<c0189916>] reiser4_alloc_blocks+0x8a/0x17d
 [<c019dd88>] ef_prepare+0x110/0x270
 [<c019d09c>] emergency_flush+0xf0/0x300
 [<c0194ac9>] reiser4_writepage+0x160/0x204
 [<c019ce88>] reiser4_releasepage+0x12e/0x16e
 [<c019cd5a>] reiser4_releasepage+0x0/0x16e
 [<c013a5fb>] shrink_list+0x519/0x643
 [<c01393c2>] __pagevec_release+0x15/0x1d
 [<c013a8b0>] shrink_cache+0x18b/0x3f5
 [<c013b243>] shrink_caches+0x79/0x7d
 [<c013b2e7>] try_to_free_pages+0xa0/0x16e
 [<c0133c04>] __alloc_pages+0x21c/0x3a0
 [<c01b1bea>] append_one_block+0x45/0xee
 [<c012ffa0>] find_or_create_page+0x71/0x7b
 [<c017fc9c>] jnode_get_page_locked+0xf6/0x112
 [<c01b24fc>] extent_write_flow+0x1b5/0x625
 [<c01b2a7a>] write_extent+0x0/0x43
 [<c01bf6e4>] append_and_or_overwrite+0x1ad/0x352
 [<c01bf8fb>] write_flow+0x72/0x74
 [<c01bfae3>] write_file+0x63/0x81
 [<c01bfc51>] write_unix_file+0x150/0x201
 [<c019c450>] reiser4_write+0x61/0x9e
 [<c0126337>] rcu_process_callbacks+0xd6/0x115
 [<c019c3ef>] reiser4_write+0x0/0x9e
 [<c014b4ca>] vfs_write+0xbd/0x110
 [<c011b84e>] __do_softirq+0x7a/0x7c
 [<c014b5ae>] sys_write+0x38/0x59
 [<c0105e93>] syscall_call+0x7/0xb

Debug: sleeping function called from invalid context at include/asm/semaphore.h:
119
in_atomic():1, irqs_disabled():0
 [<c01159a8>] __might_sleep+0xb6/0xd7
 [<c02bfee1>] as_add_request+0x16a/0x1b8
 [<c01bb9ec>] load_and_lock_bnode+0x27/0xf5
 [<c01bbb01>] search_one_bitmap_forward+0x3c/0x1b8
 [<c02b87eb>] __elv_add_request+0x3c/0x54
 [<c01bbe5f>] bitmap_alloc_forward+0xa8/0x154
 [<c01bc0c7>] alloc_blocks_forward+0x69/0x141
 [<c0189916>] reiser4_alloc_blocks+0x8a/0x17d
 [<c019dd88>] ef_prepare+0x110/0x270
 [<c019d09c>] emergency_flush+0xf0/0x300
 [<c0194ac9>] reiser4_writepage+0x160/0x204
 [<c019cd5a>] reiser4_releasepage+0x0/0x16e
 [<c013a5fb>] shrink_list+0x519/0x643
 [<c01393c2>] __pagevec_release+0x15/0x1d
 [<c013a8b0>] shrink_cache+0x18b/0x3f5
 [<c013b156>] shrink_zone+0xa9/0x11d
 [<c013b243>] shrink_caches+0x79/0x7d
 [<c013b2e7>] try_to_free_pages+0xa0/0x16e
 [<c0133c04>] __alloc_pages+0x21c/0x3a0
 [<c01b1bea>] append_one_block+0x45/0xee
 [<c012ffa0>] find_or_create_page+0x71/0x7b
 [<c017fc9c>] jnode_get_page_locked+0xf6/0x112
 [<c01b24fc>] extent_write_flow+0x1b5/0x625
 [<c01b2a7a>] write_extent+0x0/0x43
 [<c01bf6e4>] append_and_or_overwrite+0x1ad/0x352
 [<c01bf8fb>] write_flow+0x72/0x74
 [<c01bfae3>] write_file+0x63/0x81
 [<c01bfc51>] write_unix_file+0x150/0x201
 [<c019c450>] reiser4_write+0x61/0x9e
 [<c019c3ef>] reiser4_write+0x0/0x9e
 [<c014b4ca>] vfs_write+0xbd/0x110
 [<c014b5ae>] sys_write+0x38/0x59
 [<c0105e93>] syscall_call+0x7/0xb

Debug: sleeping function called from invalid context at include/asm/semaphore.h:
119
in_atomic():1, irqs_disabled():0
 [<c01159a8>] __might_sleep+0xb6/0xd7
 [<c02bfee1>] as_add_request+0x16a/0x1b8
 [<c01bb9ec>] load_and_lock_bnode+0x27/0xf5
 [<c01bbb01>] search_one_bitmap_forward+0x3c/0x1b8
 [<c02b87eb>] __elv_add_request+0x3c/0x54
 [<c01bbe5f>] bitmap_alloc_forward+0xa8/0x154
 [<c01bc0c7>] alloc_blocks_forward+0x69/0x141
 [<c0189916>] reiser4_alloc_blocks+0x8a/0x17d
 [<c019dd88>] ef_prepare+0x110/0x270
 [<c019d09c>] emergency_flush+0xf0/0x300
 [<c0194ac9>] reiser4_writepage+0x160/0x204
 [<c019cd5a>] reiser4_releasepage+0x0/0x16e
 [<c013a5fb>] shrink_list+0x519/0x643
 [<c01393c2>] __pagevec_release+0x15/0x1d
 [<c013a8b0>] shrink_cache+0x18b/0x3f5
 [<c013b156>] shrink_zone+0xa9/0x11d
 [<c0115db2>] autoremove_wake_function+0x1b/0x43
 [<c013b243>] shrink_caches+0x79/0x7d
 [<c013b2e7>] try_to_free_pages+0xa0/0x16e
 [<c0133c04>] __alloc_pages+0x21c/0x3a0
 [<c01b1bea>] append_one_block+0x45/0xee
 [<c012ffa0>] find_or_create_page+0x71/0x7b
 [<c017fc9c>] jnode_get_page_locked+0xf6/0x112
 [<c01b24fc>] extent_write_flow+0x1b5/0x625
 [<c01b2a7a>] write_extent+0x0/0x43
 [<c01bf6e4>] append_and_or_overwrite+0x1ad/0x352
 [<c01bf8fb>] write_flow+0x72/0x74
 [<c01bf8fb>] write_flow+0x72/0x74
 [<c01bfae3>] write_file+0x63/0x81
 [<c01bfc51>] write_unix_file+0x150/0x201
 [<c019c450>] reiser4_write+0x61/0x9e
 [<c019c3ef>] reiser4_write+0x0/0x9e
 [<c014b4ca>] vfs_write+0xbd/0x110
 [<c011b84e>] __do_softirq+0x7a/0x7c
 [<c014b5ae>] sys_write+0x38/0x59
 [<c0105e93>] syscall_call+0x7/0xb
in attachment .config and stressbsp.sh an stress.sh
I hope you can hepl me

J.Fock
Abas-Projektierung.de











 



 

------_=_NextPart_000_0002350A.40BF5559
Content-Type: application/octet-stream; name="stressbsp.sh"
Content-Transfer-Encoding: base64

IyBFcnpldWd0IGF1ZiA0LVByb3otUmVjaG5lciBnYW56IGd1dGVuIExvYWQgKE1hZmVsbCkK
Li9zdHJlc3Muc2ggLWMgL3ZhciAtbiAyMDAgL21udDIK

------_=_NextPart_000_0002350A.40BF5559
Content-Type: application/octet-stream; name="stress.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2ggLQojIC0qLSBTaGVsbC1zY3JpcHQgLSotCiMKIyBDb3B5cmlnaHQgKEMp
IDE5OTkgQmlibGlvdGVjaCBMdGQuLCA2MzEtNjMzIEZ1bGhhbSBSZC4sIExvbmRvbiBTVzYg
NVVRLgojCiMgJElkOiBzdHJlc3Muc2gsdiAxLjIgMTk5OS8wMi8xMCAxMDo1ODowNCByaWNo
IEV4cCAkCiMKIyBDaGFuZ2UgbG9nOgojCiMgJExvZzogc3RyZXNzLnNoLHYgJAojIFJldmlz
aW9uIDEuMiAgMTk5OS8wMi8xMCAxMDo1ODowNCAgcmljaAojIFVzZSBjcCBpbnN0ZWFkIG9m
IHRhciB0byBjb3B5LgojCiMgUmV2aXNpb24gMS4xICAxOTk5LzAyLzA5IDE1OjEzOjM4ICBy
aWNoCiMgQWRkZWQgZmlyc3QgdmVyc2lvbiBvZiBzdHJlc3MgdGVzdCBwcm9ncmFtLgojCgoj
IFN0cmVzcy10ZXN0IGEgZmlsZSBzeXN0ZW0gYnkgZG9pbmcgbXVsdGlwbGUKIyBwYXJhbGxl
bCBkaXNrIG9wZXJhdGlvbnMuIFRoaXMgZG9lcyBldmVyeXRoaW5nCiMgaW4gTU9VTlRQT0lO
VC9zdHJlc3MuCgpuY29uY3VycmVudD0xMDAKY29udGVudD0vdXNyL2RvYwpzdGFnZ2VyPXll
cwoKd2hpbGUgZ2V0b3B0cyAiYzpuOnMiIGM7IGRvCiAgICBjYXNlICRjIGluCiAgICBjKQoJ
Y29udGVudD0kT1BUQVJHCgk7OwogICAgbikKCW5jb25jdXJyZW50PSRPUFRBUkcKCTs7CiAg
ICBzKQoJc3RhZ2dlcj1ubwoJOzsKICAgICopCgllY2hvICdVc2FnZTogc3RyZXNzLnNoIFst
b3B0aW9uc10gTU9VTlRQT0lOVCcKCWVjaG8gJ09wdGlvbnM6IC1jIENvbnRlbnQgZGlyZWN0
b3J5JwoJZWNobyAnICAgICAgICAgLW4gTnVtYmVyIG9mIGNvbmN1cnJlbnQgYWNjZXNzZXMg
KGRlZmF1bHQ6IDQpJwoJZWNobyAnICAgICAgICAgLXMgQXZvaWQgc3RhZ2dlcnJpbmcgc3Rh
cnQgdGltZXMnCglleGl0IDEKCTs7CiAgICBlc2FjCmRvbmUKCnNoaWZ0ICQoKCRPUFRJTkQt
MSkpCmlmIFsgJCMgLW5lIDEgXTsgdGhlbgogICAgZWNobyAnRm9yIHVzYWdlOiBzdHJlc3Mu
c2ggLT8nCiAgICBleGl0IDEKZmkKCm1vdW50cG9pbnQ9JDEKCmVjaG8gJ051bWJlciBvZiBj
b25jdXJyZW50IHByb2Nlc3NlczonICRuY29uY3VycmVudAplY2hvICdDb250ZW50IGRpcmVj
dG9yeTonICRjb250ZW50ICcoc2l6ZTonIGBkdSAtcyAkY29udGVudCB8IGF3ayAne3ByaW50
ICQxfSdgICdLQiknCgojIENoZWNrIHRoZSBtb3VudCBwb2ludCBpcyByZWFsbHkgYSBtb3Vu
dCBwb2ludC4KCiNpZiBbIGBkZiB8IGF3ayAne3ByaW50ICQ2fScgfCBncmVwIF4kbW91bnRw
b2ludFwkIHwgd2MgLWxgIC1sdCAxIF07IHRoZW4KIyAgICBlY2hvICRtb3VudHBvaW50OiBU
aGlzIGRvZXNuXCd0IHNlZW0gdG8gYmUgYSBtb3VudHBvaW50LiBUcnkgbm90CiMgICAgZWNo
byB0byB1c2UgYSB0cmFpbGluZyAvIGNoYXJhY3Rlci4KIyAgICBleGl0IDEKI2ZpCgojIENy
ZWF0ZSB0aGUgZGlyZWN0b3J5LCBpZiBpdCBkb2Vzbid0IGV4aXN0LgoKZWNobyBXYXJuaW5n
OiBUaGlzIHdpbGwgREVMRVRFIGFueXRoaW5nIGluICRtb3VudHBvaW50L3N0cmVzcy4gVHlw
ZSB5ZXMgdG8gY29uZmlybS4KcmVhZCBsaW5lCmlmIFsgIiRsaW5lIiAhPSAieWVzIiBdOyB0
aGVuCiAgICBlY2hvICJTY3JpcHQgYWJhbmRvbmVkLiIKICAgIGV4aXQgMQpmaQoKaWYgWyAh
IC1kICRtb3VudHBvaW50L3N0cmVzcyBdOyB0aGVuCiAgICBybSAtcmYgJG1vdW50cG9pbnQv
c3RyZXNzCiAgICBpZiAhIG1rZGlyICRtb3VudHBvaW50L3N0cmVzczsgdGhlbgoJZWNobyBQ
cm9ibGVtIGNyZWF0aW5nICRtb3VudHBvaW50L3N0cmVzcyBkaXJlY3RvcnkuIERvIHlvdSBo
YXZlIHN1ZmZpY2llbnQKCWVjaG8gYWNjZXNzIHBlcm1pc3Npb25zXD8KCWV4aXQgMQogICAg
ZmkKZmkKCmVjaG8gQ3JlYXRlZCAkbW91bnRwb2ludC9zdHJlc3MgZGlyZWN0b3J5LgoKIyBD
b25zdHJ1Y3QgTUQ1IHN1bXMgb3ZlciB0aGUgY29udGVudCBkaXJlY3RvcnkuCgplY2hvIC1u
ICJDb21wdXRpbmcgTUQ1IHN1bXMgb3ZlciBjb250ZW50IGRpcmVjdG9yeTogIgooIGNkICRj
b250ZW50ICYmIGZpbmQgLiAtdHlwZSBmIC1wcmludDAgfCB4YXJncyAtMCBtZDVzdW0gfCBz
b3J0IC1rIDIgLW8gJG1vdW50cG9pbnQvc3RyZXNzL2NvbnRlbnQuc3VtcyApCmVjaG8gZG9u
ZS4KCiMgU3RhcnQgdGhlIHN0cmVzc2luZyBwcm9jZXNzZXMuCgplY2hvIC1uICJTdGFydGlu
ZyBzdHJlc3MgdGVzdCBwcm9jZXNzZXM6ICIKCnBpZHM9IiIKCnA9MQp3aGlsZSBbICRwIC1s
ZSAkbmNvbmN1cnJlbnQgXTsgZG8KICAgIGVjaG8gLW4gIiRwICIKCiAgICAoCgoJIyBXYWl0
IGZvciBhbGwgcHJvY2Vzc2VzIHRvIHN0YXJ0IHVwLgoJaWYgWyAiJHN0YWdnZXIiID0gInll
cyIgXTsgdGhlbgoJICAgIHNsZWVwICQoKDEwKiRwKSkKCWVsc2UKCSAgICBzbGVlcCAxMAoJ
ZmkKCgl3aGlsZSB0cnVlOyBkbwoKCSAgICAjIFJlbW92ZSBvbGQgZGlyZWN0b3JpZXMuCgkg
ICAgZWNobyAtbiAiRCRwICIKCSAgICBybSAtcmYgJG1vdW50cG9pbnQvc3RyZXNzLyRwCgoJ
ICAgICMgQ29weSBjb250ZW50IC0+IHBhcnRpdGlvbi4KCSAgICBlY2hvIC1uICJXJHAgIgoJ
ICAgIG1rZGlyICRtb3VudHBvaW50L3N0cmVzcy8kcAoJICAgICMoIGNkICRjb250ZW50ICYm
IHRhciBjZiAtIC4gKSB8ICggY2QgJG1vdW50cG9pbnQvc3RyZXNzLyRwICYmIHRhciB4ZiAt
ICkKCSAgICBjcCAtYXggJGNvbnRlbnQvKiAkbW91bnRwb2ludC9zdHJlc3MvJHAKCgkgICAg
IyBDb21wYXJlIHRoZSBjb250ZW50IGFuZCB0aGUgY29weS4KCSAgICBlY2hvIC1uICJSJHAg
IgoJICAgICggY2QgJG1vdW50cG9pbnQvc3RyZXNzLyRwICYmIGZpbmQgLiAtdHlwZSBmIC1w
cmludDAgfCB4YXJncyAtMCBtZDVzdW0gfCBzb3J0IC1rIDIgLW8gL3RtcC9zdHJlc3MuJCQu
JHAgKQoJICAgIGRpZmYgJG1vdW50cG9pbnQvc3RyZXNzL2NvbnRlbnQuc3VtcyAvdG1wL3N0
cmVzcy4kJC4kcAoJICAgIHJtIC1mIC90bXAvc3RyZXNzLiQkLiRwCglkb25lCiAgICApICYK
CiAgICBwaWRzPSIkcGlkcyAkISIKCiAgICBwPSQoKCRwKzEpKQpkb25lCgplY2hvCmVjaG8g
IlByb2Nlc3MgSURzOiAkcGlkcyIKZWNobyAiUHJlc3MgXkMgdG8ga2lsbCBhbGwgcHJvY2Vz
c2VzIgoKdHJhcCAia2lsbCAkcGlkcyIgU0lHSU5UCgp3YWl0CgpraWxsICRwaWRz

------_=_NextPart_000_0002350A.40BF5559
Content-Type: application/octet-stream; name=".config"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMK
Q09ORklHX1g4Nj15CkNPTkZJR19NTVU9eQpDT05GSUdfVUlEMTY9eQpDT05GSUdfR0VORVJJ
Q19JU0FfRE1BPXkKCiMKIyBDb2RlIG1hdHVyaXR5IGxldmVsIG9wdGlvbnMKIwpDT05GSUdf
RVhQRVJJTUVOVEFMPXkKQ09ORklHX0NMRUFOX0NPTVBJTEU9eQpDT05GSUdfU1RBTkRBTE9O
RT15CkNPTkZJR19CUk9LRU5fT05fU01QPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklH
X1NXQVA9eQpDT05GSUdfU1lTVklQQz15CkNPTkZJR19QT1NJWF9NUVVFVUU9eQpDT05GSUdf
QlNEX1BST0NFU1NfQUNDVD15CkNPTkZJR19TWVNDVEw9eQojIENPTkZJR19BVURJVCBpcyBu
b3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE0CiMgQ09ORklHX0hPVFBMVUcgaXMgbm90
IHNldApDT05GSUdfSUtDT05GSUc9eQpDT05GSUdfSUtDT05GSUdfUFJPQz15CiMgQ09ORklH
X0VNQkVEREVEIGlzIG5vdCBzZXQKQ09ORklHX0tBTExTWU1TPXkKQ09ORklHX0ZVVEVYPXkK
Q09ORklHX0VQT0xMPXkKQ09ORklHX0lPU0NIRURfTk9PUD15CkNPTkZJR19JT1NDSEVEX0FT
PXkKQ09ORklHX0lPU0NIRURfREVBRExJTkU9eQpDT05GSUdfSU9TQ0hFRF9DRlE9eQojIENP
TkZJR19DQ19PUFRJTUlaRV9GT1JfU0laRSBpcyBub3Qgc2V0CgojCiMgTG9hZGFibGUgbW9k
dWxlIHN1cHBvcnQKIwpDT05GSUdfTU9EVUxFUz15CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkK
Q09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQ9eQpDT05GSUdfT0JTT0xFVEVfTU9EUEFSTT15
CkNPTkZJR19NT0RWRVJTSU9OUz15CkNPTkZJR19LTU9EPXkKCiMKIyBQcm9jZXNzb3IgdHlw
ZSBhbmQgZmVhdHVyZXMKIwpDT05GSUdfWDg2X1BDPXkKIyBDT05GSUdfWDg2X0VMQU4gaXMg
bm90IHNldAojIENPTkZJR19YODZfVk9ZQUdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9O
VU1BUSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9TVU1NSVQgaXMgbm90IHNldAojIENPTkZJ
R19YODZfQklHU01QIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1ZJU1dTIGlzIG5vdCBzZXQK
IyBDT05GSUdfWDg2X0dFTkVSSUNBUkNIIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0VTNzAw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX00zODYgaXMgbm90IHNldAojIENPTkZJR19NNDg2IGlz
IG5vdCBzZXQKIyBDT05GSUdfTTU4NiBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZUU0MgaXMg
bm90IHNldAojIENPTkZJR19NNTg2TU1YIGlzIG5vdCBzZXQKIyBDT05GSUdfTTY4NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX01QRU5USVVNSUkgaXMgbm90IHNldAojIENPTkZJR19NUEVOVElV
TUlJSSBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNTSBpcyBub3Qgc2V0CkNPTkZJR19N
UEVOVElVTTQ9eQojIENPTkZJR19NSzYgaXMgbm90IHNldAojIENPTkZJR19NSzcgaXMgbm90
IHNldAojIENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NQ1JVU09FIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTVdJTkNISVBDNiBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQMiBp
cyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQM0QgaXMgbm90IHNldAojIENPTkZJR19NQ1lS
SVhJSUkgaXMgbm90IHNldAojIENPTkZJR19NVklBQzNfMiBpcyBub3Qgc2V0CkNPTkZJR19Y
ODZfR0VORVJJQz15CkNPTkZJR19YODZfQ01QWENIRz15CkNPTkZJR19YODZfWEFERD15CkNP
TkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NwpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklU
SE09eQpDT05GSUdfWDg2X1dQX1dPUktTX09LPXkKQ09ORklHX1g4Nl9JTlZMUEc9eQpDT05G
SUdfWDg2X0JTV0FQPXkKQ09ORklHX1g4Nl9QT1BBRF9PSz15CkNPTkZJR19YODZfR09PRF9B
UElDPXkKQ09ORklHX1g4Nl9JTlRFTF9VU0VSQ09QWT15CkNPTkZJR19YODZfVVNFX1BQUk9f
Q0hFQ0tTVU09eQpDT05GSUdfSFBFVF9USU1FUj15CiMgQ09ORklHX0hQRVRfRU1VTEFURV9S
VEMgaXMgbm90IHNldAojIENPTkZJR19TTVAgaXMgbm90IHNldApDT05GSUdfUFJFRU1QVD15
CiMgQ09ORklHX1g4Nl9VUF9BUElDIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9UU0M9eQpDT05G
SUdfWDg2X01DRT15CkNPTkZJR19YODZfTUNFX05PTkZBVEFMPXkKIyBDT05GSUdfVE9TSElC
QSBpcyBub3Qgc2V0CiMgQ09ORklHX0k4SyBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPQ09E
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9NU1IgaXMgbm90IHNldAojIENPTkZJR19YODZf
Q1BVSUQgaXMgbm90IHNldAoKIwojIEZpcm13YXJlIERyaXZlcnMKIwojIENPTkZJR19FREQg
aXMgbm90IHNldAojIENPTkZJR19TTUJJT1MgaXMgbm90IHNldApDT05GSUdfTk9ISUdITUVN
PXkKIyBDT05GSUdfSElHSE1FTTRHIGlzIG5vdCBzZXQKIyBDT05GSUdfSElHSE1FTTY0RyBp
cyBub3Qgc2V0CiMgQ09ORklHX01BVEhfRU1VTEFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX01U
UlI9eQojIENPTkZJR19FRkkgaXMgbm90IHNldApDT05GSUdfSEFWRV9ERUNfTE9DSz15CkNP
TkZJR19SRUdQQVJNPXkKCiMKIyBQb3dlciBtYW5hZ2VtZW50IG9wdGlvbnMgKEFDUEksIEFQ
TSkKIwpDT05GSUdfUE09eQpDT05GSUdfU09GVFdBUkVfU1VTUEVORD15CiMgQ09ORklHX1BN
X0RJU0sgaXMgbm90IHNldAoKIwojIEFDUEkgKEFkdmFuY2VkIENvbmZpZ3VyYXRpb24gYW5k
IFBvd2VyIEludGVyZmFjZSkgU3VwcG9ydAojCkNPTkZJR19BQ1BJPXkKQ09ORklHX0FDUElf
Qk9PVD15CkNPTkZJR19BQ1BJX0lOVEVSUFJFVEVSPXkKQ09ORklHX0FDUElfU0xFRVA9eQpD
T05GSUdfQUNQSV9TTEVFUF9QUk9DX0ZTPXkKQ09ORklHX0FDUElfQUM9eQpDT05GSUdfQUNQ
SV9CQVRURVJZPXkKQ09ORklHX0FDUElfQlVUVE9OPXkKQ09ORklHX0FDUElfRkFOPXkKQ09O
RklHX0FDUElfUFJPQ0VTU09SPXkKQ09ORklHX0FDUElfVEhFUk1BTD15CiMgQ09ORklHX0FD
UElfQVNVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfVE9TSElCQSBpcyBub3Qgc2V0CiMg
Q09ORklHX0FDUElfREVCVUcgaXMgbm90IHNldApDT05GSUdfQUNQSV9CVVM9eQpDT05GSUdf
QUNQSV9FQz15CkNPTkZJR19BQ1BJX1BPV0VSPXkKQ09ORklHX0FDUElfUENJPXkKQ09ORklH
X0FDUElfU1lTVEVNPXkKIyBDT05GSUdfWDg2X1BNX1RJTUVSIGlzIG5vdCBzZXQKCiMKIyBB
UE0gKEFkdmFuY2VkIFBvd2VyIE1hbmFnZW1lbnQpIEJJT1MgU3VwcG9ydAojCiMgQ09ORklH
X0FQTSBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCiMKIyBDT05GSUdf
Q1BVX0ZSRVEgaXMgbm90IHNldAoKIwojIEJ1cyBvcHRpb25zIChQQ0ksIFBDTUNJQSwgRUlT
QSwgTUNBLCBJU0EpCiMKQ09ORklHX1BDST15CiMgQ09ORklHX1BDSV9HT0JJT1MgaXMgbm90
IHNldAojIENPTkZJR19QQ0lfR09NTUNPTkZJRyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9H
T0RJUkVDVCBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfR09BTlk9eQpDT05GSUdfUENJX0JJT1M9
eQpDT05GSUdfUENJX0RJUkVDVD15CkNPTkZJR19QQ0lfTU1DT05GSUc9eQpDT05GSUdfUENJ
X0xFR0FDWV9QUk9DPXkKQ09ORklHX1BDSV9OQU1FUz15CkNPTkZJR19JU0E9eQojIENPTkZJ
R19FSVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0N4
MjAwIGlzIG5vdCBzZXQKCiMKIyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cwojCkNPTkZJR19C
SU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9BT1VUPXkKQ09ORklHX0JJTkZNVF9NSVNDPXkK
CiMKIyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCgoj
CiMgTWVtb3J5IFRlY2hub2xvZ3kgRGV2aWNlcyAoTVREKQojCiMgQ09ORklHX01URCBpcyBu
b3Qgc2V0CgojCiMgUGFyYWxsZWwgcG9ydCBzdXBwb3J0CiMKIyBDT05GSUdfUEFSUE9SVCBp
cyBub3Qgc2V0CgojCiMgUGx1ZyBhbmQgUGxheSBzdXBwb3J0CiMKQ09ORklHX1BOUD15CiMg
Q09ORklHX1BOUF9ERUJVRyBpcyBub3Qgc2V0CgojCiMgUHJvdG9jb2xzCiMKIyBDT05GSUdf
SVNBUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfUE5QQklPUyBpcyBub3Qgc2V0CgojCiMgQmxv
Y2sgZGV2aWNlcwojCkNPTkZJR19CTEtfREVWX0ZEPXkKIyBDT05GSUdfQkxLX0RFVl9YRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtf
Q1BRX0NJU1NfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0RBQzk2MCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0xP
T1A9eQojIENPTkZJR19CTEtfREVWX0NSWVBUT0xPT1AgaXMgbm90IHNldApDT05GSUdfQkxL
X0RFVl9OQkQ9eQojIENPTkZJR19CTEtfREVWX0NBUk1FTCBpcyBub3Qgc2V0CkNPTkZJR19C
TEtfREVWX1JBTT15CkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTQwOTYKIyBDT05GSUdfQkxL
X0RFVl9JTklUUkQgaXMgbm90IHNldApDT05GSUdfTEJEPXkKCiMKIyBBVEEvQVRBUEkvTUZN
L1JMTCBzdXBwb3J0CiMKQ09ORklHX0lERT15CkNPTkZJR19CTEtfREVWX0lERT15CgojCiMg
UGxlYXNlIHNlZSBEb2N1bWVudGF0aW9uL2lkZS50eHQgZm9yIGhlbHAvaW5mbyBvbiBJREUg
ZHJpdmVzCiMKIyBDT05GSUdfQkxLX0RFVl9IRF9JREUgaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX0lERURJU0sgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVDRD15CiMgQ09O
RklHX0JMS19ERVZfSURFVEFQRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFRkxP
UFBZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVTQ1NJIGlzIG5vdCBzZXQKIyBD
T05GSUdfSURFX1RBU0tfSU9DVEwgaXMgbm90IHNldApDT05GSUdfSURFX1RBU0tGSUxFX0lP
PXkKCiMKIyBJREUgY2hpcHNldCBzdXBwb3J0L2J1Z2ZpeGVzCiMKQ09ORklHX0lERV9HRU5F
UklDPXkKQ09ORklHX0JMS19ERVZfQ01ENjQwPXkKIyBDT05GSUdfQkxLX0RFVl9DTUQ2NDBf
RU5IQU5DRUQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lERVBOUCBpcyBub3Qgc2V0
CkNPTkZJR19CTEtfREVWX0lERVBDST15CkNPTkZJR19JREVQQ0lfU0hBUkVfSVJRPXkKIyBD
T05GSUdfQkxLX0RFVl9PRkZCT0FSRCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0dFTkVS
SUM9eQojIENPTkZJR19CTEtfREVWX09QVEk2MjEgaXMgbm90IHNldApDT05GSUdfQkxLX0RF
Vl9SWjEwMDA9eQpDT05GSUdfQkxLX0RFVl9JREVETUFfUENJPXkKIyBDT05GSUdfQkxLX0RF
Vl9JREVETUFfRk9SQ0VEIGlzIG5vdCBzZXQKQ09ORklHX0lERURNQV9QQ0lfQVVUTz15CiMg
Q09ORklHX0lERURNQV9PTkxZRElTSyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0FETUE9
eQojIENPTkZJR19CTEtfREVWX0FFQzYyWFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0FNRDc0WFggaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX0FUSUlYUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
Q01ENjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9UUklGTEVYIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9DWTgyQzY5MyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
Q1M1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DUzU1MzAgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0hQVDM0WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSFBU
MzY2IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TQzEyMDAgaXMgbm90IHNldApDT05G
SUdfQkxLX0RFVl9QSUlYPXkKIyBDT05GSUdfQkxLX0RFVl9OUzg3NDE1IGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9PTEQgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWX1BEQzIwMlhYX05FVyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NWV0tTPXkKIyBD
T05GSUdfQkxLX0RFVl9TSUlNQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TSVM1
NTEzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TTEM5MEU2NiBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfVFJNMjkwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9WSUE4
MkNYWFggaXMgbm90IHNldAojIENPTkZJR19JREVfQVJNIGlzIG5vdCBzZXQKIyBDT05GSUdf
SURFX0NISVBTRVRTIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRE1BPXkKIyBDT05G
SUdfSURFRE1BX0lWQiBpcyBub3Qgc2V0CkNPTkZJR19JREVETUFfQVVUTz15CiMgQ09ORklH
X0JMS19ERVZfSEQgaXMgbm90IHNldAoKIwojIFNDU0kgZGV2aWNlIHN1cHBvcnQKIwpDT05G
SUdfU0NTST15CkNPTkZJR19TQ1NJX1BST0NfRlM9eQoKIwojIFNDU0kgc3VwcG9ydCB0eXBl
IChkaXNrLCB0YXBlLCBDRC1ST00pCiMKQ09ORklHX0JMS19ERVZfU0Q9eQojIENPTkZJR19D
SFJfREVWX1NUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hSX0RFVl9PU1NUIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9TUiBpcyBub3Qgc2V0CkNPTkZJR19DSFJfREVWX1NHPXkKCiMK
IyBTb21lIFNDU0kgZGV2aWNlcyAoZS5nLiBDRCBqdWtlYm94KSBzdXBwb3J0IG11bHRpcGxl
IExVTnMKIwpDT05GSUdfU0NTSV9NVUxUSV9MVU49eQpDT05GSUdfU0NTSV9DT05TVEFOVFM9
eQpDT05GSUdfU0NTSV9MT0dHSU5HPXkKCiMKIyBTQ1NJIFRyYW5zcG9ydCBBdHRyaWJ1dGVz
CiMKIyBDT05GSUdfU0NTSV9TUElfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZD
X0FUVFJTIGlzIG5vdCBzZXQKCiMKIyBTQ1NJIGxvdy1sZXZlbCBkcml2ZXJzCiMKIyBDT05G
SUdfQkxLX0RFVl8zV19YWFhYX1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJXzNXXzlY
WFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJXzcwMDBGQVNTVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfQUNBUkQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FIQTE1MlggaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0FIQTE1NDIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FB
Q1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzdYWFggaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0FJQzdYWFhfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3OVhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9EUFRfSTJPIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9BRFZBTlNZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU4yMDAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9NRUdBUkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FU
QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQlVTTE9HSUMgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0NQUUZDVFMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RNWDMxOTFEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9EVEMzMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9F
QVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FQVRBX1BJTyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfRlVUVVJFX0RPTUFJTiBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0dEVEg9eQoj
IENPTkZJR19TQ1NJX0dFTkVSSUNfTkNSNTM4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
R0VORVJJQ19OQ1I1MzgwX01NSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lQUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JQTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
TkNSNTNDNDA2QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDOFhYXzIgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1BBUzE2IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QU0ky
NDBJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTE9HSUNfRkFTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9RTE9HSUNfSVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTE9HSUNf
RkMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ18xMjgwIGlzIG5vdCBzZXQKQ09O
RklHX1NDU0lfUUxBMlhYWD15CiMgQ09ORklHX1NDU0lfUUxBMjFYWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfUUxBMjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxBMjMwMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxBMjMyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfUUxBNjMxMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxBNjMyMiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfU1lNNTNDNDE2IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9EQzM5
NXggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzkwVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfVDEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVTE0XzM0RiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfVUxUUkFTVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9OU1Az
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcgaXMgbm90IHNldAoKIwojIE9sZCBD
RC1ST00gZHJpdmVycyAobm90IFNDU0ksIG5vdCBJREUpCiMKIyBDT05GSUdfQ0RfTk9fSURF
U0NTSSBpcyBub3Qgc2V0CgojCiMgTXVsdGktZGV2aWNlIHN1cHBvcnQgKFJBSUQgYW5kIExW
TSkKIwojIENPTkZJR19NRCBpcyBub3Qgc2V0CgojCiMgRnVzaW9uIE1QVCBkZXZpY2Ugc3Vw
cG9ydAojCiMgQ09ORklHX0ZVU0lPTiBpcyBub3Qgc2V0CgojCiMgSUVFRSAxMzk0IChGaXJl
V2lyZSkgc3VwcG9ydAojCiMgQ09ORklHX0lFRUUxMzk0IGlzIG5vdCBzZXQKCiMKIyBJMk8g
ZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19JMk8gaXMgbm90IHNldAoKIwojIE5ldHdvcmtp
bmcgc3VwcG9ydAojCkNPTkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNP
TkZJR19QQUNLRVQ9eQpDT05GSUdfUEFDS0VUX01NQVA9eQpDT05GSUdfTkVUTElOS19ERVY9
eQpDT05GSUdfVU5JWD15CiMgQ09ORklHX05FVF9LRVkgaXMgbm90IHNldApDT05GSUdfSU5F
VD15CkNPTkZJR19JUF9NVUxUSUNBU1Q9eQpDT05GSUdfSVBfQURWQU5DRURfUk9VVEVSPXkK
IyBDT05GSUdfSVBfTVVMVElQTEVfVEFCTEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfUk9V
VEVfTVVMVElQQVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfUk9VVEVfVE9TIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBfUk9VVEVfVkVSQk9TRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1BO
UCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0lQR1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQKQ09ORklH
X0FSUEQ9eQojIENPTkZJR19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRf
QUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
RVRfSVBDT01QIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNiBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVEZJTFRFUiBpcyBub3Qgc2V0CgojCiMgU0NUUCBDb25maWd1cmF0aW9uIChFWFBFUklN
RU5UQUwpCiMKIyBDT05GSUdfSVBfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JSSURHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZMQU5fODAyMVEg
aXMgbm90IHNldAojIENPTkZJR19ERUNORVQgaXMgbm90IHNldAojIENPTkZJR19MTEMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVBYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBTEsgaXMgbm90
IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAojIENPTkZJR19MQVBCIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX0RJVkVSVCBpcyBub3Qgc2V0CiMgQ09ORklHX0VDT05FVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1dBTl9ST1VURVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRkFTVFJP
VVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0hXX0ZMT1dDT05UUk9MIGlzIG5vdCBzZXQK
CiMKIyBRb1MgYW5kL29yIGZhaXIgcXVldWVpbmcKIwojIENPTkZJR19ORVRfU0NIRUQgaXMg
bm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwojCiMgQ09ORklHX05FVF9QS1RHRU4gaXMg
bm90IHNldAojIENPTkZJR19LR0RCT0UgaXMgbm90IHNldAojIENPTkZJR19ORVRQT0xMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUUE9MTF9SWCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFBP
TExfVFJBUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9QT0xMX0NPTlRST0xMRVIgaXMgbm90
IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0lSREEgaXMgbm90
IHNldAojIENPTkZJR19CVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklH
X0RVTU1ZPXkKIyBDT05GSUdfQk9ORElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0VRVUFMSVpF
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1RVTiBpcyBub3Qgc2V0CiMgQ09ORklHX0VUSEVSVEFQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NCMTAwMCBpcyBub3Qgc2V0CgojCiMgQVJDbmV0
IGRldmljZXMKIwojIENPTkZJR19BUkNORVQgaXMgbm90IHNldAoKIwojIEV0aGVybmV0ICgx
MCBvciAxMDBNYml0KQojCkNPTkZJR19ORVRfRVRIRVJORVQ9eQpDT05GSUdfTUlJPXkKIyBD
T05GSUdfSEFQUFlNRUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VOR0VNIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfTEFOQ0UgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NNQyBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfUkFDQUwgaXMgbm90IHNldAoKIwojIFR1bGlwIGZhbWlseSBuZXR3b3JrIGRl
dmljZSBzdXBwb3J0CiMKIyBDT05GSUdfTkVUX1RVTElQIGlzIG5vdCBzZXQKIyBDT05GSUdf
QVQxNzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfREVQQ0EgaXMgbm90IHNldAojIENPTkZJR19I
UDEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JU0EgaXMgbm90IHNldApDT05GSUdfTkVU
X1BDST15CiMgQ09ORklHX1BDTkVUMzIgaXMgbm90IHNldAojIENPTkZJR19BTUQ4MTExX0VU
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0FEQVBURUNfU1RBUkZJUkUgaXMgbm90IHNldAojIENP
TkZJR19BQzMyMDAgaXMgbm90IHNldAojIENPTkZJR19BUFJJQ09UIGlzIG5vdCBzZXQKIyBD
T05GSUdfQjQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfRk9SQ0VERVRIIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1M4OXgwIGlzIG5vdCBzZXQKIyBDT05GSUdfREdSUyBpcyBub3Qgc2V0CkNPTkZJ
R19FRVBSTzEwMD15CkNPTkZJR19FRVBSTzEwMF9QSU89eQpDT05GSUdfRTEwMD15CkNPTkZJ
R19FMTAwX05BUEk9eQojIENPTkZJR19GRUFMTlggaXMgbm90IHNldAojIENPTkZJR19OQVRT
RU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkUyS19QQ0kgaXMgbm90IHNldAojIENPTkZJR184
MTM5Q1AgaXMgbm90IHNldAojIENPTkZJR184MTM5VE9PIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0lTOTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRVBJQzEwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NVTkRBTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVExBTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJQV9SSElORSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9QT0NLRVQgaXMgbm90IHNldAoK
IwojIEV0aGVybmV0ICgxMDAwIE1iaXQpCiMKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBzZXQK
IyBDT05GSUdfREwySyBpcyBub3Qgc2V0CiMgQ09ORklHX0UxMDAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfTlM4MzgyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTUFDSEkgaXMgbm90IHNldAoj
IENPTkZJR19ZRUxMT1dGSU4gaXMgbm90IHNldAojIENPTkZJR19SODE2OSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NLOThMSU4gaXMgbm90IHNldAojIENPTkZJR19USUdPTjMgaXMgbm90IHNl
dAoKIwojIEV0aGVybmV0ICgxMDAwMCBNYml0KQojCiMgQ09ORklHX0lYR0IgaXMgbm90IHNl
dAojIENPTkZJR19TMklPIGlzIG5vdCBzZXQKCiMKIyBUb2tlbiBSaW5nIGRldmljZXMKIwoj
IENPTkZJR19UUiBpcyBub3Qgc2V0CgojCiMgV2lyZWxlc3MgTEFOIChub24taGFtcmFkaW8p
CiMKIyBDT05GSUdfTkVUX1JBRElPIGlzIG5vdCBzZXQKCiMKIyBXYW4gaW50ZXJmYWNlcwoj
CiMgQ09ORklHX1dBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZEREkgaXMgbm90IHNldAojIENP
TkZJR19ISVBQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BQUCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NMSVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfRkMgaXMgbm90IHNldAojIENPTkZJR19T
SEFQRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRDT05TT0xFIGlzIG5vdCBzZXQKCiMKIyBJ
U0ROIHN1YnN5c3RlbQojCiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAoKIwojIFRlbGVwaG9u
eSBTdXBwb3J0CiMKIyBDT05GSUdfUEhPTkUgaXMgbm90IHNldAoKIwojIElucHV0IGRldmlj
ZSBzdXBwb3J0CiMKQ09ORklHX0lOUFVUPXkKCiMKIyBVc2VybGFuZCBpbnRlcmZhY2VzCiMK
Q09ORklHX0lOUFVUX01PVVNFREVWPXkKQ09ORklHX0lOUFVUX01PVVNFREVWX1BTQVVYPXkK
Q09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9YPTEwMjQKQ09ORklHX0lOUFVUX01PVVNF
REVWX1NDUkVFTl9ZPTc2OAojIENPTkZJR19JTlBVVF9KT1lERVYgaXMgbm90IHNldAojIENP
TkZJR19JTlBVVF9UU0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0VWREVWIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldAoKIwojIElucHV0IEkvTyBk
cml2ZXJzCiMKIyBDT05GSUdfR0FNRVBPUlQgaXMgbm90IHNldApDT05GSUdfU09VTkRfR0FN
RVBPUlQ9eQpDT05GSUdfU0VSSU89eQpDT05GSUdfU0VSSU9fSTgwNDI9eQojIENPTkZJR19T
RVJJT19TRVJQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fQ1Q4MkM3MTAgaXMgbm90
IHNldAojIENPTkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNldAoKIwojIElucHV0IERldmlj
ZSBEcml2ZXJzCiMKQ09ORklHX0lOUFVUX0tFWUJPQVJEPXkKQ09ORklHX0tFWUJPQVJEX0FU
S0JEPXkKIyBDT05GSUdfS0VZQk9BUkRfU1VOS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZ
Qk9BUkRfTEtLQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9YVEtCRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0tFWUJPQVJEX05FV1RPTiBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9N
T1VTRT15CkNPTkZJR19NT1VTRV9QUzI9eQojIENPTkZJR19NT1VTRV9TRVJJQUwgaXMgbm90
IHNldAojIENPTkZJR19NT1VTRV9JTlBPUlQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9M
T0dJQk0gaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9QQzExMFBBRCBpcyBub3Qgc2V0CiMg
Q09ORklHX01PVVNFX1ZTWFhYQUEgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElD
SyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfTUlTQyBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRldmljZXMKIwpD
T05GSUdfVlQ9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19IV19DT05TT0xFPXkKIyBD
T05GSUdfU0VSSUFMX05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKCiMKIyBTZXJpYWwgZHJpdmVy
cwojCkNPTkZJR19TRVJJQUxfODI1MD15CiMgQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEUg
aXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfODI1MF9BQ1BJIGlzIG5vdCBzZXQKQ09ORklH
X1NFUklBTF84MjUwX05SX1VBUlRTPTQKIyBDT05GSUdfU0VSSUFMXzgyNTBfRVhURU5ERUQg
aXMgbm90IHNldAoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQKIwpDT05GSUdf
U0VSSUFMX0NPUkU9eQpDT05GSUdfVU5JWDk4X1BUWVM9eQpDT05GSUdfTEVHQUNZX1BUWVM9
eQpDT05GSUdfTEVHQUNZX1BUWV9DT1VOVD0yMDQ4CiMgQ09ORklHX1FJQzAyX1RBUEUgaXMg
bm90IHNldAoKIwojIElQTUkKIwojIENPTkZJR19JUE1JX0hBTkRMRVIgaXMgbm90IHNldAoK
IwojIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfV0FUQ0hET0cgaXMgbm90IHNldAojIENP
TkZJR19IV19SQU5ET00gaXMgbm90IHNldAojIENPTkZJR19OVlJBTSBpcyBub3Qgc2V0CkNP
TkZJR19SVEM9eQojIENPTkZJR19EVExLIGlzIG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMg
bm90IHNldAojIENPTkZJR19BUFBMSUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPTllQSSBp
cyBub3Qgc2V0CgojCiMgRnRhcGUsIHRoZSBmbG9wcHkgdGFwZSBkZXZpY2UgZHJpdmVyCiMK
IyBDT05GSUdfRlRBUEUgaXMgbm90IHNldApDT05GSUdfQUdQPXkKIyBDT05GSUdfQUdQX0FM
SSBpcyBub3Qgc2V0CkNPTkZJR19BR1BfQVRJPXkKIyBDT05GSUdfQUdQX0FNRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0FHUF9BTUQ2NCBpcyBub3Qgc2V0CkNPTkZJR19BR1BfSU5URUw9eQoj
IENPTkZJR19BR1BfSU5URUxfTUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX05WSURJQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0FHUF9TSVMgaXMgbm90IHNldApDT05GSUdfQUdQX1NXT1JL
Uz15CiMgQ09ORklHX0FHUF9WSUEgaXMgbm90IHNldAojIENPTkZJR19BR1BfRUZGSUNFT04g
aXMgbm90IHNldApDT05GSUdfRFJNPXkKIyBDT05GSUdfRFJNX1RERlggaXMgbm90IHNldAoj
IENPTkZJR19EUk1fR0FNTUEgaXMgbm90IHNldAojIENPTkZJR19EUk1fUjEyOCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9SQURFT04gaXMgbm90IHNldAojIENPTkZJR19EUk1fSTgxMCBp
cyBub3Qgc2V0CkNPTkZJR19EUk1fSTgzMD15CiMgQ09ORklHX0RSTV9NR0EgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdBVkUgaXMgbm90IHNl
dAojIENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBFVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0hBTkdDSEVDS19USU1FUiBpcyBub3Qgc2V0CgojCiMgSTJDIHN1cHBv
cnQKIwojIENPTkZJR19JMkMgaXMgbm90IHNldAoKIwojIE1pc2MgZGV2aWNlcwojCiMgQ09O
RklHX0lCTV9BU00gaXMgbm90IHNldAoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCiMgQ09O
RklHX1ZJREVPX0RFViBpcyBub3Qgc2V0CgojCiMgRGlnaXRhbCBWaWRlbyBCcm9hZGNhc3Rp
bmcgRGV2aWNlcwojCiMgQ09ORklHX0RWQiBpcyBub3Qgc2V0CgojCiMgR3JhcGhpY3Mgc3Vw
cG9ydAojCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fU0VMRUNUIGlz
IG5vdCBzZXQKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIwpDT05GSUdf
VkdBX0NPTlNPTEU9eQojIENPTkZJR19NREFfQ09OU09MRSBpcyBub3Qgc2V0CkNPTkZJR19E
VU1NWV9DT05TT0xFPXkKCiMKIyBTb3VuZAojCiMgQ09ORklHX1NPVU5EIGlzIG5vdCBzZXQK
CiMKIyBVU0Igc3VwcG9ydAojCiMgQ09ORklHX1VTQiBpcyBub3Qgc2V0CgojCiMgVVNCIEdh
ZGdldCBTdXBwb3J0CiMKIyBDT05GSUdfVVNCX0dBREdFVCBpcyBub3Qgc2V0CgojCiMgRmls
ZSBzeXN0ZW1zCiMKQ09ORklHX0VYVDJfRlM9eQpDT05GSUdfRVhUMl9GU19YQVRUUj15CkNP
TkZJR19FWFQyX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFQyX0ZTX1NFQ1VSSVRZPXkKQ09O
RklHX0VYVDNfRlM9eQpDT05GSUdfRVhUM19GU19YQVRUUj15CkNPTkZJR19FWFQzX0ZTX1BP
U0lYX0FDTD15CkNPTkZJR19FWFQzX0ZTX1NFQ1VSSVRZPXkKQ09ORklHX0pCRD15CkNPTkZJ
R19KQkRfREVCVUc9eQpDT05GSUdfRlNfTUJDQUNIRT15CkNPTkZJR19SRUlTRVI0X0ZTPXkK
Q09ORklHX1JFSVNFUjRfRlNfU1lTQ0FMTD15CkNPTkZJR19SRUlTRVI0X0ZTX1NZU0NBTExf
WUFDQz15CkNPTkZJR19SRUlTRVI0X0xBUkdFX0tFWT15CiMgQ09ORklHX1JFSVNFUjRfQ0hF
Q0sgaXMgbm90IHNldApDT05GSUdfUkVJU0VSNF9VU0VfRUZMVVNIPXkKIyBDT05GSUdfUkVJ
U0VSNF9DT1BZX09OX0NBUFRVUkUgaXMgbm90IHNldAojIENPTkZJR19SRUlTRVI0X0JBREJM
T0NLUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFSVNFUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSkZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ZTX1BPU0lYX0FDTD15CiMgQ09ORklHX1hG
U19GUyBpcyBub3Qgc2V0CkNPTkZJR19NSU5JWF9GUz15CiMgQ09ORklHX1JPTUZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlNfRlMg
aXMgbm90IHNldApDT05GSUdfQVVUT0ZTNF9GUz15CgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lz
dGVtcwojCkNPTkZJR19JU085NjYwX0ZTPXkKQ09ORklHX0pPTElFVD15CiMgQ09ORklHX1pJ
U09GUyBpcyBub3Qgc2V0CkNPTkZJR19VREZfRlM9eQoKIwojIERPUy9GQVQvTlQgRmlsZXN5
c3RlbXMKIwpDT05GSUdfRkFUX0ZTPXkKQ09ORklHX01TRE9TX0ZTPXkKQ09ORklHX1ZGQVRf
RlM9eQojIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBQc2V1ZG8gZmlsZXN5c3Rl
bXMKIwpDT05GSUdfUFJPQ19GUz15CkNPTkZJR19QUk9DX0tDT1JFPXkKQ09ORklHX1NZU0ZT
PXkKIyBDT05GSUdfREVWRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19ERVZQVFNfRlNfWEFU
VFIgaXMgbm90IHNldApDT05GSUdfVE1QRlM9eQpDT05GSUdfSFVHRVRMQkZTPXkKQ09ORklH
X0hVR0VUTEJfUEFHRT15CkNPTkZJR19SQU1GUz15CgojCiMgTWlzY2VsbGFuZW91cyBmaWxl
c3lzdGVtcwojCiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZTX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExV
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19C
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19D
UkFNRlMgaXMgbm90IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFBGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CkNPTkZJ
R19TWVNWX0ZTPXkKIyBDT05GSUdfVUZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBOZXR3b3JrIEZp
bGUgU3lzdGVtcwojCkNPTkZJR19ORlNfRlM9eQpDT05GSUdfTkZTX1YzPXkKQ09ORklHX05G
U19WND15CkNPTkZJR19ORlNfRElSRUNUSU89eQpDT05GSUdfTkZTRD15CkNPTkZJR19ORlNE
X1YzPXkKQ09ORklHX05GU0RfVjQ9eQpDT05GSUdfTkZTRF9UQ1A9eQpDT05GSUdfTE9DS0Q9
eQpDT05GSUdfTE9DS0RfVjQ9eQpDT05GSUdfRVhQT1JURlM9eQpDT05GSUdfU1VOUlBDPXkK
Q09ORklHX1NVTlJQQ19HU1M9eQpDT05GSUdfUlBDU0VDX0dTU19LUkI1PXkKQ09ORklHX1NN
Ql9GUz15CkNPTkZJR19TTUJfTkxTX0RFRkFVTFQ9eQpDT05GSUdfU01CX05MU19SRU1PVEU9
ImNwNDM3IgojIENPTkZJR19DSUZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkNQX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGU19GUyBpcyBu
b3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVzCiMKIyBDT05GSUdfUEFSVElUSU9OX0FEVkFO
Q0VEIGlzIG5vdCBzZXQKQ09ORklHX01TRE9TX1BBUlRJVElPTj15CgojCiMgTmF0aXZlIExh
bmd1YWdlIFN1cHBvcnQKIwpDT05GSUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJpc284
ODU5LTEiCkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PXkKIyBDT05GSUdfTkxTX0NPREVQQUdF
XzczNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV83NzUgaXMgbm90IHNldApD
T05GSUdfTkxTX0NPREVQQUdFXzg1MD15CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjAg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYxIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjMgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY0IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfMTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfSVNPODg1OV8xPXkKIyBDT05G
SUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzMgaXMg
bm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV80IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0lTTzg4NTlfNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzYgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4
NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90IHNldApDT05GSUdfTkxTX0lTTzg4NTlfMTU9
eQojIENPTkZJR19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19VVEY4IGlzIG5vdCBzZXQKCiMKIyBQcm9maWxpbmcg
c3VwcG9ydAojCkNPTkZJR19QUk9GSUxJTkc9eQpDT05GSUdfT1BST0ZJTEU9eQoKIwojIEtl
cm5lbCBoYWNraW5nCiMKIyBDT05GSUdfREVCVUdfS0VSTkVMIGlzIG5vdCBzZXQKQ09ORklH
X0VBUkxZX1BSSU5USz15CkNPTkZJR19ERUJVR19TUElOTE9DS19TTEVFUD15CiMgQ09ORklH
X0ZSQU1FX1BPSU5URVIgaXMgbm90IHNldAojIENPTkZJR180S1NUQUNLUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDSEVEU1RBVFMgaXMgbm90IHNldAoKIwojIFNlY3VyaXR5IG9wdGlvbnMK
IwojIENPTkZJR19TRUNVUklUWSBpcyBub3Qgc2V0CgojCiMgQ3J5cHRvZ3JhcGhpYyBvcHRp
b25zCiMKQ09ORklHX0NSWVBUTz15CiMgQ09ORklHX0NSWVBUT19ITUFDIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX05VTEwgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTUQ0IGlz
IG5vdCBzZXQKQ09ORklHX0NSWVBUT19NRDU9eQojIENPTkZJR19DUllQVE9fU0hBMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEEyNTYgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fU0hBNTEyIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19ERVM9eQojIENPTkZJR19DUllQ
VE9fQkxPV0ZJU0ggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVFdPRklTSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0FFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNSBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19DQVNUNiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BUkM0IGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFRkxBVEUgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fTUlDSEFFTF9NSUMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1JDMzJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RFU1QgaXMgbm90IHNldAoKIwojIExpYnJhcnkgcm91
dGluZXMKIwpDT05GSUdfQ1JDMzI9eQojIENPTkZJR19MSUJDUkMzMkMgaXMgbm90IHNldAoj
IENPTkZJR19RU09SVCBpcyBub3Qgc2V0CkNPTkZJR19YODZfQklPU19SRUJPT1Q9eQpDT05G
SUdfUEM9eQp=

------_=_NextPart_000_0002350A.40BF5559--

