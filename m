Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSD2N7K>; Mon, 29 Apr 2002 09:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSD2N7J>; Mon, 29 Apr 2002 09:59:09 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:9179 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S312253AbSD2N7I>;
	Mon, 29 Apr 2002 09:59:08 -0400
Date: Mon, 29 Apr 2002 15:58:56 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204291358.PAA21654@harpo.it.uu.se>
To: viro@math.psu.edu
Subject: 2.5.11 busy inodes after unmount
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the 2.5.11 kernel I always get the "VFS: Busy inodes
after unmount. Self-destruct in 5 seconds.  Have a nice day..."
message from fs/super.c when shutting down. Rebooting with my
rescue floppy, fsck complains a lot about "Deleted inode with
zero dtime", "Block bitmap differences", "Free blocks count wrong",
"Inode bitmap differences", "Free inodes count wrong", and
"Directories count wrong". Luckily no files seemed to get trashed.

Very plain but solid box: x86, Intel chipset, IDE, ext2.

/Mikael
