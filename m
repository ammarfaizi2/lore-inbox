Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWECO4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWECO4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWECO4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:56:11 -0400
Received: from mail.priv.de ([80.237.225.190]:30894 "EHLO mail.priv.de")
	by vger.kernel.org with ESMTP id S965114AbWECO4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:56:09 -0400
Message-ID: <4458C48B.8040703@priv.de>
Date: Wed, 03 May 2006 16:56:11 +0200
From: =?ISO-8859-15?Q?Markus_M=FCller?= <mm@priv.de>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiserfsck dies
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux kernel users,

reiserfsck told me that I have to run --rebuild-tree to fix all errors. 
But this don't work (see below), I tried two times (every time I am 
waiting 28 hours). If I mount the filesystem, there are no files in it. 
What can I do?

Regards,
Markus Mueller

stacker:/# reiserfsck --rebuild-tree /dev/mapper/hdb
reiserfsck 3.6.19 (2003 www.namesys.com)

*************************************************************
** Do not  run  the  program  with  --rebuild-tree  unless **
** something is broken and MAKE A BACKUP  before using it. **
** If you have bad sectors on a drive  it is usually a bad **
** idea to continue using it. Then you probably should get **
** a working hard drive, copy the file system from the bad **
** drive  to the good one -- dd_rescue is  a good tool for **
** that -- and only then run this program.                 **
** If you are using the latest reiserfsprogs and  it fails **
** please  email bug reports to reiserfs-list@namesys.com, **
** providing  as  much  information  as  possible --  your **
** hardware,  kernel,  patches,  settings,  all reiserfsck **
** messages  (including version),  the reiserfsck logfile, **
** check  the  syslog file  for  any  related information. **
** If you would like advice on using this program, support **
** is available  for $25 at  www.namesys.com/support.html. **
*************************************************************

Will rebuild the filesystem (/dev/mapper/hdb) tree
Will put log info to 'stdout'

Do you want to run this program?[N/Yes] (note need to type Yes if you 
do):Yes
Replaying journal..
Reiserfs journal '/dev/mapper/hdb' in blocks [18..8211]: 0 transactions 
replayed
###########
reiserfsck --rebuild-tree started at Fri Jun  2 02:33:33 2006
###########

Pass 0:
####### Pass 0 #######
Loading on-disk bitmap .. ok, 374936503 blocks marked used
Skipping 24903 blocks (super block, journal, bitmaps) 374911600 blocks 
will be read
0%.block 36965006: The number of items (240) is incorrect, should be (1) 
- corrected
block 36965006: The free space (0) is incorrect, should be (4048) - 
corrected
pass0: vpf-10110: block 36965006, item (0): Unknown item type found [1 0 
0x0 ??? (15)] - deleted
.block 101598748: The number of items (12544) is incorrect, should be 
(1) - corrected
block 101598748: The free space (40960) is incorrect, should be (704) - 
corrected
pass0: vpf-10110: block 101598748, item (0): Unknown item type found 
[917675 1056806 0xebd0021 ??? (15)] - deleted
block 172644234: The number of items (4097) is incorrect, should be (1) 
- corrected
block 172644234: The free space (3840) is incorrect, should be (4048) - 
corrected
pass0: vpf-10110: block 172644234, item (0): Unknown item type found [0 
0 0xf0ff0ff0 ??? (15)] - deleted
block 172648064: The number of items (240) is incorrect, should be (1) - 
corrected
block 172648064: The free space (0) is incorrect, should be (4048) - 
corrected
pass0: vpf-10150: block 172648064: item 0: Wrong key [0 0 0x0 SD (0)], 
deleted
block 172652044: The number of items (15) is incorrect, should be (1) - 
corrected
block 172652044: The free space (3841) is incorrect, should be (3792) - 
corrected
pass0: vpf-10110: block 172652044, item (0): Unknown item type found 
[268496927 251658751 0xff000001 ??? (15)] - deleted
block 172654432: The number of items (3855) is incorrect, should be (1) 
- corrected
block 172654432: The free space (256) is incorrect, should be (208) - 
corrected
pass0: vpf-10110: block 172654432, item (0): Unknown item type found 
[1048832 2162703 0xf1000 ??? (15)] - deleted
block 172657842: The number of items (4096) is incorrect, should be (1) 
- corrected
block 172657842: The free space (31) is incorrect, should be (4048) - 
corrected
pass0: vpf-10110: block 172657842, item (0): Unknown item type found 
[4024499983 4027514623 0xf0f000ff ??? (15)] - deleted
block 325924258: The number of items (54578) is incorrect, should be (1) 
- corrected
block 325924258: The free space (216) is incorrect, should be (4048) - 
corrected
pass0: vpf-10150: block 325924258: item 0: Wrong key [16794639 0 
0xdc000000 SD (0)], deleted
block 325924971: The number of items (16770) is incorrect, should be (1) 
- corrected
block 325924971: The free space (174) is incorrect, should be (4048) - 
corrected
pass0: block 325924971, item 0: StatData item of wrong length found 
16805903 150994944 0x0 SD (0), len 0, location 4096 entry count 0, fsck 
need 0, format new - deleted
block 325926052: The number of items (29944) is incorrect, should be (1) 
- corrected
block 325926052: The free space (114) is incorrect, should be (4048) - 
corrected
pass0: vpf-10110: block 325926052, item (0): Unknown item type found 
[16813583 150994944 0x43e30838 ??? (15)] - deleted
                                                          left 0, 4825 
