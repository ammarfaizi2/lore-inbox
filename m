Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTBEUCX>; Wed, 5 Feb 2003 15:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTBEUBt>; Wed, 5 Feb 2003 15:01:49 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:24031 "EHLO
	minerva") by vger.kernel.org with ESMTP id <S264756AbTBEUBb>;
	Wed, 5 Feb 2003 15:01:31 -0500
Date: Wed, 5 Feb 2003 14:11:04 -0600
From: Matt Reppert <arashi@yomerashi.yi.org>
To: Andrew Morton <akpm@digeo.com>
Cc: andrea@suse.de, lm@bitmover.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-Id: <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
In-Reply-To: <20030205114353.6591f4c8.akpm@digeo.com>
References: <20030205174021.GE19678@dualathlon.random>
	<20030205102308.68899bc3.akpm@digeo.com>
	<20030205184535.GG19678@dualathlon.random>
	<20030205114353.6591f4c8.akpm@digeo.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC'ing Linus because I have a question for him in here ... )
On Wed, 5 Feb 2003 11:43:53 -0800
Andrew Morton <akpm@digeo.com> wrote:
>
> http://linux.bkbits.net:8080/linux-2.5/cset@1.879.43.1?nav=index.html|ChangeSet@-8w
> 
> And revtool shows that change on Jan 09 this year.
> 
> But it does not appear in Linus's 2.5.59 tarball, and there appears to be no
> record in bitkeeper of where this change fell out of the tree.
> 
> In fact the above URL shows two instances of the same patch, with different
> human-written summaries, on the same day.
> 
> I believe that shaggy had some problem with the nobh stuff, so possibly the
> January 9 change was reverted in some manner, and it was reapplied
> post-2.5.59, and the web interface does now show the revert.  Revtool does
> not show it either.  Nor the reapply.
> 
> It is quite confusing.  Yes, something might have gone wrong.

I sit on the web interface a lot to see what's being merged. If you ask for
it, it will give you a list of csets ordered by date, newest first. I've
noticed sometimes that recently merged csets will appear to be older than
the date they were merged, perhaps because they actually were that old in
the parent repository. Is cset age preserved across repositories? It seems
to be.

If this is the case, then the cset was merged recently but the actual change
was done a long time ago. When did this get merged?

(BTW, Larry, the bk binaries segfault on my (glibc 2.3.1) i686 system. Any
chance we could see binaries linked against 2.3.x? There's NSS badness between
2.2 and 2.3 that causes even static binaries to segfault ... )

Thanks,
Matt
