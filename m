Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287748AbSAIQEi>; Wed, 9 Jan 2002 11:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287734AbSAIQE1>; Wed, 9 Jan 2002 11:04:27 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:10000 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S287720AbSAIQEO>; Wed, 9 Jan 2002 11:04:14 -0500
Date: Wed, 9 Jan 2002 10:04:11 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201091604.KAA18962@tomcat.admin.navo.hpc.mil>
To: andy@i-a.co.uk, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Difficulties in interoperating with Windows
In-Reply-To: <20020109152823.62f65b7c.andy@i-a.co.uk>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I guess part of it may be that Windows
> > > is closed source but as reverse engineering for interoperability is
> > > legal in the UK (regardless of what the End User License states), is
> > > the problem that it is difficult to read the Assembly easily?
> >
> > That is not reverse engineering - (at least not MY understanding) - you
> > are re-translating a copyrighted work. If the translation back into the
> > binary form creates the same binary then you have an exact translation.
> 
> But would it?  If you disassemble part/all of Windows and use the code to
> understand how it works, then use this to create a specification and write
> code to use that specification, there should be no problem?

As long as someone ELSE does the developement (this is the "clean room"
developement that lawyers like for the defence - it must also be fully
documented). Second, you STILL have the problem of "trade secrets" being
appropriated, even if unwittingly.

> > You also
> > have a lawsuit pending. Otherwise you could just disassemble the entire
> > windows OS, claim it as your "re-engineered source", and sell/publish
> > it.
> >
> > This is not legal in most locations.
> 
> Correct, but I'm not talking about recompiling Windows and selling it, I'm
> talking about decompiling it and using the decompiled source to make Linux
> work better with it.  That is completely legal.

Not really - M$ will come after you. That's why the problems with NTFS still
exist - the people that were working on it (even in a "clean room") had to
desist. They (as I understand it) eventually dropped their M$ software. And
NTFS is still read-only.

> > Reverse engineering is taking the published specifications, creating
> > software that should function in an equivalent manner.
> 
> I disagree with that definition and agree with this one:
> 
> First result for a www.google.com search on "definition reverse engineer"
> 
> http://whatis.techtarget.com/definition/0,289893,sid9_gci507015,00.html
> 
> :Software reverse engineering involves reversing a program's machine code
> :(the string of 0s and 1s that are sent to the logic processor) back into
> :the source code that it was written in, using program language
> statements.:Software reverse engineering is done to retrieve the source
> code of a:program because the source code was lost, to study how the
> program:performs certain operations, to improve the performance of a
> program, to:fix a bug (correct an error in the program when the source
> code is not:available), to identify malicious content in a program such as
> a virus, or:to adapt a program written for use with one microprocessor
> for use with a:differently-designed microprocessor. Reverse engineering
> for the sole:purpose of copying or duplicating programs constitutes a
> copyright:violation and is illegal. In some cases, the licensed use of
> software:specifically prohibits reverse engineering.

And M$ will go after you because of the last two sentences. Especially the
"duplicating programs" part. They will (have?) claimed that duplicating
NTFS functionality is not legal. (I think Jeff Merkey was the one doing
this - He should the one to really comment on the problems he had with M$).

Also note - none of that definition addresses the ability to publish the
results.

> > The problem with most M$ software is that the published specifications
> > are not complete, access to the inputs are not always available (it is
> > ALSO covered> by the proprietary/trade secrets/other restrictions).
> > Sometimes the output is not available (at least in some countries - DMCA
> > again).
> 
> While I agree about proprietary/trade secrets may be a grey area, where
> you have the express legal right to reverse engineer a software product
> for the purposes of interoperability surely that is final.  As the
> contract would have been between Microsoft UK and you (note I'm only
> discussing the UK and we don't have an equivalent of the DMCA here)

Yes - but any software that is to be included in the Linux kernel must also
be legal everywhere (well, especially the USA). Just look at the problems
DECSS has had. and the cross agreements between the US and Europe are
beginning to force some agreement to the limits on revers engineering. Check
the refusal of A.Cox to publish explainations of some security patches due
to the DMCA.

M$ has a VERY long arm, and LOTS of high priced lawyers.

> > > Is there not a project on Linux to convert assembly back to C?   Would
> > > this be exceptionally hard?
> >
> > Not hard - just illegal when using it to disassemble proprietary
> > software. Debuggers do this very frequently, to the point that I would
> > say "all the time" except for debuggers of interpreted languages.
> 
> Depends where you are in the world I guess.  I am specifically (in the UK)
> given the right to do this.

But you are not allowed to republish.

It also depends on the software - the way M$ is going, they may build in
a detection for any access to the OS binaries (checkout that DRM patent).
If it isn't from an approved program, the system just may wipe itself out
(assuming it is running :-)

> Just interested in opinions on this...

Sure thing.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
