Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129540AbRAaWzV>; Wed, 31 Jan 2001 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbRAaWzL>; Wed, 31 Jan 2001 17:55:11 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:63571 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129541AbRAaWy7>; Wed, 31 Jan 2001 17:54:59 -0500
Date: Thu, 1 Feb 2001 01:01:47 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Vanilla 2.4.0 et2fs errors
Message-ID: <Pine.LNX.4.21.0102010100530.11152-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Can someone 'translate' this for me ?


Jan 31 18:01:57 base kernel: EXT2-fs error (device ide0(3,71)):
ext2_new_inode:
reserved inode or inode > inodes count - block_group = 0,inode=1

It's reproducable, but doesn't seem to give any problems. It happens when
on a (almost) empty FS an links is attempted to a directory that doesn't
exist at that point.

I'll try 2.4.1 when I get back and see what that does..


        Regards,


		Igmar



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
