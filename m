Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTLPATx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTLPATx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:19:53 -0500
Received: from fep02.swip.net ([130.244.199.130]:35545 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S264301AbTLPATh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:19:37 -0500
Message-ID: <3FDE4F95.6060002@yahoo.fr>
Date: Tue, 16 Dec 2003 01:19:33 +0100
From: jjluza <jjluza@yahoo.fr>
Reply-To: jjluza@yahoo.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-2 StumbleUpon/1.87
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ 2.6.0-test11-bk11 ]  Error with usb-storage (kernel oops)
Content-Type: multipart/mixed;
 boundary="------------020308030100090709050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020308030100090709050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
I get several errors with my hdd which is plugged in an usb port.
I watch a movie on this hdd, but after several minutes (~= 5-10 
minutes), mplayer was blocked and I have difficulties shutting down it.
I lookat dmesg, and I found several error messages (see the attachment).

hardware :
seagate (40GB) hdd in this enermax box :
http://www.enermax.com.tw/ehd-350s.htm
which is plugged in an usb port on my nforce2 motherboard.
It works without problem with windowsXP for about 20 minutes (so I think 
it's not nforce2 related).

You can find all informations in the file in attachment, and all error 
you can see in it is related with this problem (scsi, ext3, etc ...)

I hope you will be able to help me :)

--------------020308030100090709050000
Content-Type: text/plain;
 name="error.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="error.log"

drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
hub 2-0:1.0: new USB device on port 1, assigned address 2
Adding 497972k swap on /dev/ide/host0/bus0/target0/lun0/part1.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
NET: Registered protocol family 8
NET: Registered protocol family 20
drivers/usb/core/usb.c: registered new driver speedtch
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
PCI: Setting latency timer of device 0000:00:06.0 to 64
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
intel8x0: clocking to 47437
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003
usbfs: process 351 (modem_run) did not claim interface 0 before use
hub 1-0:1.0: new USB device on port 3, assigned address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: ST340016  Model: A                 Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sda2.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
SCSI error : <0 0 0 0> return code = 0x6050000
end_request: I/O error, dev sda, sector 37208155
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda7, logical block 196
lost page write due to I/O error on sda7
Aborting journal on device sda7.
usb 1-3: USB disconnect, address 2
scsi0 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 4325381
lost page write due to I/O error on sda7
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda7): ext3_readdir: directory #1217 contains a hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 0
lost page write due to I/O error on sda7
ext3_abort called.
EXT3-fs abort (device sda7): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda7): ext3_readdir: directory #1217 contains a hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda7): ext3_readdir: directory #4257 contains a hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda7): ext3_readdir: directory #257 contains a hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda7): ext3_readdir: directory #2 contains a hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 11
lost page write due to I/O error on sda7
drivers/usb/core/usb.c: deregistering driver usb-storage
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: deregistering driver usb-storage
hub 1-0:1.0: new USB device on port 3, assigned address 3
Initializing USB Mass Storage driver...
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: ST340016  Model: A                 Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: assuming drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on sda7, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
SCSI error : <1 0 0 0> return code = 0x6050000
end_request: I/O error, dev sda, sector 37207979
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda7, logical block 174
lost page write due to I/O error on sda7
Aborting journal on device sda7.
usb 1-3: USB disconnect, address 3
scsi1 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 4325381
lost page write due to I/O error on sda7
scsi1 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda7): ext3_readdir: directory #1217 contains a hole at offset 0
scsi1 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 0
lost page write due to I/O error on sda7
ext3_abort called.
EXT3-fs abort (device sda7): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
scsi1 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 11
lost page write due to I/O error on sda7
drivers/usb/core/usb.c: deregistering driver usb-storage
hub 1-0:1.0: new USB device on port 3, assigned address 4
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: ST340016  Model: A                 Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: assuming drive cache: write through
 /dev/scsi/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on sda7, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: deregistering driver usb-storage
