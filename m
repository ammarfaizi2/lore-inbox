Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSBMPzv>; Wed, 13 Feb 2002 10:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287306AbSBMPzl>; Wed, 13 Feb 2002 10:55:41 -0500
Received: from rj.SGI.COM ([204.94.215.100]:32170 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S287388AbSBMPze>;
	Wed, 13 Feb 2002 10:55:34 -0500
Subject: Re: ANNOUNCEMENT: XFS patches with rmap12e + 2.4.18-pre9
From: Steve Lord <lord@sgi.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1013499333.3572.8.camel@coredump>
In-Reply-To: <Pine.LNX.4.40.0202110133010.5068-100000@coredump.sh0n.net> 
	<1013499333.3572.8.camel@coredump>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 13 Feb 2002 09:54:03 -0600
Message-Id: <1013615643.5428.26.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-12 at 01:35, Shawn Starr wrote:
> Some of you may experience compile problems with quota with XFS. I'm
> working on a patch to be ready for today.
> 
> NOTE: Two people have reported problems with XFS + EXT3/EXT2. People
> report the kernel unable to locate superblocks of EXT2/EXT3 filesystems
> with XFS compiled in. Looking for help on this issue and researching. 
> 
> I'll be also intregrating 2.4.18-pre9-ac1 as well today.

I run mixed ext3 and xfs systems from the current xfs cvs tree.
We also have 2.4.18-pre9 (not ac1) running internally. As for
the superblock issue, you should check if they are allowing mount
to auto determine the filesystem type or not, this would maybe
point to stale data in the block device interface.

Just a guess.

Steve


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
