Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTCLFMD>; Wed, 12 Mar 2003 00:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263042AbTCLFMD>; Wed, 12 Mar 2003 00:12:03 -0500
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:35235 "EHLO
	renegade") by vger.kernel.org with ESMTP id <S263039AbTCLFMA>;
	Wed, 12 Mar 2003 00:12:00 -0500
Date: Tue, 11 Mar 2003 21:22:25 -0800
From: Zack Brown <zbrown@tumblerings.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030312052225.GO4716@renegade>
References: <20030311184043.GA24925@renegade> <200303120347.h2C3loEG002703@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303120347.h2C3loEG002703@eeyore.valparaiso.cl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 11:47:50PM -0400, Horst von Brand wrote:
> Zack Brown <zbrown@tumblerings.org> said:
> > --------------------------------- cut here ---------------------------------
> > 
> >            Linux Kernel Requirements For A Version Control System    
> > 
> > Document version 0.0.1
> 
> [...]
> 
> > In the context of sharing changesets between repositories, a changeset
> > consists of a diff between the set of files in the local and remote
> > repositories.
> 
> I don't think it is a good idea to handle differences _between_
> repositories, as they could be arbitrary and change in time. A change
> _within_ a repository is well defined.

But isn't it necessary to excange changesets between repositories? How
else would a developer choose exactly what changes get merged with a
remote repository?

> 
> >   2. Behavior
> > 
> >     2.1 Tagging
> > 
> > It must be trivial for a developer to tag a file as part of a given
> > changeset.
> 
> An individual change, not a file. You need to focus on changes to files,
> not files. I.e., file appeared/dissapeared/changed name/was edited by
> altering lines so and so. 
> 
> The bk method of accepting individual changes, and then bundling them up
> should be enough, people tend to work at one problem at a time.

I'm not so familiar with how BitKeeper operates. What do you mean by
"accepting individual changes, and then bundling them up"?

> > The implementation must not depend on time being accurately reported by any
> > of the repositories.
> 
> It is more complicated than that. On a distributed system without some form
> of shared clock it might be impossible (== nonsense, like in relativity
> theory) to talk of a global "before" and "after"

Maybe the system should simply ignore the whole concept of time as occurring
in discrete ticks, and just measure time as the relative history of
changesets. That might give it enough of a basis to make estimates on which
changes came 'before' and 'after' other changes in most cases. I imagine a
lot of subtle intelligence could be implemented. And for situations defying
that intelligence, the system could query the user.

> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > This document is copyright Zack Brown and released under the terms of the
> > GNU General Public License, version 2.0.
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> Why not the documentation license? Just curious.

I read it when it first came out, and it just seemed to be trying to do
something that wasn't really feasible, and to do it in a fairly arbitrary
way. Besides, the protections it claimed to offer didn't interest me. The
GPL may have a soft spot or two, but I really like it, and I think it
applies just as well to text as to computer program code.

> > 
> > --------------------------------- cut here ---------------------------------
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

-- 
Zack Brown
