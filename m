Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTBEUGf>; Wed, 5 Feb 2003 15:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBEUGe>; Wed, 5 Feb 2003 15:06:34 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:16412 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264748AbTBEUGc>; Wed, 5 Feb 2003 15:06:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Date: Wed, 5 Feb 2003 14:16:01 -0600
User-Agent: KMail/1.4.3
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random> <200302051404.21524.shaggy@austin.ibm.com> <20030205201055.GL19678@dualathlon.random>
In-Reply-To: <20030205201055.GL19678@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302051416.01543.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 February 2003 14:10, Andrea Arcangeli wrote:
> On Wed, Feb 05, 2003 at 02:04:21PM -0600, Dave Kleikamp wrote:
> > The change from block_truncate_page to nobh_truncate_page was done
> > in Changeset 1.879.43.1.  This was created on January 9th, but not
> > merged into Linus' tree until Monday, so it is not in 2.5.59.  I
> > think the
>
> if you think it's normal the thing sounds very messy. I mean, how can
> a changeset be numbered 1.879.43.1 and not be included in 2.5.59?
>
> The way I understood it is that when Linus merges "stuff", this
> "stuff" gets a changeset number in the future, not in the past. No
> matter if the "stuff" was created in the past. Is this the case or
> not?

I don't understand the changeset numbering myself, so I guess Larry will 
have to answer this one.

> I mean, somehow there must be a way to number the changesets so that
> applying them in order generates something coherent.
>
> Andrea

-- 
David Kleikamp
IBM Linux Technology Center

