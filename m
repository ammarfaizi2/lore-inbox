Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135377AbRBETH2>; Mon, 5 Feb 2001 14:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135493AbRBETHU>; Mon, 5 Feb 2001 14:07:20 -0500
Received: from mail.valinux.com ([198.186.202.175]:42257 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S135377AbRBETHD>;
	Mon, 5 Feb 2001 14:07:03 -0500
Message-ID: <3A7EF9CF.8C5EE1C@valinux.com>
Date: Mon, 05 Feb 2001 11:06:55 -0800
From: Samuel Flory <sflory@valinux.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre11-va1.7smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dirk Mueller <dmuell@gmx.net>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] NFS and reiserfs
In-Reply-To: <3A7E40D1.DBCC16E9@cpgen.cpg.com.au> <20010205124808.A18579@rotes20.wohnheim.uni-kl.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Mueller wrote:
> 
> On Mon, 05 Feb 2001, Grahame Jordan wrote:
> 
> > Should I convert all of my NFS filesystems to ext2 or is there another
> > option?
> 
> If you use kernel 2.4.x: there are patches for NFS support.
> 

  You can also try the rpms below.  They seem to work for me, but your
results may vary.  If you really want to be able to gracefully recover
you need to force sync on all of your exports.

http://ftp.valinux.com/pub/people/flory/2.4.1/


The patch is here:
ftp://ftp.namesys.com/pub/reiserfs-for-2.4/linux-2.4.0-reiserfs-3.6.25-nfs.diff

-- 
Solving people's computer problems always
requires more hardware be given to you.
(The Second Rule of Hardware Acquisition)
Samuel J. Flory  <sam@valinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
