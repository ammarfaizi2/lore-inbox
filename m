Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280782AbRKSXwb>; Mon, 19 Nov 2001 18:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280777AbRKSXwV>; Mon, 19 Nov 2001 18:52:21 -0500
Received: from peace.netnation.com ([204.174.223.2]:31155 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S280779AbRKSXwP>; Mon, 19 Nov 2001 18:52:15 -0500
Date: Mon, 19 Nov 2001 15:52:14 -0800
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011119155214.A2418@netnation.com>
In-Reply-To: <20011119152745.A27716@netnation.com> <Pine.LNX.4.33.0111191537450.19585-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.33.0111191537450.19585-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 19, 2001 at 03:38:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 03:38:45PM -0800, Linus Torvalds wrote:

> On Mon, 19 Nov 2001, Simon Kirby wrote:
> >
> > Well, I found out what file has the bog-standard page.
> >
> > open("/home/stevendi//.htaccess", O_RDONLY|O_LARGEFILE) = 4
> 
> What filesystem is this?

EXT2.

tune2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          31cd0726-a6c1-458b-905e-983df0f7c695
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              3623040
Block count:              7245307
Reserved block count:     362265
Free blocks:              1278488
Free inodes:              2748224
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16320
Inode blocks per group:   510
Last mount time:          Tue Nov 13 13:07:22 2001
Last write time:          Mon Nov 19 15:51:24 2001
Mount count:              1
Maximum mount count:      20
Last checked:             Tue Nov 13 13:07:21 2001
Check interval:           15552000 (6 months)
Next check after:         Sun May 12 14:07:21 2002
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
