Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTDYR74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 13:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTDYR74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 13:59:56 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32521 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263592AbTDYR7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 13:59:53 -0400
Date: Fri, 25 Apr 2003 14:06:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ben Collins <bcollins@debian.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
In-Reply-To: <20030424214107.GH808@phunnypharm.org>
Message-ID: <Pine.LNX.3.96.1030425135740.16623D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Ben Collins wrote:

> On Thu, Apr 24, 2003 at 05:44:39PM -0400, Bill Davidsen wrote:
> > On Wed, 23 Apr 2003, Marcelo Tosatti wrote:
> > 
> > > I guess Ben's mega patch (and yes, I also consider it a megapatch for
> > > -rc) has to be applied. I just mailed him asking about the possibility
> > > of getting only fixes in and not the cleanups, but I guess that might be a
> > > bit hard to do _today_. Right Ben ?
> > > 
> > > And about the sweet complaints about -pre timing, I will release -pre's
> > > each damn week for .22.
> > > 
> > > *!@#!&*.
> > 
> > If I might offer a course of action, if you put thing which are *fixes* in
> > the bk releases, and hold *changes* for the next -pre, it might allow
> > people to grab bk's to fix the quickly caught things in a new pre, without
> > being hit with major changes which might decrease stability.
> > 
> > Clearly any pre is a risk, but there always seem to be errors of the "XXX
> > doesn't compile because of typo" type. That way Alan could put all new IDE
> > code in each -pre and Andre and others could put fixes in the bk's until
> > it worked. => JOKING!! <== but you get the idea.
> > 
> > I'd love to see this in 2.5 as well, just to encourage people to use it!
> 
> You do realize that the -pre's are pulled from bk, right?

Yes, and I miss why that matters. Let me see if I can make the idea clear
to you:
  2.4.22-pre5		some code
  2.4.22-pre5-bk1	fixes
  2.4.22-pre5-bk2	more fixes
  2.4.22-pre5-bk3	still more fixes
  2.4.22-pre6		fixes to date plus major changes

So when a maintainer got something major it wouldn't go into bk (the
commercial software database) until a new -pre, while the -bk patches
available for download would get the fixes only.

Just a matter of staging, so that after a new -pre the -bk patch files
against it would hopefully get more stable for a few days. A new -pre need
not have something major, it would be nice if they came out every few
weeks at most. Any -pre release is an adventure, but usually there are a
few days of minor fixes posted, and it would be nice if those got
somewhere before the next major change.

Did I make it clear this time? You don't have to agree it's a good idea,
but I'd like you to understand what I have in mind.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

