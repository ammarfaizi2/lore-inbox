Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVJQNMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVJQNMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 09:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJQNMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 09:12:00 -0400
Received: from azzurro.acantho.net ([213.174.160.70]:33506 "EHLO
	azzurro.acantho.net") by vger.kernel.org with ESMTP
	id S1751271AbVJQNMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 09:12:00 -0400
Message-ID: <4353A313.6010507@acantho.net>
Date: Mon, 17 Oct 2005 15:11:47 +0200
From: Gianluca Rossi <grossi@acantho.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: (2.6.13.2)  kernel BUG at fs/reiserfs/prints.c:362!
Content-Type: multipart/mixed;
 boundary="------------020900000409030106070608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020900000409030106070608
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
this is a kernel BUG I have got while mounting a reiserfs filesystem.
is this a know bug?
any hint?
..Now i try to upgrade to 2.6.13.4
PS: please put me on CC if you reply
--
Gianluca Rossi

--------------020900000409030106070608
Content-Type: text/plain;
 name="kbug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kbug.log"

Oct 15 14:45:57 bb2 kernel: [  181.630388] ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
Oct 15 14:45:57 bb2 kernel: [  181.633843] ReiserFS: dm-1: using ordered data mode
Oct 15 14:45:57 bb2 kernel: [  181.634449] ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct 15 14:45:57 bb2 kernel: [  181.635682] ReiserFS: dm-1: checking transaction log (dm-1)
Oct 15 14:45:57 bb2 kernel: [  181.644984] ReiserFS: dm-1: Using r5 hash to sort names
Oct 15 14:45:57 bb2 kernel: [  181.712497] ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
Oct 15 14:45:57 bb2 kernel: [  181.717602] ReiserFS: dm-0: using ordered data mode
Oct 15 14:45:57 bb2 kernel: [  181.718219] ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct 15 14:45:57 bb2 kernel: [  181.719522] ReiserFS: dm-0: checking transaction log (dm-0)
Oct 15 14:45:57 bb2 kernel: [  181.724203] ReiserFS: dm-0: Using r5 hash to sort names
Oct 15 14:45:57 bb2 kernel: [  181.795331] ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
Oct 15 14:45:57 bb2 kernel: [  181.795862] ReiserFS: dm-3: using ordered data mode
Oct 15 14:45:57 bb2 kernel: [  181.796286] ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct 15 14:45:57 bb2 kernel: [  181.797542] ReiserFS: dm-3: checking transaction log (dm-3)
Oct 15 14:45:57 bb2 kernel: [  181.803895] ReiserFS: dm-3: Using r5 hash to sort names
Oct 15 14:45:57 bb2 kernel: [  181.871462] ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
Oct 15 14:45:57 bb2 kernel: [  181.872106] ReiserFS: dm-2: using ordered data mode
Oct 15 14:45:57 bb2 kernel: [  181.872527] ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct 15 14:45:57 bb2 kernel: [  181.873705] ReiserFS: dm-2: checking transaction log (dm-2)
Oct 15 14:45:57 bb2 kernel: [  181.884397] ReiserFS: dm-2: Using r5 hash to sort names
Oct 15 14:46:42 bb2 kernel: [  226.992377] kjournald starting.  Commit interval 5 seconds
Oct 15 14:46:42 bb2 kernel: [  226.992777] EXT3 FS on dm-4, internal journal
Oct 15 14:46:42 bb2 kernel: [  226.992817] EXT3-fs: recovery complete.
Oct 15 14:46:42 bb2 kernel: [  226.993149] EXT3-fs: mounted filesystem with ordered data mode.
Oct 15 14:46:44 bb2 kernel: [  228.788093] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316583)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.788218] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316582)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.788743] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316581)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.788842] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316580)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.789222] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316579)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.789306] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316578)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.789700] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316577)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.789814] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316576)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.815292] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=23, free_space=64576 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.815417] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1310880. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.815543] ReiserFS: dm-0: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [404198 433838 0x0 SD] stat data
Oct 15 14:46:44 bb2 kernel: [  228.816092] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=23, free_space=64576 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.816200] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1310880. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.816306] ReiserFS: dm-0: warning: vs-5350: reiserfs_delete_solid_item: i/o failure occurred trying to delete [404198 433838 0x0 SD]
Oct 15 14:46:44 bb2 kernel: [  228.818325] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=23, free_space=64576 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.818489] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1310880. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.822900] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=23, free_space=64576 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.822999] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1310880. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.830424] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=23, free_space=64576 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.830556] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1310880. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.830644] ReiserFS: dm-0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [404198 433790 0x0 SD]
Oct 15 14:46:44 bb2 kernel: [  228.849415] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316692)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.849506] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316691)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.859087] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=9, free_space=65432 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.859190] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1311238. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.861113] ReiserFS: dm-0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [404198 434071 0x0 SD]
Oct 15 14:46:44 bb2 kernel: [  228.863475] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=9, free_space=65432 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.863554] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1311238. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.863622] ReiserFS: dm-0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [404198 434069 0x0 SD]
Oct 15 14:46:44 bb2 kernel: [  228.864071] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=9, free_space=65432 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.864152] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1311238. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.864218] ReiserFS: dm-0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [404198 434070 0x0 SD]
Oct 15 14:46:44 bb2 kernel: [  228.884697] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316869)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.884870] ReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dm-0:1316868)[dev:blocknr]: bit already cleared
Oct 15 14:46:44 bb2 kernel: [  228.885652] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=9, free_space=65432 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.885746] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1311238. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.885821] ReiserFS: dm-0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [404198 434068 0x0 SD]
Oct 15 14:46:44 bb2 kernel: [  228.892521] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=9, free_space=65432 rdkey 
Oct 15 14:46:44 bb2 kernel: [  228.892612] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1311238. Fsck?
Oct 15 14:46:44 bb2 kernel: [  228.892692] ReiserFS: dm-0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [404198 434065 0x0 SD]
Oct 15 14:47:44 bb2 kernel: [  288.391647] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=23, free_space=64576 rdkey 
Oct 15 14:47:44 bb2 kernel: [  288.391718] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1310880. Fsck?
Oct 15 14:47:44 bb2 kernel: [  288.391782] ReiserFS: dm-0: warning: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [404198 433854 0xfffffffffffffff DIRECT]
Oct 15 14:47:44 bb2 kernel: [  288.391868] ReiserFS: warning: is_leaf: free space seems wrong: level=1, nr_items=23, free_space=64576 rdkey 
Oct 15 14:47:44 bb2 kernel: [  288.391937] ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1310880. Fsck?
Oct 15 14:47:44 bb2 kernel: [  288.392003] ReiserFS: dm-0: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [404198 433854 0x0 SD] stat data
Oct 15 14:47:44 bb2 kernel: [  288.392093] REISERFS: panic (device dm-0): journal-1577: handle trans id 2 != current trans id 260691
Oct 15 14:47:44 bb2 kernel: [  288.392096] 
Oct 15 14:47:44 bb2 kernel: [  288.392187] ------------[ cut here ]------------
Oct 15 14:47:44 bb2 kernel: [  288.392219] kernel BUG at fs/reiserfs/prints.c:362!
Oct 15 14:47:44 bb2 kernel: [  288.392252] invalid operand: 0000 [#1]
Oct 15 14:47:44 bb2 kernel: [  288.392285] SMP 
Oct 15 14:47:44 bb2 kernel: [  288.392324] Modules linked in: reiserfs floppy generic i2c_piix4 i2c_core lpfc scsi_transport_fc tg3 bonding dm_snapshot ide_generic ide_disk ide_cd cdrom ide_core rtc
Oct 15 14:47:44 bb2 kernel: [  288.392526] CPU:    3
Oct 15 14:47:44 bb2 kernel: [  288.392527] EIP:    0060:[pg0+945935986/1069417472]    Not tainted VLI
Oct 15 14:47:44 bb2 kernel: [  288.392528] EFLAGS: 00010296   (2.6.13.2) 
Oct 15 14:47:44 bb2 kernel: [  288.392638] EIP is at reiserfs_panic+0x52/0x80 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.392671] eax: 0000007f   ebx: f8a53a87   ecx: c033eb10   edx: 00000282
Oct 15 14:47:44 bb2 kernel: [  288.392707] esi: f3823800   edi: f3823958   ebp: f6301528   esp: ccdd3ce8
Oct 15 14:47:44 bb2 kernel: [  288.392742] ds: 007b   es: 007b   ss: 0068
Oct 15 14:47:44 bb2 kernel: [  288.392771] Process bbgen (pid: 5700, threadinfo=ccdd2000 task=f7786020)
Oct 15 14:47:44 bb2 kernel: [  288.392790] Stack: f8a50400 f3823958 f8a5a7a0 f3823800 f3823800 f89a3000 f8a4a724 f3823800 
Oct 15 14:47:44 bb2 kernel: [  288.392892]        f8a529a0 00000002 0003fa53 1ae01548 f3823800 f467c000 c01c77c0 f467c0d0 
Oct 15 14:47:44 bb2 kernel: [  288.392991]        00000000 f467c0cc f3823800 f467c000 00069fe4 f8a3c537 ccdd3e88 f3823800 
Oct 15 14:47:44 bb2 kernel: [  288.393090] Call Trace:
Oct 15 14:47:44 bb2 kernel: [  288.393136]  [pg0+945997604/1069417472] journal_mark_dirty+0x244/0x270 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.393192]  [memmove+80/84] memmove+0x50/0x54
Oct 15 14:47:44 bb2 kernel: [  288.393238]  [pg0+945939767/1069417472] reiserfs_get_unused_objectid+0x97/0x110 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.393292]  [pg0+945883059/1069417472] reiserfs_new_inode+0x143/0x740 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.393344]  [pg0+945858510/1069417472] search_by_entry_key+0xbe/0x210 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.393395]  [pg0+945859823/1069417472] reiserfs_find_entry+0xbf/0x140 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.393446]  [d_rehash+107/144] d_rehash+0x6b/0x90
Oct 15 14:47:44 bb2 kernel: [  288.393491]  [pg0+945862140/1069417472] reiserfs_create+0x9c/0x1b0 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.393543]  [permission+111/160] permission+0x6f/0xa0
Oct 15 14:47:44 bb2 kernel: [  288.393587]  [vfs_create+145/256] vfs_create+0x91/0x100
Oct 15 14:47:44 bb2 kernel: [  288.393630]  [open_namei+1507/1600] open_namei+0x5e3/0x640
Oct 15 14:47:44 bb2 kernel: [  288.393672]  [get_empty_filp+103/224] get_empty_filp+0x67/0xe0
Oct 15 14:47:44 bb2 kernel: [  288.393715]  [file_move+32/96] file_move+0x20/0x60
Oct 15 14:47:44 bb2 kernel: [  288.393757]  [filp_open+62/112] filp_open+0x3e/0x70
Oct 15 14:47:44 bb2 kernel: [  288.393802]  [get_unused_fd+162/208] get_unused_fd+0xa2/0xd0
Oct 15 14:47:44 bb2 kernel: [  288.393846]  [sys_open+79/224] sys_open+0x4f/0xe0
Oct 15 14:47:44 bb2 kernel: [  288.393889]  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 15 14:47:44 bb2 kernel: [  288.393932] Code: 01 00 00 89 04 24 e8 0e fd ff ff c7 04 24 00 04 a5 f8 85 f6 89 d8 0f 45 c7 ba a0 a7 a5 f8 89 54 24 08 89 44 24 04 e8 9e 22 6e c7 <0f> 0b 6a 01 97 3a a5 f8 c7 04 24 40 04 a5 f8 85 f6 be a0 a7 a5 
Oct 15 14:47:44 bb2 kernel: [  288.394373]  Badness in do_exit at kernel/exit.c:787
Oct 15 14:47:44 bb2 kernel: [  288.394436]  [do_exit+969/976] do_exit+0x3c9/0x3d0
Oct 15 14:47:44 bb2 kernel: [  288.394489]  [die+380/384] die+0x17c/0x180
Oct 15 14:47:44 bb2 kernel: [  288.394535]  [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
Oct 15 14:47:44 bb2 kernel: [  288.394580]  [do_invalid_op+178/208] do_invalid_op+0xb2/0xd0
Oct 15 14:47:44 bb2 kernel: [  288.394626]  [__wake_up+62/96] __wake_up+0x3e/0x60
Oct 15 14:47:44 bb2 kernel: [  288.394674]  [pg0+945935986/1069417472] reiserfs_panic+0x52/0x80 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.394733]  [release_console_sem+185/192] release_console_sem+0xb9/0xc0
Oct 15 14:47:44 bb2 kernel: [  288.394780]  [vprintk+404/576] vprintk+0x194/0x240
Oct 15 14:47:44 bb2 kernel: [  288.394835]  [vsprintf+40/48] vsprintf+0x28/0x30
Oct 15 14:47:44 bb2 kernel: [  288.394896]  [error_code+79/84] error_code+0x4f/0x54
Oct 15 14:47:44 bb2 kernel: [  288.394954]  [pg0+945935986/1069417472] reiserfs_panic+0x52/0x80 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.395025]  [pg0+945997604/1069417472] journal_mark_dirty+0x244/0x270 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.395100]  [memmove+80/84] memmove+0x50/0x54
Oct 15 14:47:44 bb2 kernel: [  288.395158]  [pg0+945939767/1069417472] reiserfs_get_unused_objectid+0x97/0x110 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.395231]  [pg0+945883059/1069417472] reiserfs_new_inode+0x143/0x740 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.395301]  [pg0+945858510/1069417472] search_by_entry_key+0xbe/0x210 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.395374]  [pg0+945859823/1069417472] reiserfs_find_entry+0xbf/0x140 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.395443]  [d_rehash+107/144] d_rehash+0x6b/0x90
Oct 15 14:47:44 bb2 kernel: [  288.395501]  [pg0+945862140/1069417472] reiserfs_create+0x9c/0x1b0 [reiserfs]
Oct 15 14:47:44 bb2 kernel: [  288.395570]  [permission+111/160] permission+0x6f/0xa0
Oct 15 14:47:44 bb2 kernel: [  288.395625]  [vfs_create+145/256] vfs_create+0x91/0x100
Oct 15 14:47:44 bb2 kernel: [  288.395681]  [open_namei+1507/1600] open_namei+0x5e3/0x640
Oct 15 14:47:44 bb2 kernel: [  288.395737]  [get_empty_filp+103/224] get_empty_filp+0x67/0xe0
Oct 15 14:47:44 bb2 kernel: [  288.395793]  [file_move+32/96] file_move+0x20/0x60
Oct 15 14:47:44 bb2 kernel: [  288.395847]  [filp_open+62/112] filp_open+0x3e/0x70
Oct 15 14:47:44 bb2 kernel: [  288.395905]  [get_unused_fd+162/208] get_unused_fd+0xa2/0xd0
Oct 15 14:47:44 bb2 kernel: [  288.395961]  [sys_open+79/224] sys_open+0x4f/0xe0
Oct 15 14:47:44 bb2 kernel: [  288.396016]  [syscall_call+7/11] syscall_call+0x7/0xb


--------------020900000409030106070608--
