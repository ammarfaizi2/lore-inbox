Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUJZByx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUJZByx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUJZBwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:52:38 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:33924 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262060AbUJZB2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:28:19 -0400
Date: Mon, 25 Oct 2004 18:28:12 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Larry McVoy <lm@work.bitmover.com>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041026012812.GA3978@taniwha.stupidest.org>
References: <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <9e47339104102511182f916705@mail.gmail.com> <20041025230128.GA1232@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025230128.GA1232@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 04:01:28PM -0700, Larry McVoy wrote:

> Things we are working on include performance (Wayne has a hot cache
> linux-2.5 tree consistency check down to around 2 seconds, that's
> about a 10x improvement over what it is now),

i'm still at 16s here, i would *love* to see this performance speed
increase in the free version that is made available for kernel people

> we're revamping the GUIs to be useable by normal humans, we're
> working on scaling to >500,000 changesets in one tree

one thing i wondered about, is there some way you can optimize
performance knowing for repositories like the kernel tree where the
access patterns are pretty much (for me anyhow) pull in new stuff,
look back a few weeks, maybe clone back as far as a month but beyond
that i rarely pay any attention?

i guess what i'm doing a bad job of saying is that it seems i'm using
only the most recent weeks/days of changes 99% of the time --- can i
do something knowing this that makes my day to day life easier at
maybe the expensive of cloning something really old?

> As for handling AndrewM's workflow, we're very interested in that
> area because there seems to be a sort of bimodal development model,
> changes which are not yet "frozen" (best managed by something like
> quilt it seems) and changes which are frozen (best managed by BK).

right now i use quilt and bk together, i'm still trying to refine a
nice way of doing that (which i should document) but on the whole they
don't conflict as a rule and it's really not that bad.  previously i
was using bk like quilt using a script to make csets from patches and
then i would undo to roll back before pulling and what-not but this
was error-prone at times (sometimes i would pull from the parent which
would do a merge so i couldn't roll back after that)


i really don't know why people bitch so much about bk personally, i
really like it, it's much more reliable than svn for me (bk checksums
whilst i might complain about them have found fs bogons a number of
times, with svn i just have a collection of busted db files), it's
much faster than CVS and the bk development model (well, the model i
have when i use it) works better by far than anything i've used
previously

i like bk, i'll continue to use it where possible, for those that have
strong feelings against bk, well, stick with CVS (or whatever) then.
enjoy your pain.
