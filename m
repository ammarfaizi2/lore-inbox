Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTLNOed (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 09:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTLNOed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 09:34:33 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27664 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261953AbTLNOec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 09:34:32 -0500
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
       <linux-kernel@vger.kernel.org>
Subject: Re: FAT fs sanity check patch
References: <Pine.LNX.4.44.0312132122020.6211-100000@gaia.cela.pl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 14 Dec 2003 23:33:40 +0900
In-Reply-To: <Pine.LNX.4.44.0312132122020.6211-100000@gaia.cela.pl>
Message-ID: <87ad5vfozf.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski <maze@cela.pl> writes:

> > Bad hack? Why? Do you know how mount operation is dangerous and it's
> > difficult for fatfs? Do you want to handle the any format as FAT?
> > 
> > This is completely unrelated to handling the cache.
> 
> How about not playing around with fat detection and instead implement a 
> force mount flag for FAT, which would ignore all (most?) detection errors.  
> Of course if errors occured later you'd end up with a R/O filesystem.  And if 
> you forced something that wasn't FAT, you'd be screwed... but that's to be 
> expected...

Yes, this flag would be one of candidates... However the scandisk/chkdisk
of windows fixed this bad format. Such a fsck may be best solution, I think.

Well, since the number of blacklists is three, I would like to wait
the more report before doing anything.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
