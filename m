Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278213AbRJMAFv>; Fri, 12 Oct 2001 20:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278209AbRJMAFk>; Fri, 12 Oct 2001 20:05:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57046 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278212AbRJMAFa>;
	Fri, 12 Oct 2001 20:05:30 -0400
Date: Fri, 12 Oct 2001 20:06:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Signal9 <signal9@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in VFS ?
In-Reply-To: <01101301503101.00295@apocalipsis>
Message-ID: <Pine.GSO.4.21.0110122004080.76-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Signal9 wrote:

>                root = current->fs->rootmnt;
>                list_for_each(ptr, &root->mnt_list) {
>                         mnt = list_entry(ptr, struct vfsmount, mnt_list);
>                         sb = mnt ? mnt->mnt_sb : NULL;
>                          if (NULL != sb && dev == sb->s_dev) <============
>                                         mntget(mnt);
>                 }

	What the hell is it trying to do?

