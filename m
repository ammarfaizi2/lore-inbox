Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVJCI4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVJCI4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVJCI4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:56:53 -0400
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:54174
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932188AbVJCI4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:56:52 -0400
Subject: SOME PROBLEMS WITH 2.6.14-rc3 ( MAYBE REISERFS ?? )
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 03 Oct 2005 10:58:02 +0200
Message-Id: <1128329882.7359.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all of you !!

I have a Sony Vaio PCG-GRT816S laptop and I use Slackware 10.1 
on it. I tried to put on the linux 2.6.14-rc3 kernel and I 
gor that message in the logs:

localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981818 3981823 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981818 3981824 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981825 3981826 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981825 3981832 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980985 3981037 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980985 3980986 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980985 3980993 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980985 3981028 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980985 3981047 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980916 3980917 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980916 3980924 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980916 3980923 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980976 3980977 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980976 3980983 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980976 3980984 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980888 3980889 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980888 3980896 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980888 3980895 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980897 3980898 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980897 3980905 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980897 3980904 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980897 3980906 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980716 3980721 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980723 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980735 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980734 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980731 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980729 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980733 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980732 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980722 3980730 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980737 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980764 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980761 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980763 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980743 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980746 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980745 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980753 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980749 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980756 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980754 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980748 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980757 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980760 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980758 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980762 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980747 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980744 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980759 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980755 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980765 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980751 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980752 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980736 3980750 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980780 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980787 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980792 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980786 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980790 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980789 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980788 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980779 3980791 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980856 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980871 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980862 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980864 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980870 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980865 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980863 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980868 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980867 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980869 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980855 3980866 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980794 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980838 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980819 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980802 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980811 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980815 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980826 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980834 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980842 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980823 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980806 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980836 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980829 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980830 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980818 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980825 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980840 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980839 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980805 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980814 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980801 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980828 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980817 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980833 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980813 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980809 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980807 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980810 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980820 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980821 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980845 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980824 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980844 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980841 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980822 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980827 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980804 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980803 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980837 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980843 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980831 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980832 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980800 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980808 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980835 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980816 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980793 3980812 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980873 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980885 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980881 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980887 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980884 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980880 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980879 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980882 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980886 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980872 3980883 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980907 3980908 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980907 3980915 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980907 3980914 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980766 3980767 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980766 3980777 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980766 3980776 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980766 3980774 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980766 3980775 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980766 3980773 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980766 3980778 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980846 3980847 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980846 3980854 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980846 3980853 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980925 3980926 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980925 3980932 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3980925 3980975 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981402 3981403 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981402 3981409 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981402 3981419 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981402 3981428 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981402 3981437 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3981995 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3981996 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3981999 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3982000 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 27760 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120602. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3982003 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3982001 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3982002 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3981997 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 15732 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120601. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981978 3981998 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 29554 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 14811814. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981601 3981606 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 29554 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 14811814. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981637 3981638 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 29554 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 14811814. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981637 3981645 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 29554 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 14811814. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981637 3981684 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 29554 does
not match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 14811814. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981637 3981693 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981448 3981449 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981448 3981455 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981448 3981479 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981448 3981573 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 31497 does
not match to the expected one 2
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 16866112. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981448 3981488 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981818 3981823 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981818 3981824 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-5657: reiserfs_do_truncate:
i/o failure occurred trying to truncate [3981818 3981822
0xfffffffffffffff DIRECT]
localhost kernel ReiserFS: hda2: warning: clm-2100: nesting info a
different FS
localhost  last message repeated 3 times
localhost kernel ------------[ cut here ]------------
localhost kernel kernel BUG at fs/reiserfs/journal.c:3097!
localhost kernel invalid operand: 0000 [#1]
localhost kernel PREEMPT 
localhost kernel Modules linked in: vmnet parport_pc parport vmmon msr
capability commoncap cpufreq_conservative cpuid p4_clockmod
speedstep_lib microcode cpufreq_ondemand cpufreq_stats freq_table
cpufreq_powersave snd_pcm
localhost kernel CPU:    0
localhost kernel EIP:    0060:[<c01bc189>]    Tainted: P      VLI
localhost kernel EFLAGS: 00010246   (2.6.14-rc3) 
localhost kernel EIP is at journal_begin+0xd9/0xf0
localhost kernel eax: 00000000   ebx: f1607ecc   ecx: 00000012   edx:
f7f90000
localhost kernel esi: f1607f10   edi: f1606000   ebp: f7f90000   esp:
f1607e90
localhost kernel ds: 007b   es: 007b   ss: 0068
localhost kernel Process rm (pid: 30638, threadinfo=f1606000
task=d6925530)
localhost kernel Stack: 00000000 00000000 00000012 d4a3a6d0 d4a3a6d0
00000000 f1607ecc c01aaf2d 
localhost kernel 00000000 00000000 00000000 00000000 00000000 d000d000
00000f4c 00000000 
localhost kernel f8863000 f7f90000 f1607f10 f1607f10 00000000 00000024
f1607f68 c01bc4b9 
localhost kernel Call Trace:
localhost kernel [<c01aaf2d>] remove_save_link+0x2d/0xf0
localhost kernel [<c01bc4b9>] journal_end+0x89/0xe0
localhost kernel [<c019edc0>] reiserfs_delete_inode+0xf0/0x120
localhost kernel [<c01741f9>] d_delete+0x99/0x160
localhost kernel [<c019ecd0>] reiserfs_delete_inode+0x0/0x120
localhost kernel [<c0175ef4>] generic_delete_inode+0xb4/0x160
localhost kernel [<c0176173>] iput+0x53/0x70
localhost kernel [<c016be36>] sys_unlink+0xc6/0x120
localhost kernel [<c016e873>] sys_getdents64+0xb3/0xbd
localhost kernel [<c0103005>] syscall_call+0x7/0xb
localhost kernel Code: 2a 40 b9 09 00 00 00 89 df 89 46 04 f3 a5 83 7b
04 01 7e 04 31 c0 eb c9 89 2c 24 bf 60 c2 33 c0 89 7c 24 04 e8 59 24 ff
ff eb e9 <0f> 0b 19 0c 26 63 33 c0 eb cc 8d b6 00 00 00 00 8d bc 27 00
00 
localhost kernel Badness in do_exit at kernel/exit.c:799
localhost kernel [<c011d2d9>] do_exit+0x409/0x410
localhost kernel [<c0104248>] die+0x168/0x170
localhost kernel [<c01044b0>] do_invalid_op+0x0/0xc0
localhost kernel [<c010454f>] do_invalid_op+0x9f/0xc0
localhost kernel [<c01bc189>] journal_begin+0xd9/0xf0
localhost kernel [<c012e4c0>] autoremove_wake_function+0x0/0x50
localhost kernel [<c0103b37>] error_code+0x4f/0x54
localhost kernel [<c012007b>] insert_resource+0x8b/0x100
localhost kernel [<c01bc189>] journal_begin+0xd9/0xf0
localhost kernel [<c01aaf2d>] remove_save_link+0x2d/0xf0
localhost kernel [<c01bc4b9>] journal_end+0x89/0xe0
localhost kernel [<c019edc0>] reiserfs_delete_inode+0xf0/0x120
localhost kernel [<c01741f9>] d_delete+0x99/0x160
localhost kernel [<c019ecd0>] reiserfs_delete_inode+0x0/0x120
localhost kernel [<c0175ef4>] generic_delete_inode+0xb4/0x160
localhost kernel [<c0176173>] iput+0x53/0x70
localhost kernel [<c016be36>] sys_unlink+0xc6/0x120
localhost kernel [<c016e873>] sys_getdents64+0xb3/0xbd
localhost kernel [<c0103005>] syscall_call+0x7/0xb



================== 
Same thing is with the kernel 2.6.13.2

localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981818 3981823 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-13070:
reiserfs_read_locked_inode: i/o failure occurred trying to find stat
data of [3981818 3981824 0x0 SD]
localhost kernel ReiserFS: warning: is_tree_node: node level 0 does not
match to the expected one 1
localhost kernel ReiserFS: hda2: warning: vs-5150: search_by_key:
invalid format found in block 9120600. Fsck?
localhost kernel ReiserFS: hda2: warning: vs-5657: reiserfs_do_truncate:
i/o failure occurred trying to truncate [3981818 3981822
0xfffffffffffffff DIRECT]
localhost kernel ReiserFS: hda2: warning: clm-2100: nesting info a
different FS
localhost  last message repeated 3 times
localhost kernel ------------[ cut here ]------------
localhost kernel kernel BUG at fs/reiserfs/journal.c:3098!
localhost kernel invalid operand: 0000 [#1]
localhost kernel PREEMPT 
localhost kernel Modules linked in: msr capability commoncap
cpufreq_conservative cpuid p4_clockmod speedstep_lib microcode
cpufreq_ondemand cpufreq_stats freq_table cpufreq_powersave snd_pcm_oss
snd_mixer_oss ipv6 uhci_hc
localhost kernel CPU:    0
localhost kernel EIP:    0060:[<c01bafa9>]    Tainted: P      VLI
localhost kernel EFLAGS: 00210246   (2.6.13.2) 
localhost kernel EIP is at journal_begin+0xd9/0xf0
localhost kernel eax: 00000000   ebx: e7187ecc   ecx: 00000012   edx:
f7809000
localhost kernel esi: e7187f10   edi: e7186000   ebp: f7809000   esp:
e7187e90
localhost kernel ds: 007b   es: 007b   ss: 0068
localhost kernel Process rm (pid: 7083, threadinfo=e7186000
task=e76ed020)
localhost kernel Stack: 00000000 00000000 00000012 e7747e88 e7747e88
00000000 e7187ecc c01a9d3d 
localhost kernel 00000000 00000000 00000000 00000000 00000000 e7020000
00000f4c 00000000 
localhost kernel f8864000 f7809000 e7187f10 e7187f10 00000000 00000024
e7187f68 c01bb2d9 
localhost kernel Call Trace:
localhost kernel [<c01a9d3d>] remove_save_link+0x2d/0xf0
localhost kernel [<c01bb2d9>] journal_end+0x89/0xe0
localhost kernel [<c019db90>] reiserfs_delete_inode+0xe0/0x110
localhost kernel [<c0173589>] d_delete+0x99/0x150
localhost kernel [<c019dab0>] reiserfs_delete_inode+0x0/0x110
localhost kernel [<c0175274>] generic_delete_inode+0xc4/0x170
localhost kernel [<c01754f3>] iput+0x53/0x70
localhost kernel [<c016b1c6>] sys_unlink+0xc6/0x120
localhost kernel [<c016dcc3>] sys_getdents64+0xb3/0xbd
localhost kernel [<c0103075>] syscall_call+0x7/0xb
localhost kernel Code: 2a 40 b9 09 00 00 00 89 df 89 46 04 f3 a5 83 7b
04 01 7e 04 31 c0 eb c9 89 2c 24 bf a0 05 33 c0 89 7c 24 04 e8 49 24 ff
ff eb e9 <0f> 0b 1a 0c d8 a6 32 c0 eb cc 8d b6 00 00 00 00 8d bc 27 00
00 
localhost kernel Badness in do_exit at kernel/exit.c:787
localhost kernel [<c011d789>] do_exit+0x409/0x410
localhost kernel [<c0104338>] die+0x168/0x170
localhost kernel [<c01046a0>] do_invalid_op+0x0/0xc0
localhost kernel [<c010473f>] do_invalid_op+0x9f/0xc0
localhost kernel [<c01bafa9>] journal_begin+0xd9/0xf0
localhost kernel [<c012e990>] autoremove_wake_function+0x0/0x50
localhost kernel [<c0103b97>] error_code+0x4f/0x54
localhost kernel [<c012007b>] r_start+0x4b/0x90
localhost kernel [<c01bafa9>] journal_begin+0xd9/0xf0
localhost kernel [<c01a9d3d>] remove_save_link+0x2d/0xf0
localhost kernel [<c01bb2d9>] journal_end+0x89/0xe0
localhost kernel [<c019db90>] reiserfs_delete_inode+0xe0/0x110
localhost kernel [<c0173589>] d_delete+0x99/0x150
localhost kernel [<c019dab0>] reiserfs_delete_inode+0x0/0x110
localhost kernel [<c0175274>] generic_delete_inode+0xc4/0x170
localhost kernel [<c01754f3>] iput+0x53/0x70
localhost kernel [<c016b1c6>] sys_unlink+0xc6/0x120
localhost kernel [<c016dcc3>] sys_getdents64+0xb3/0xbd
localhost kernel [<c0103075>] syscall_call+0x7/0xb


Can somebody tell me where is this coming from ?
Please CC me as I'm not on the list.

Many many thanks in advance and best regards.
Sasa Ostrouska


