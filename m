Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTBET5N>; Wed, 5 Feb 2003 14:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTBET5N>; Wed, 5 Feb 2003 14:57:13 -0500
Received: from [195.223.140.107] ([195.223.140.107]:22144 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264654AbTBET5L>;
	Wed, 5 Feb 2003 14:57:11 -0500
Date: Wed, 5 Feb 2003 21:06:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205200631.GK19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205194257.GA17922@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205194257.GA17922@codemonkey.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 07:42:57PM +0000, Dave Jones wrote:
> On Wed, Feb 05, 2003 at 07:45:35PM +0100, Andrea Arcangeli wrote:
> 
>  > I can't yet fetch a full tree out of bitkepper yet (you know the network
>  > protocol must be reverse engeneered first), I can only fetch
>  > incrementals with metadata and raw patch so far because this is the
>  > thing I care about most, after I've all the changesets in live form in
>  > my db I don't mind too much about the ability to checkout a the whole
>  > tree too, since I can do the same starting from my open db rather than
>  > using the proprietary one.
> 
> Why not save effort, and just grab from http://ftp.kernel.org/pub/linux/kernel/v2.5/testing/cset/

I used them so far, but they're as useless as the patches mailing list
for my purposes, first they're not useful to checkout a tree, the order of
the changesets I mean, and they don't tell when a certain kernel revision
matches a changeset, I'm checking out Linus's tree with it, they don't
provide live metadata easy to browse in software, to monitor in
background automatically, I need to see all the evolution of a certain
file or subsystem with all the metadata and raw patches with a few lines
of python, and last but not the least I like it to run in real time w/o
delays.

In short I'm extracting the whole database and I'm storing it in an open
form so I can manipulate it as I need. I don't watch branches, I only
fetch the main branch.

This makes very trivial also to checkin the whole thing into another
version control system and to keep it uptodate in background even if
this isn't my purpose.

I don't think it's worthwhile to do more than that on the bk side, I
mean, it's not an openbitkepper thing, I would rather write something
from scratch rather than reverse engeneering the whole thing just to
provide compatibility, once you've all the info in open form, you can
use it as a transient format that allows you to fill it into any other
project.

What matters to me is only the info and the easiest way to manipulate it
in software, it's much more powerful than what bitkeeper can do this way
because I program it, downside is that I need some more disk space ;).

Andrea
