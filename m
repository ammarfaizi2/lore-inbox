Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTKMQ1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbTKMQ1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:27:20 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:8332 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264340AbTKMQ1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:27:18 -0500
Date: Thu, 13 Nov 2003 08:27:13 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031113162712.GA2462@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311112021.34631.andrew@walrond.org> <20031111235215.GA22314@work.bitmover.com> <200311131010.27315.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311131010.27315.andrew@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 10:10:26AM +0000, Andrew Walrond wrote:
> > > 2. Persuade Larry to release a 'clone/pull-only' version of bk which
> > > *anyone* can use to  access open source software
> >
> > As I've explained in the past, this doesn't make sense.  I'd be far more
> > likely to build a sort of CVS like client that could do checkouts and
> > updates of read only files.  That's a pretty straightforward thing to
> > do, in fact, nobody needs BK source to do that, it could all be done as
> 
> I'm a bit confused (not unusual). I think what I'm suggesting is exactly what 
> you've just described and doesn't involve releasing any bk source; Release a 
> binary only tool which will clone and pull only, 
> 
> Or am I missing something? How does this hurt the bk business model?

It doesn't hurt the BK business model.  It also doesn't require any 
access to BK source to do it.  Anyone could wrap a network daemon 
around BK and serve up repositories.  So that means you could do it
if it is important to you.  So could anyone else.

> > I could make some comment about this being a good example of one of
> > the zillion little problems we've had to solve but if I go there it's
> > going to start a flame war.  So I won't.  I will note that none of the
> > solutions proposed come close to being acceptable, they all fail on NFS
> > and on SMB shares.  And they don't cascade properly as HPA has noted.
> 
> Absolutely. Bk is, undeniably, brilliant, and would solve all these problems 
> at a stroke, except that the open source community cannot with good 
> conscience exclude *anyone* from being able to access the sources.

But noone is excluded from having access to the sources.

I suppose it sounds like we don't want to give out more free engineering
but let's put things into perspective.  The CVS server has about 6 users.
It's cost us a pile of money to build and support that technology.
For 6 users.  On the other hand, there are thousands if not tens of
thousands of BK users for the kernel alone.  About a year ago we added
unique ID's to the repositories themselves (the clones) and a few months
later I counted over 10,000 clones having connected to to openlogging.org
for the kernel tree (people do use BK for other things).

So what do you want?  Do you want us to spend what little resources we
have to give you on something that is used by less than 1/100th of one
percent of the people?  Are you sure?  What about us spending some time
and making performance and functionality of BK itself better?  Wouldn't
that be a better use of our time and help dramatically more people?
Remember, there is a limited amount that we can do.  Ask for the work
that helps the most people.

I'm starting to (finally) learn that there are a small number of people
who complain loudly (not you Andrew, I just happened to hit reply to your
mail) but they in no way represent the majority of the people doing work.
As far as I can tell, most people are using BK and if there wasn't any
whining they'd be content with that and what they'd really like is for
BK itself to improve (*).  Linus doesn't get any benefit from one more
enhancement to the CVS gateway, he doesn't use it.  Neither do thousands
of other people.  All those people would be one heck of a lot happier
if the BK integrity checks were faster, if the GUI tools were faster,
if we added digital signatures to changesets, the list goes on and on.

As much as I'd love to have zero complaining about BK, I don't see that
ever happening.  And it is a mistake for me to listen to that complaining
and help people who dislike BK, our license, and who knows what else.
There are a lot of silent people who are going about getting their job
done using BK and they deserve our help one heck of a lot more than a
bunch of whiners.

--lm

(*) Insert obligatory statement about everyone also wanting BK GPLed,
a chicken in every pot, a porsche in every garage, and a supermodel with
a PhD opening up your door to greet you with a smile at the end of your
hard day.
