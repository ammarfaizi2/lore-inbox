Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136532AbRD3XXO>; Mon, 30 Apr 2001 19:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136545AbRD3XXF>; Mon, 30 Apr 2001 19:23:05 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:7174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136532AbRD3XWv>; Mon, 30 Apr 2001 19:22:51 -0400
Date: Mon, 30 Apr 2001 16:22:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@suse.cz>, <viro@math.psu.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] linux likes to kill bad inodes
In-Reply-To: <E14uM9r-0000Wn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0104301621450.20533-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Apr 2001, Alan Cox wrote:
>
> Any reason a bad inode can't have its i_sb changed to a bad_inode_fs ?

That would be my personal preference too, this was just the quick hack
version.

Changing superblocks might have other consequences (like getting the
superblock inode lists right etc).

		Linus

