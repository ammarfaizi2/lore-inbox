Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268436AbRGZRQb>; Thu, 26 Jul 2001 13:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268371AbRGZRQV>; Thu, 26 Jul 2001 13:16:21 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:44452
	"EHLO bozar") by vger.kernel.org with ESMTP id <S268436AbRGZRQK>;
	Thu, 26 Jul 2001 13:16:10 -0400
Date: Fri, 27 Jul 2001 03:15:51 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Mail-Followup-To: Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010726095452.L27780@work.bitmover.com>
User-Agent: Mutt/1.3.18i
Message-Id: <996167751.209473.2263.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 09:54:52AM -0700, Larry McVoy wrote:

> What I'm trying to say is that I think Daniel is one of the good guys,
> even though his user interface could stand improvement (a common thing
> amongst smart people) and it looks like it would be smart to figure out
> how to work with him.

there's a work-in-progress called ReiserSMTP[1] which rewrites
some bits of qmail so it works better with ReiserFS, although i
can imagine that it would improve things on Linux as a whole.

this is getting off-topic, but since the various parties involved
(Linux vs djb/Wietse/etc[2]) are probably never going to agree
on semantics, i'm wondering if it's possible to ask them to
write the software in such a way that it's possible to 'drop in'
your own functions relevant for sync'ing.  then the MTA writers
can go and use their traditional filesystem assumptions and
Linux users can produce very small patches to support the
correct behaviour under Linux.

it would be _nice_ if the ext3 guys would be more willing to
implement directory-syncing on link/rename/etc, though, even as
an option.  a 'mount -o dirsync' would be enough; no need for
chattr +D stuff.  Linux tends to have a bad name as a platform
as an MTA just because of all this, which is a shame.  it would be
nice if a fix is possible.  *nudge nudge Mr. Morton* :)

    [1] http://www.jedi.claranet.fr/reisersmtp.html

    [2] hey, this might be the first time they agree on
        anything!


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
