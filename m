Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVAXJHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVAXJHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 04:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVAXJHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 04:07:34 -0500
Received: from levante.wiggy.net ([195.85.225.139]:27275 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261306AbVAXJHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 04:07:17 -0500
Date: Mon, 24 Jan 2005 10:07:12 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
Message-ID: <20050124090710.GB27675@wiggy.net>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel@vger.kernel.org
References: <20050121141106.GG7147@wiggy.net> <20050122212328.GC11170@pclin040.win.tue.nl> <20050123225628.GA27675@wiggy.net> <20050123232649.GA24723@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123232649.GA24723@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andries Brouwer wrote:
> It is an interesting situation, but probably there is not enough
> information to find out what happened. On the other hand, if your
> dumpe2fs output is not too big you might as well post it.

It is indeed not too big, so here it is:

Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          33476a1a-cc34-4668-a4a3-fd0efaa01818
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              132480
Block count:              264960
Reserved block count:     13248
Free blocks:              268779
Free inodes:              129353
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         14720
Inode blocks per group:   460
Last mount time:          Wed Jan 19 16:38:17 2005
Last write time:          Wed Jan 19 16:38:17 2005
Mount count:              8
Maximum mount count:      20
Last checked:             Wed Aug 25 16:32:54 2004
Check interval:           15552000 (6 months)
Next check after:         Mon Feb 21 15:32:54 2005
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128
Journal inode:            8
Journal backup:           inode blocks


Group 0: (Blocks 0-32767)
  Primary superblock at 0, Group descriptors at 1-1
  Block bitmap at 464 (+464), Inode bitmap at 465 (+465)
  Inode table at 4-463 (+4)
  24101 free blocks, 14708 free inodes, 1 directories
  Free blocks: 3, 8667-20480, 20482-32767
  Free inodes: 11, 13, 15-14720
Group 1: (Blocks 32768-65535)
  Backup superblock at 32768, Group descriptors at 32769-32769
  Block bitmap at 33264 (+496), Inode bitmap at 33265 (+497)
  Inode table at 32772-33231 (+4)
  32303 free blocks, 14719 free inodes, 1 directories
  Free blocks: 32770-32771, 33232-33263, 33266-55295, 55297-65535
  Free inodes: 14722-29440
Group 2: (Blocks 65536-98303)
  Block bitmap at 66064 (+528), Inode bitmap at 66065 (+529)
  Inode table at 65540-65999 (+4)
  34308 free blocks, 14720 free inodes, 0 directories
  Free blocks: 65536-65539, 66000-66063, 66066-98303
  Free inodes: 29441-44160
Group 3: (Blocks 98304-131071)
  Backup superblock at 98304, Group descriptors at 98305-98305
  Block bitmap at 98864 (+560), Inode bitmap at 98865 (+561)
  Inode table at 98308-98767 (+4)
  32303 free blocks, 14718 free inodes, 1 directories
  Free blocks: 98306-98307, 98768-98863, 98866-129023, 129025-131071
  Free inodes: 44162-44163, 44165-58880
Group 4: (Blocks 131072-163839)
  Block bitmap at 131664 (+592), Inode bitmap at 131665 (+593)
  Inode table at 131076-131535 (+4)
  32305 free blocks, 14719 free inodes, 1 directories
  Free blocks: 131073-131075, 131536-131663, 131666-163839
  Free inodes: 58882-73600
Group 5: (Blocks 163840-196607)
  Backup superblock at 163840, Group descriptors at 163841-163841
  Block bitmap at 164464 (+624), Inode bitmap at 164465 (+625)
  Inode table at 163844-164303 (+4)
  32304 free blocks, 14720 free inodes, 0 directories
  Free blocks: 163842-163843, 164304-164463, 164466-196607
  Free inodes: 73601-88320
Group 6: (Blocks 196608-229375)
  Block bitmap at 197264 (+656), Inode bitmap at 197265 (+657)
  Inode table at 196612-197071 (+4)
  45805 free blocks, 14720 free inodes, 0 directories
  Free blocks: 196608-196611, 197072-197263, 197266-229375
  Free inodes: 88321-103040
Group 7: (Blocks 229376-262143)
  Backup superblock at 229376, Group descriptors at 229377-229377
  Block bitmap at 230064 (+688), Inode bitmap at 230065 (+689)
  Inode table at 229380-229839 (+4)
  32304 free blocks, 14720 free inodes, 0 directories
  Free blocks: 229378-229379, 229840-230063, 230066-262143
  Free inodes: 103041-117760
Group 8: (Blocks 262144-264959)
  Block bitmap at 262864 (+720), Inode bitmap at 262865 (+721)
  Inode table at 262148-262607 (+4)
  14741 free blocks, 14720 free inodes, 0 directories
  Free blocks: 262144-262147, 262608-262863, 262866-264959
  Free inodes: 117761-132480
-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
