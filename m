Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310187AbSCPJDG>; Sat, 16 Mar 2002 04:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310186AbSCPJCt>; Sat, 16 Mar 2002 04:02:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48052 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310178AbSCPJCg>;
	Sat, 16 Mar 2002 04:02:36 -0500
Date: Sat, 16 Mar 2002 04:02:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Allen <allenp@nwlink.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
In-Reply-To: <3C93012F.9080601@nwlink.com>
Message-ID: <Pine.GSO.4.21.0203160354130.4093-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Paul Allen wrote:

> While helping a friend recover from a catastrophic "rm -rf" accident,
> I discovered that deleted files have the inode number in their old
> directory entries zeroed.  This makes it impossible to match file
> names with recovered files.  I've verified this behavior on Mandrake
> 8.1 with Mandrake's stock 2.4.8 kernel.  In my kernel sources and
> in the stock 2.4.8 sources, the function ext2_delete_entry() in
> fs/ext2/dir.c has this line:
> 
> 	dir->inode = 0;
> 
> I've done some searching with Google for discussion of this feature.

Try "A Fast Filesystem for UNIX(tm)", by McKusick et.al.

