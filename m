Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261913AbREXN1r>; Thu, 24 May 2001 09:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261925AbREXN1h>; Thu, 24 May 2001 09:27:37 -0400
Received: from www.wen-online.de ([212.223.88.39]:50952 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261913AbREXN1Z>;
	Thu, 24 May 2001 09:27:25 -0400
Date: Thu, 24 May 2001 15:27:10 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Maciek Nowacki <maciek@Voyager.powersurfr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <Pine.GSO.4.21.0105240724000.21818-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0105241524290.824-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Alexander Viro wrote:

> On Thu, 24 May 2001, Mike Galbraith wrote:
>
> > On Thu, 24 May 2001, Alexander Viro wrote:
> >
> > > On Thu, 24 May 2001, Mike Galbraith wrote:
> > >
> > > > On Wed, 23 May 2001, Alexander Viro wrote:
> > > >
> > > > > Folks, who the hell is responsible for rd_inodes[] idiocy?
> > > >
> > > > That would have been me.  It was simple and needed at the time..
> > > > feel free to rip it up :)
> > >
> > > Mike, I see what you are using it for, but you do realize that it
> > > means that creating /tmp/ram0 and opening it once will make /tmp
> > > impossible to unmount?
> >
> > I don't _think_ that was the case at the time I did it.  I tested
> > the idio^Wbandaid before submission.. mighta fscked up though :)
>
> Erm... You pin the inode down. That makes filesystem busy by any
> definition I can think of...

Yes. I pulled the pins when I was done with them though.
(at least I think I did.. been a long time)

	-Mike

