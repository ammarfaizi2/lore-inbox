Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262943AbRE1Di0>; Sun, 27 May 2001 23:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbRE1DiQ>; Sun, 27 May 2001 23:38:16 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:21213 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262943AbRE1DiJ>; Sun, 27 May 2001 23:38:09 -0400
Date: Sun, 27 May 2001 23:38:01 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac2
Message-ID: <20010527233801.A643@zero>
In-Reply-To: <20010528013342.A9840@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528013342.A9840@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Mon, May 28, 2001 at 01:33:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i haven't had any reiserfs crashes on my alpha, but restoring a backup of a
debian installation to a reiserfs partition doesn't quite work. untarring a
linux kernel tarball to the fs works, does work though. i get these kernel
messages:

May 27 23:28:47 zero kernel: is_leaf: free space seems wrong: level=1, nr_items=17, free_space=132 rdkey 
May 27 23:28:47 zero kernel: vs-5150: search_by_key: invalid format found in block 11693. Fsck?
May 27 23:28:47 zero kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1361 1362 0x0 SD]
May 27 23:28:47 zero kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (1361 1362) not found
May 27 23:28:47 zero last message repeated 2 times
May 27 23:28:48 zero kernel: is_leaf: free space seems wrong: level=1, nr_items=18, free_space=568 rdkey 
May 27 23:28:48 zero kernel: vs-5150: search_by_key: invalid format found in block 14392. Fsck?
May 27 23:28:48 zero kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [3215 3216 0x0 SD]
May 27 23:28:48 zero kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (3215 3216) not found
May 27 23:28:48 zero last message repeated 2 times
May 27 23:28:49 zero kernel: is_leaf: free space seems wrong: level=1, nr_items=18, free_space=568 rdkey 
May 27 23:28:49 zero kernel: vs-5150: search_by_key: invalid format found in block 14392. Fsck?
May 27 23:28:49 zero kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [3208 3210 0x0 SD]
May 27 23:28:49 zero kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (3208 3210) not found
May 27 23:28:49 zero last message repeated 2 times
May 27 23:28:49 zero kernel: is_leaf: free space seems wrong: level=1, nr_items=18, free_space=568 rdkey 
May 27 23:28:49 zero kernel: vs-5150: search_by_key: invalid format found in block 14392. Fsck?
May 27 23:28:49 zero kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [3208 3211 0x0 SD]
May 27 23:28:49 zero kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (3208 3211) not found
May 27 23:28:49 zero last message repeated 8 times

On Mon, May 28, 2001 at 01:33:42AM +0100, Alan Cox wrote:
> 2.4.5-ac2
> o	Restore lock_kernel on umount			(Al Viro)
> 	| Should cure Reiserfs crash in 2.4.5

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
