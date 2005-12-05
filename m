Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVLEVV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVLEVV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLEVV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:21:57 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:25520 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932534AbVLEVV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:21:56 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Mark Lord <lkml@rtr.ca>,
       Rob Landley <rob@landley.net>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>, linux-kernel@vger.kernel.org
In-Reply-To: <873bl76zd3.fsf@mid.deneb.enyo.de>
References: <20051203135608.GJ31395@stusta.de>
	 <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
	 <200512042131.13015.rob@landley.net> <4394681B.20608@rtr.ca>
	 <1133800090.21641.17.camel@mindpipe>
	 <20051205164418.GA12725@merlin.emma.line.org>
	 <1133803048.21641.48.camel@mindpipe>
	 <20051205175518.GA21928@merlin.emma.line.org>
	 <873bl76zd3.fsf@mid.deneb.enyo.de>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 16:21:19 -0500
Message-Id: <1133817679.6724.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 21:52 +0100, Florian Weimer wrote:
> * Matthias Andree:
> 
> > Basically, no-one should have permission to touch any core parts, except
> > for fixes, until 2.7. Yes, that means going back to older models. Yes,
> > that means that the discussions will start all over. And yes, that means
> > that the cool stuff has to wait. Solution: release more often.
> 
> Would this alone change much?  I think what we really want is that our
> favorite branch (whatever it is) gets critical fixes forever (well,
> maybe one or two years, but this is forever).  This is a bit
> unrealistic because everyone has a slightly different branchpoint.
> Releasing more often doesn't change that, really.

Maybe that is what is needed.  A branch that all can use.  Have every 5
or so 2.6.x become a "stable" branch.  Where distributions and users can
work together on keeping it stable.  The rules to modifying such a
branch would pretty much stay with what it already takes to modify the
current 2.6.x.y branch.  If you want a feature, you must either take the
latest "unstable" 2.6.x branch or wait for the next "stable" 2.6.x
branch to merge.

Now who should chose which version the "stable" branch should be?  Well,
we could just say ever 5 branches will become one, or if we have a
"F*cked up" branch (really bad bug made it in), then we can skip it and
go to the 6th to branch.

Perhaps, we could start out having Greg and Chris just concentrate on
every fifth branch instead of every one, and that way the stability will
last much longer.  Again, if you want the latest functionality, you go
with the latest "unstable" release, or wait for the next stable.  Since
these releases come out about every month or two, waiting 5 releases
will last for almost a year.

For this to work, the normal releases would just continue like normal.
And just the marked branch will become stable.  This may be similar to
what Linus formally proposed.  Where he had every odd revision be
unstable, and every even stable.  What I'm suggesting would not make the
stable branch stable by what goes into it. It's just that those are the
branches that would have the .y version.  And then we could ignore the
other branches instead.

This idea combines pretty much the idea of the 2.7 with the current
2.6.x.y.  Actually it is more like the 2.7 approach, but it's hidden :-)
The problem with 2.7 is that nobody tests it, and it takes too long to
go from 2.6 to 2.8.  My method here hides that fact.  You just basically
say "here's the stable version" and let it fork.  Continue on with the
2.6.x and when you think too many people are using the last stable
version, and are not testing the current branch, just release the new
"stable", and pull everyone back in.


-- Steve

