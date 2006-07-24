Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWGXRu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWGXRu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWGXRu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:50:57 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:5392 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932249AbWGXRu4 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:50:56 -0400
Date: Mon, 24 Jul 2006 19:50:55 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Theodore Tso <tytso@mit.edu>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724175055.GA97168@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Theodore Tso <tytso@mit.edu>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org> <20060724133939.GA11353@thunk.org> <20060724153853.GA88678@dspnet.fr.eu.org> <20060724161755.GA3317@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724161755.GA3317@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 12:17:55PM -0400, Theodore Tso wrote:
> I would also note that we didn't intimate that we knew better than the
> reviewers, or question their motives, or otherwise insult the
> reviewers such that they might decide they have better things to do
> than to review our patches, and that might have had something to do
> with how the code got in relatively painlessly....

Now that has a very high impact :-) Hans is not very good at the
diplomacy game.

The fact that the ext maintainers are very, very good helps quite a
lot too.  But I think it doesn't change the fact that if r4 has been a
set of patches through time to r3, good or not, there wouldn't be a
discussion.


It's maybe the lack of an official development branch, but it looks
like the kernel development has become very risk-averse, and the bar
is set much higher to accept anything that looks relatively new.  Any
reason is good to have it dropped, cosmetic or not.

Just to give you an idea, if the criteria applied to suspend2 or
reiser4 had been applied to everything else, we wouldn't have at least
XFS[1], ALSA[2], sysfs[3] and DRM[4].  Whether it is good or bad is an
interesting question itself.  But before, code just had to be
reasonably sane, and it was expected to be fixed through time.  Some
even has been (sysfs got better).  Now it has to attain an ever moving
level of perfection before it has a chanc to be accepted.

Unless you're a maintainer, that is, for which you can get pretty much
anything in that doesn't immediatly break the compile through git
trees.  Thankfully, most of the maintainers are sane.


Don't you think this is a problem?

  OG.


[1] CodingStyle is for the weak

[2] You call that a kernel interface?  HWDEP?  ioctl to read/write
    samples instead of read/write?

[3] Lifetime rules and locking are for other people to care about

[4] Oh my, people are still trying to fix that one
