Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSGOQJY>; Mon, 15 Jul 2002 12:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317511AbSGOQJX>; Mon, 15 Jul 2002 12:09:23 -0400
Received: from dsl-213-023-043-211.arcor-ip.net ([213.23.43.211]:40094 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317508AbSGOQJV>;
	Mon, 15 Jul 2002 12:09:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>, Sam Vilain <sam@vilain.net>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Date: Mon, 15 Jul 2002 18:12:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dax@gurulabs.com,
       linux-kernel@vger.kernel.org
References: <1026490866.5316.41.camel@thud> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com>
In-Reply-To: <20020715160357.GD442@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17U8Sx-0003bp-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 July 2002 18:03, Andreas Dilger wrote:
> On Jul 15, 2002  13:02 +0100, Sam Vilain wrote:
> >    "Yes, we know that there is no directory hashing in ext2/3.  You'll
> > have to find another solution to the problem, I'm afraid.  Why not ease
> > the burden on the filesystem by breaking up the task for it, and giving
> > it to it in small pieces.  That way it's much less likely to choke."
> 
> Amusingly, there IS directory hashing available for ext2 and ext3, and
> it is just as fast as reiserfs hashed directories.  See:
> 
>    http://people.nl.linux.org/~phillips/htree/paper/htree.html

Faster, last time I checked.  I really must test against XFS and JFS at
some point.

-- 
Daniel
