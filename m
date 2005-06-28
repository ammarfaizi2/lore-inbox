Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVF1EYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVF1EYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVF1EYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:24:07 -0400
Received: from atpro.com ([12.161.0.3]:61196 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262521AbVF1EXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:23:55 -0400
Date: Tue, 28 Jun 2005 00:19:49 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Prakash Punnoor <lists@punnoor.de>
Cc: Steve Lord <lord@xfs.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050628041949.GE24548@mail>
Mail-Followup-To: Prakash Punnoor <lists@punnoor.de>,
	Steve Lord <lord@xfs.org>, Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	David Masover <ninja@slaphack.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <42C05F16.5000804@xfs.org> <20050627202841.GA27805@thunk.org> <42C06873.7020102@xfs.org> <42C0868E.4080003@punnoor.de> <20050628010728.GC24548@mail> <42C0CC0D.9040103@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C0CC0D.9040103@punnoor.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/05 06:03:25AM +0200, Prakash Punnoor wrote:
> Jim Crilly schrieb:
> > On 06/28/05 01:06:54AM +0200, Prakash Punnoor wrote:
> > 
> >>So I gave ext3 a try. Very robust, but at the same time slooow. I couldn't
> >>bear it after some months. So I gave xfs another try. Yes, now it felt much
> >>better. Still not that fast as reiserfs, IIRC, but better than the first time
> >>I tried. I am still having xfs on / and it works pretty well, and is rather
> >>robust against hard locks with about the same amount of data losing as
> >>reiserfs. But what annoys me very much, is that I have to run xfs_repair by
> >>hand and by booting from another partition. Even after a hard lock, the
> >>partition mounts w/o problems and everything seems OK, but it only seems like
> >>that. In fact after some hours/days of use, you'll notice oddities, like files
> >>or directories which cannot be removed and things like that. After running
> >>xfs_repair everything is back in order.
> > 
> > 
> > I don't know what was going on with your systems, but I've been using XFS
> > since the original 1.0 Linux release from SGI and I'd guess that I've had to run
> > xfs_repair less than 10 times and most of them were on Alpha and Sparc64
> > before issues with those arches got ironed out.
> 
> Perhaps it is due to the fact that I use xfs on software RAID-0 and both HDs
> have 8MB cache write-back enabled? So, all in all 16MB needs to be commited
> on/before lock-up, maybe too much for xfs? (This situation was no prob for
> ext3, though. Thinking again, I never used reiser V3 or V4 on the RAID-0, so
> my comparison might not have been fair.)

Maybe, I've never used XFS on software RAID-0. The Sparc64 I mentioned has
it's XFS filesystem on software RAID-1 and that's introduced no problems, but 
I've seen way too many drives die to risk running RAID-0.

> 
> Prakash

Jim.
