Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTBEUZN>; Wed, 5 Feb 2003 15:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTBEUZN>; Wed, 5 Feb 2003 15:25:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:3856 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264838AbTBEUZL>;
	Wed, 5 Feb 2003 15:25:11 -0500
Date: Wed, 5 Feb 2003 21:34:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205203445.GA4467@mars.ravnborg.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Dave Kleikamp <shaggy@austin.ibm.com>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random> <200302051404.21524.shaggy@austin.ibm.com> <20030205201055.GL19678@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205201055.GL19678@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 09:10:55PM +0100, Andrea Arcangeli wrote:
> > Andrea,
> > The change from block_truncate_page to nobh_truncate_page was done in 
> > Changeset 1.879.43.1.  This was created on January 9th, but not merged 
> > into Linus' tree until Monday, so it is not in 2.5.59.  I think the 
> 
> if you think it's normal the thing sounds very messy. I mean, how can
> a changeset be numbered 1.879.43.1 and not be included in 2.5.59?

cset 1.952.1.4 is the one that Linus released 2.5.59 on.
Now I started doing some development based on cset 1.875 - a few days older.

Tomorrow Linus release a new kernel, cset 1.973 for example.
Next week Linus merge my work, that will be numbered 1.875.1.1..1.875.1.3

You will see that my cset will be listed on the web on the date where
I did the commit, but it will not appear on kernel.org until
Linus merge my stuff.
So you cannot deduct from the numbers in what release a certain cset belongs.

The fact that cset's appear on the web as they are orginally committed
is annoying tracking the kernel, and Larry sometime ago noted that they
may do some changes in that respect.

	Sam