usb 1-3: USB disconnect, address 4
hub 1-0:1.0: new USB device on port 2, assigned address 5
Initializing USB Mass Storage driver...
scsi3 : SCSI emulation for USB Mass Storage devices
  Vendor: ST340016  Model: A                 Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: assuming drive cache: write through
 /dev/scsi/host3/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Attached scsi disk sda at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi3, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 5
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi: Device offlined - not ready after error recovery: host 3 channel 0 id 0 lun 0
SCSI error : <3 0 0 0> return code = 0x6050000
end_request: I/O error, dev sda, sector 37207139
scsi3 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda7, logical block 69
lost page write due to I/O error on sda7
Aborting journal on device sda7.
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device sda7) in ext3_reserve_inode_write: Journal has aborted
scsi3 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda7, logical block 0
lost page write due to I/O error on sda7
EXT3-fs error (device sda7) in ext3_dirty_inode: Journal has aborted
buffer layer error at fs/buffer.c:1260
Call Trace:
 [<c0152958>] mark_buffer_dirty+0x48/0x50
 [<c018fc41>] ext3_commit_super+0x51/0x90
 [<c018da0d>] ext3_handle_error+0x6d/0xb0
 [<c018db9d>] __ext3_std_error+0x4d/0x60
 [<c01896bb>] ext3_mark_inode_dirty+0x2b/0x60
 [<c018d922>] __ext3_journal_stop+0x42/0x50
 [<c0189759>] ext3_dirty_inode+0x69/0x90
 [<c016fb5e>] __mark_inode_dirty+0xde/0xf0
 [<c0169d90>] update_atime+0xd0/0xe0
 [<c0135792>] __generic_file_aio_read+0x1f2/0x230
 [<c01354b0>] file_read_actor+0x0/0xf0
 [<e1b50a8d>] __nvsym00727+0x31/0x38 [nvidia]
 [<c013582a>] generic_file_aio_read+0x5a/0x80
 [<c014fe8b>] do_sync_read+0x8b/0xc0
 [<c0117ade>] recalc_task_prio+0x8e/0x1b0
 [<c01243fd>] schedule_timeout+0x6d/0xc0
 [<c014ff98>] vfs_read+0xd8/0x140
 [<c0124613>] sys_nanosleep+0x103/0x1b0
 [<c0150242>] sys_read+0x42/0x70
 [<c010abb5>] sysenter_past_esp+0x52/0x71

buffer layer error at fs/buffer.c:2664
Call Trace:
 [<c0154b2a>] submit_bh+0x11a/0x170
 [<c0154c48>] sync_dirty_buffer+0x48/0xb0
 [<c018da0d>] ext3_handle_error+0x6d/0xb0
 [<c018db9d>] __ext3_std_error+0x4d/0x60
 [<c01896bb>] ext3_mark_inode_dirty+0x2b/0x60
 [<c018d922>] __ext3_journal_stop+0x42/0x50
 [<c0189759>] ext3_dirty_inode+0x69/0x90
 [<c016fb5e>] __mark_inode_dirty+0xde/0xf0
 [<c0169d90>] update_atime+0xd0/0xe0
 [<c0135792>] __generic_file_aio_read+0x1f2/0x230
 [<c01354b0>] file_read_actor+0x0/0xf0
 [<e1b50a8d>] __nvsym00727+0x31/0x38 [nvidia]
 [<c013582a>] generic_file_aio_read+0x5a/0x80
 [<c014fe8b>] do_sync_read+0x8b/0xc0
 [<c0117ade>] recalc_task_prio+0x8e/0x1b0
 [<c01243fd>] schedule_timeout+0x6d/0xc0
 [<c014ff98>] vfs_read+0xd8/0x140
 [<c0124613>] sys_nanosleep+0x103/0x1b0
 [<c0150242>] sys_read+0x42/0x70
 [<c010abb5>] sysenter_past_esp+0x52/0x71

scsi3 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda7, logical block 0
lost page write due to I/O error on sda7
usb 1-2: USB disconnect, address 5
scsi3 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 4292613
lost page write due to I/O error on sda7
scsi3 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 11
lost page write due to I/O error on sda7
buffer layer error at fs/buffer.c:1260
Call Trace:
 [<c0152958>] mark_buffer_dirty+0x48/0x50
 [<c018e090>] ext3_put_super+0x170/0x190
 [<c0156433>] generic_shutdown_super+0x173/0x190
 [<c0156fad>] kill_block_super+0x1d/0x50
 [<c015616e>] deactivate_super+0x5e/0xc0
 [<c016c11f>] sys_umount+0x3f/0x90
 [<c016c187>] sys_oldumount+0x17/0x20
 [<c010abb5>] sysenter_past_esp+0x52/0x71

buffer layer error at fs/buffer.c:1260
Call Trace:
 [<c0152958>] mark_buffer_dirty+0x48/0x50
 [<c018fc41>] ext3_commit_super+0x51/0x90
 [<c018e0a4>] ext3_put_super+0x184/0x190
 [<c0156433>] generic_shutdown_super+0x173/0x190
 [<c0156fad>] kill_block_super+0x1d/0x50
 [<c015616e>] deactivate_super+0x5e/0xc0
 [<c016c11f>] sys_umount+0x3f/0x90
 [<c016c187>] sys_oldumount+0x17/0x20
 [<c010abb5>] sysenter_past_esp+0x52/0x71

buffer layer error at fs/buffer.c:2664
Call Trace:
 [<c0154b2a>] submit_bh+0x11a/0x170
 [<c0154c48>] sync_dirty_buffer+0x48/0xb0
 [<c018e0a4>] ext3_put_super+0x184/0x190
 [<c0156433>] generic_shutdown_super+0x173/0x190
 [<c0156fad>] kill_block_super+0x1d/0x50
 [<c015616e>] deactivate_super+0x5e/0xc0
 [<c016c11f>] sys_umount+0x3f/0x90
 [<c016c187>] sys_oldumount+0x17/0x20
 [<c010abb5>] sysenter_past_esp+0x52/0x71

scsi3 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda7, logical block 0
lost page write due to I/O error on sda7
drivers/usb/core/usb.c: deregistering driver usb-storage


--------------020308030100090709050000--

