Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTBEUmB>; Wed, 5 Feb 2003 15:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTBEUmA>; Wed, 5 Feb 2003 15:42:00 -0500
Received: from [195.223.140.107] ([195.223.140.107]:27264 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264863AbTBEUmA>;
	Wed, 5 Feb 2003 15:42:00 -0500
Date: Wed, 5 Feb 2003 21:51:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205205127.GP19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <200302051404.21524.shaggy@austin.ibm.com> <20030205201055.GL19678@dualathlon.random> <20030205203445.GA4467@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205203445.GA4467@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 09:34:45PM +0100, Sam Ravnborg wrote:
> The fact that cset's appear on the web as they are orginally committed
> is annoying tracking the kernel, and Larry sometime ago noted that they
> may do some changes in that respect.

I don't mind too much where they appear. I assumed they would appear at
the head if they are merged last, but it's not important.

What I care is how can I find the order of the changesets that are
applied to Linus's tree? That's all I need to know. I thought the order
shown on the web would just provide this information, but now I'm lost...

Also note that the fact changesets can be merged in the past, and not
alwayas in the head, means that all the cset/ directory can be
completely corrupt and useless, because if regenerated at any given time
it would produce different diffs, unless this order that I'm searching
for isn't preseved internally by bk. In short the cset directory sounds
like a joke unless bk internally keeps the ordering, and in such case I
should find a way to get that information out of bk too, that's the last
bit I need to checkout coherent.

Andrea