/seccc
985944 directory entries were hashed with "r5" hash.
        "r5" hash is selected
Flushing..finished
        Read blocks (but not data blocks) 374911600
                Leaves among those 423145
                        - leaves all contents of which could not be 
saved and deleted 14
                Objectids found 985866

Pass 1 (will try to insert 423131 leaves):
####### Pass 1 #######
Looking for allocable blocks .. Killed
stacker:/# reiserfsck --check /dev/mapper/hdb
reiserfsck 3.6.19 (2003 www.namesys.com)

*************************************************************
** If you are using the latest reiserfsprogs and  it fails **
** please  email bug reports to reiserfs-list@namesys.com, **
** providing  as  much  information  as  possible --  your **
** hardware,  kernel,  patches,  settings,  all reiserfsck **
** messages  (including version),  the reiserfsck logfile, **
** check  the  syslog file  for  any  related information. **
** If you would like advice on using this program, support **
** is available  for $25 at  www.namesys.com/support.html. **
*************************************************************

Will read-only check consistency of the filesystem on /dev/mapper/hdb
Will put log info to 'stdout'

Do you want to run this program?[N/Yes] (note need to type Yes if you 
do):Yes
###########
reiserfsck --check started at Sat Jun  3 00:44:08 2006
###########
Replaying journal..
Reiserfs journal '/dev/mapper/hdb' in blocks [18..8211]: 0 transactions 
replayed
Checking internal tree..

Bad root block 0. (--rebuild-tree did not complete)

Aborted
stacker:/# dmesg
oop0: warning: vs-5150: search_by_key: invalid format found in block 
1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504110 455902 0x0 SD]
ReiserFS: warning: is_tree_node: node level 27232 does not match to the 
expected one 1
ReiserFS: loop0: warning: vs-5150: search_by_key: invalid format found 
in block 1770409. Fsck?
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [504077 527729 0x0 SD]
oom-killer: gfp_mask=0x280d2, order=0
 [<c014c20e>] out_of_memory+0x14e/0x180
 [<c014e43e>] __alloc_pages+0x27e/0x2f0
 [<c0156c99>] __handle_mm_fault+0x769/0x8b0
 [<c046d6f2>] kfree_skbmem+0x42/0xa0
 [<c0471032>] net_tx_action+0x52/0x130
 [<c01198d7>] do_page_fault+0x137/0x642
 [<c01197a0>] do_page_fault+0x0/0x642
 [<c0103ca7>] error_code+0x4f/0x54
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 186, batch 31 used:32
cpu 0 cold: high 62, batch 15 used:54
HighMem per-cpu: empty
Free pages:        4824kB (0kB HighMem)
Active:112618 inactive:8677 dirty:0 writeback:0 unstable:0 free:1206 
slab:2600 mapped:111185 pagetables:161
DMA free:2068kB min:88kB low:108kB high:132kB active:7976kB inactive:0kB 
present:16384kB pages_scanned:6458300 all_unreclaimable? yes
lowmem_reserve[]: 0 0 495 495
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 495 495
Normal free:2756kB min:2804kB low:3504kB high:4204kB active:442496kB 
inactive:34708kB present:507840kB pages_scanned:551906 
all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
1*2048kB 0*4096kB = 2068kB
DMA32: empty
Normal: 1*4kB 6*8kB 3*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 
0*1024kB 1*2048kB 0*4096kB = 2756kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
131056 pages of RAM
0 pages of HIGHMEM
2989 reserved pages
213 pages shared
0 pages swap cached
0 pages dirty
0 pages writeback
111185 pages mapped
2600 pages slab
161 pages pagetables
Out of Memory: Kill process 1337 (bash) score 1243 and children.
Out of memory: Killed process 5622 (reiserfsck).
stacker:/# cat /proc/meminfo
MemTotal:       512716 kB
MemFree:        413660 kB
Buffers:         20268 kB
Cached:          47324 kB
SwapCached:          0 kB
Active:          19500 kB
Inactive:        56656 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       512716 kB
LowFree:        413660 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:          10912 kB
Slab:            10868 kB
CommitLimit:    256356 kB
Committed_AS:    77484 kB
PageTables:        212 kB
VmallocTotal:   515796 kB
VmallocUsed:      1528 kB
VmallocChunk:   514248 kB
stacker:/#

