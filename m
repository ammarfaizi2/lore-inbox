Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132629AbRC2ANh>; Wed, 28 Mar 2001 19:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132628AbRC2ANa>; Wed, 28 Mar 2001 19:13:30 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:16615 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S132626AbRC2ANR>; Wed, 28 Mar 2001 19:13:17 -0500
Message-Id: <200103290012.f2T0CZQ07089@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: Tim Haynes <kernel@vegetable.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem 
In-Reply-To: Your message of "Thu, 29 Mar 2001 00:47:40 +0100."
             <20010329004740.M28274@emcuk.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Mar 2001 19:12:35 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 28, 2001 at 06:33:04PM -0500, Hacksaw wrote:

> Why are they logged in as root in the first place? Is there something they
> can't do over sudo?

I have the "Gnome workstation" version of rawhide (7.0.xxx) on my new laptop. 
I don't see sudo. Of course, it's rawhide, but you'd think, if it were in 7.0, 
it'd make it. Or maybe they decided that the gnome workstation didn't need 
it... Hmmm.

> I definitely remember seeing a document saying `if you find yourself needing to
> `man foo', do it in another terminal as your non-root self'; it might or might
> not've been the SAG.

Sucks if you are trying to figure out a VT problem. 
 
> In any case, what happened to `if you use this rope you will hang yourself'?
> There has to be a point where you abandon catering for all kinds of fool and
> get on with writing something useful, I think.

Let's accept one thing: Root, should in fact, be allowed to do anything a 
regular user can. The fact that hanging is a possibility might ought to be 
pointed out. I have my shell set up to tell me I'm root. But the fact is, the 
typical sys-admin is essentially always logged in as root somewhere, and 
changing terminals to look at man pages is sometimes not an option.

For that matter, I have often figured out that something had funny permission 
problems by discovering that the problem goes away if I run a program as root.

Assuming everything root is doing must be sacrosanct is a pipe dream.  
Assuming everything a regular user is doing is expendable is BOFH think.

I do agree that you have to draw a line. I'm just saying that's the wrong one.

> > I completely agree that doing general work as root is a bad idea. I do most
> > root things via sudo. It sure would be nice if all the big dists supplied it
> > (Hey, RedHat! You listening?) as part of their normal set.
> 
> RH have been listening since v7.0.

Good. I hope it comes out well in 7.1, considering my experience with rawhide.


