Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbSAEVmt>; Sat, 5 Jan 2002 16:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285618AbSAEVmk>; Sat, 5 Jan 2002 16:42:40 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:5511 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S285135AbSAEVmf>; Sat, 5 Jan 2002 16:42:35 -0500
Date: Sat, 5 Jan 2002 14:42:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: willy tarreau <wtarreau@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel-2.4.18-nj1
Message-ID: <20020105214231.GD756@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020105180601.GC756@cpe-24-221-152-185.az.sprintbbd.net> <20020105194140.67038.qmail@web20504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020105194140.67038.qmail@web20504.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 08:41:40PM +0100, willy tarreau wrote:
> Hello Tom,
> 
> > I'd actually argue against this.  When Alan picked
> > up 2.2.x, there wasn't someone else doing an -ac'ish
> > 2.2 release as well.
> 
> Right, but at 2.2 times, there were less features and
> less users than now. Preemption, PNPBios, Tux,
> schedulers, additionnal filesystems are many features
> that interest lots of people. Not that Alan did include
> them all either, but at least he gave the opportunity
> to test some of them (think about ext3 and pnpbios).

>From what I remember, there were lots of other projects going on in 2.2
time, and lots of the stuff in 2.3 (think USB) was done with 2.2.x/2.3.x
compatibility glue.  And of all of the things you listed above, they
should all work independantly of eachother too, for the most part.

> > Marcelo is doing 2.4.x now, and seems to be doing a
> > good job of making sure stable stuff gets in, and
> > other stuff doesn't. The only patches that won't
> > make it into Marcelos tree in the very-near-term
> > (Which is all I'll speculate about) are the preempt
> > (and lock-break) patches.
> 
> I totally agree. And that's why I find it still
> acceptable to have one tree (and not 1000) to test
> other features such as the ones above, so a large set
> of users can test them (eg: filesystems).

But why do we need yet another tree for this?  There already is a large
set of users testing the preemption patches, and I'm not aware of any
new filesystems yet, but I don't see why they'd need another tree
either.  A lot of what the -ac tree did was provide maintainers another
person to give their patches to (since sending stuff to Linus is a hit
or miss thing for many people) that tended to have a high rate of
success (or comments) with Linus.  Marcelo is very good about taking
patches from maintainers (and telling other people to send stuff to said
maintainer first).

> > Please people, more trees are not always a better
> > thing when you're all doing the same thing.
> 
> Perhaps people who have a solid personal tree would
> like to continue this discussion off-list and find
> an arrangement about a single test tree. Concerning
> stable trees, I think that both Marcello's and
> Andrea's are rock solid. Othe people may want to use
> their distributor's.

Again I say, why do we need a 'test' tree?  I really don't see more than
one large patch/project/feature getting into a final release, so testing
that project with a bunch of other projects actually invalidates the
testing of it.

> I'll stop here to avoid decreasing the s/n ratio too
> much. Off-list correspondance OK.

I'd really rather not just yet.  I'm pretty sure this is all on-topic
still.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
