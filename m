Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTGZXRT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 19:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbTGZXRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 19:17:19 -0400
Received: from [207.44.242.120] ([207.44.242.120]:16045 "EHLO
	lucy.aventurehost.co.uk") by vger.kernel.org with ESMTP
	id S270626AbTGZXRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 19:17:12 -0400
Message-ID: <1059262346.3f230f8aef43b@www.thoughtcriminal.co.uk>
Date: Sun, 27 Jul 2003 00:32:26 +0100
From: paul@thoughtcriminal.co.uk
To: linux-kernel@vger.kernel.org
Subject: Re: ide problem - is this a known problem, or is the disk dead?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 80.47.196.134
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - lucy.aventurehost.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 502] / [47 12]
X-AntiAbuse: Sender Address Domain - thoughtcriminal.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having similar problems with a disk. I have ext3, reiser and ntfs
partitions on this disk and all are failing with messages such as those in the
rest of this thread and as below.

I am running Mandrake 9.1 (2.4.21-0.13) on an Asus A7N8X deluxe

Is this due to hardware failure or should I try a different kernel?

Please CC to me as I only have webmail because of this problem.


Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:51 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:52 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:52 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:52 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:52 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:53 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:53 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:53 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:53 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:53 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:53 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:53 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:53 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:53 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:53 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: zam-7001: io error in reiserfs_find_entry
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456

Message from syslogd@monkey at Sun Jul 27 00:15:54 2003 ...
monkey kernel: journal-601, buffer write failed
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector 1288
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector 1296
Jul 27 00:15:54 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector 1304
Jul 27 00:15:54 monkey kernel: journal-601, buffer write failed
Jul 27 00:15:54 monkey kernel: kernel BUG at prints.c:334!
Jul 27 00:15:54 monkey kernel: invalid operand: 0000
Jul 27 00:15:54 monkey kernel: ppp_deflate zlib_deflate bsd_comp ppp_async
ppp_generic slhc sd_mod isofs zlib_inflate udf ide-cd cdrom i810_audio soundcore
ac97_codec af_packet floppy 3c90x ohci1394 ieee1394 nls_cp850 vfat fat
nls_iso8859-15 ntfs reiserfs supermount usb-storage scsi_mod usbmouse keybdev
mousedev hid input ehci-hcd usb-ohci usbcore rtc ext3 jbd
Jul 27 00:15:54 monkey kernel: CPU:    0
Jul 27 00:15:54 monkey kernel: EIP:   
0010:[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1325544/96]
   Not tainted
Jul 27 00:15:54 monkey kernel: EIP:    0010:[<e49f9618>]    Not tainted
Jul 27 00:15:54 monkey kernel: EFLAGS: 00210286
Jul 27 00:15:54 monkey kernel: EIP is at reiserfs_panic+0x28/0x60 [reiserfs]
Jul 27 00:15:54 monkey kernel: eax: 00000024   ebx: df424c00   ecx: 00000001  
edx: dd940000
Jul 27 00:15:54 monkey kernel: esi: 00000000   edi: 00000012   ebp: c1591eb4  
esp: c1591ea0
Jul 27 00:15:54 monkey kernel: ds: 0018   es: 0018   ss: 0018
Jul 27 00:15:54 monkey kernel: Process kupdated (pid: 7, stackpage=c1591000)
Jul 27 00:15:54 monkey kernel: Stack: e4a107f1 e4a14f60 e4a0dfe0 c1591ec4
e4a18ba0 c1591ee0 e4a03c7a df424c00
Jul 27 00:15:54 monkey kernel:        e4a0dfe0 00000006 00000004 00000000
cf85c1e0 e4a1808c 00000029 00000013
Jul 27 00:15:54 monkey kernel:        c1591f44 e4a076be df424c00 e4a18ba0
00000001 e4a18000 e4a62414 00000820
Jul 27 00:15:54 monkey kernel: Call Trace:
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1230863/96]
.rodata.str1.1+0x4af/0xa1a [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a107f1>] .rodata.str1.1+0x4af/0xa1a [reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1212576/96]
error_buf+0x0/0x400 [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a14f60>] error_buf+0x0/0x400 [reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1241120/96]
.rodata.str1.32+0x3440/0x57a2 [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a0dfe0>] .rodata.str1.32+0x3440/0x57a2
[reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1282950/96]
flush_commit_list+0x29a/0x410 [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a03c7a>] flush_commit_list+0x29a/0x410
[reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1241120/96]
.rodata.str1.32+0x3440/0x57a2 [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a0dfe0>] .rodata.str1.32+0x3440/0x57a2
[reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1268034/96]
do_journal_end+0x60e/0xb10 [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a076be>] do_journal_end+0x60e/0xb10 [reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1271342/96]
flush_old_commits+0xf2/0x170 [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a069d2>] flush_old_commits+0xf2/0x170 [reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1230131/96]
.rodata.str1.1+0x78b/0xa1a [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e4a10acd>] .rodata.str1.1+0x78b/0xa1a [reiserfs]
Jul 27 00:15:54 monkey kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.13mdk/kernel/net/+-1337384/96]
reiserfs_write_super+0x28/0x30 [reiserfs]
Jul 27 00:15:54 monkey kernel:  [<e49f67d8>] reiserfs_write_super+0x28/0x30
[reiserfs]
Jul 27 00:15:54 monkey kernel:  [sync_supers+175/304] sync_supers+0xaf/0x130
[kernel]
Jul 27 00:15:54 monkey kernel:  [<c01448df>] sync_supers+0xaf/0x130 [kernel]
Jul 27 00:15:54 monkey kernel:  [sync_old_buffers+17/64]
sync_old_buffers+0x11/0x40 [kernel]
Jul 27 00:15:54 monkey kernel:  [<c0143d51>] sync_old_buffers+0x11/0x40 [kernel]
Jul 27 00:15:54 monkey kernel:  [kupdate+272/336] kupdate+0x110/0x150 [kernel]
Jul 27 00:15:54 monkey kernel:  [<c0144050>] kupdate+0x110/0x150 [kernel]
Jul 27 00:15:54 monkey kernel:  [rest_init+0/48] stext+0x0/0x30 [kernel]
Jul 27 00:15:54 monkey kernel:  [<c0105000>] stext+0x0/0x30 [kernel]
Jul 27 00:15:54 monkey kernel:  [arch_kernel_thread+38/64]
arch_kernel_thread+0x26/0x40 [kernel]
Jul 27 00:15:54 monkey kernel:  [<c0107526>] arch_kernel_thread+0x26/0x40 [kernel]
Jul 27 00:15:54 monkey kernel:  [kupdate+0/336] kupdate+0x0/0x150 [kernel]
Jul 27 00:15:54 monkey kernel:  [<c0143f40>] kupdate+0x0/0x150 [kernel]
Jul 27 00:15:54 monkey kernel:
Jul 27 00:15:54 monkey kernel: Code: 0f 0b 4e 01 f7 07 a1 e4 68 60 4f a1 e4 85
db 74 17 66 8b 43
Jul 27 00:15:57 monkey kernel:  <6>end_request: I/O error, dev 16:06 (hdc),
sector 15079456
Jul 27 00:15:57 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:03 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:03 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:09 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:09 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:15 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:15 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:21 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:21 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:27 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:27 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:33 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:33 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:39 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:39 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:45 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:45 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:51 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:51 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:16:57 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:16:57 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
Jul 27 00:17:03 monkey kernel: end_request: I/O error, dev 16:06 (hdc), sector
15079456
Jul 27 00:17:03 monkey kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [2 14773 0x0 SD]
