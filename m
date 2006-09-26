Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWIZWUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWIZWUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIZWUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:20:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964868AbWIZWUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:20:42 -0400
Date: Tue, 26 Sep 2006 15:20:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: x86/x86-64 merge for 2.6.19
In-Reply-To: <20060926220457.GA12905@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0609261517440.3952@g5.osdl.org>
References: <200609261244.43863.ak@suse.de> <200609262202.28846.ak@suse.de>
 <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org> <200609262226.09418.ak@suse.de>
 <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org> <20060926220457.GA12905@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Sam Ravnborg wrote:

> On Tue, Sep 26, 2006 at 01:44:42PM -0700, Linus Torvalds wrote:
> >
> > Right. I'm actually surprised not more peole use git that way. It was 
> > literally one of the _design_goals_ of git to have people use quilt a a 
> > more "willy-nilly" front-end process, with git giving the true distributed 
> > nature that you can't get from that kind of softer patch-queue like 
> > system.
> 
> One of the major benefits from git is that whenever I decide to
> do some changes git allows me to start modifying as I like and when
> done I just do "git diff | less" to review it. And when it turns out
> to be a piece of crap I just do "git reset --hard" and be done with it.
> This make my life so much easier than having to copy symlinked tress
> around all the time - and I then may not touch the base for the symlinks.

Yeah, I won't argue against that too much. I'm a pure git user myself, 
although my patterns tend to be different from most other people (only 
fairly small code changes, and mostly merging other peoples code: I end up 
often touching source code more when I do some trivial manual conflict 
resolution than at most other times..)

And yes, making "git diff" as efficient as possible was definitely one of 
the things that I worked on, exactly because it is how I work when I do 
end up working on something: continually reminding myself what the other 
changes I did were..

So "git" should work fine for pretty much any normal development, but a 
patch maintenance system it ain't.

			Linus
