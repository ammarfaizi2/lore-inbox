Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTBEUCY>; Wed, 5 Feb 2003 15:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTBEUBn>; Wed, 5 Feb 2003 15:01:43 -0500
Received: from [195.223.140.107] ([195.223.140.107]:23168 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264797AbTBEUBf>;
	Wed, 5 Feb 2003 15:01:35 -0500
Date: Wed, 5 Feb 2003 21:10:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205201055.GL19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <200302051404.21524.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302051404.21524.shaggy@austin.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 02:04:21PM -0600, Dave Kleikamp wrote:
> On Wednesday 05 February 2003 11:40, Andrea Arcangeli wrote:
> > I'd appreciate if you could check why bitkeeper thinks such function
> > is nobh_truncate_page and not block_truncate_page as my GPL software
> > pretends while it checkouts all the changesets from the bitkeeper
> > servers.
> 
> Andrea,
> The change from block_truncate_page to nobh_truncate_page was done in 
> Changeset 1.879.43.1.  This was created on January 9th, but not merged 
> into Linus' tree until Monday, so it is not in 2.5.59.  I think the 

if you think it's normal the thing sounds very messy. I mean, how can
a changeset be numbered 1.879.43.1 and not be included in 2.5.59?

The way I understood it is that when Linus merges "stuff", this "stuff"
gets a changeset number in the future, not in the past. No matter if the
"stuff" was created in the past. Is this the case or not?

I mean, somehow there must be a way to number the changesets so that
applying them in order generates something coherent.

Andrea
