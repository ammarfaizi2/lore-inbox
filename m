Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbTAUTSs>; Tue, 21 Jan 2003 14:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTAUTSs>; Tue, 21 Jan 2003 14:18:48 -0500
Received: from sprocket.loran.com ([209.167.240.9]:2810 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S267173AbTAUTSp>; Tue, 21 Jan 2003 14:18:45 -0500
Subject: Re: Is the BitKeeper network protocol documented?
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030121183414.AAA4503@shell.webmaster.com@whenever>
References: <20030121183414.AAA4503@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Jan 2003 14:27:51 -0500
Message-Id: <1043177271.1397.149.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 13:34, David Schwartz wrote:
> On 21 Jan 2003 11:04:31 -0500, Dana Lacoste wrote:
> 
> >This means that the source code to the product you have must be
> >in a form that is modifiable, and it must be in the 'preferred'
> >form for YOU to modify that code.

> >This has NOTHING to do with patches and tracking changes and
> >communicating with Linus.  This has to do with the code to the
> >software you use and YOUR ability to change it.

> 	This can't be right for two reasons.
> 
> 	First, I would in fact prefer to have the version control 
> information to make changes.

So what?  This has nothing to do with getting the source code
to a binary distributed product.

Remember, the GPL covers the distribution of binary modules, and
how to get the source to those modules, not the documentation from
meetings made 5 months before the code was modified.

> The commit comments, for example, may 
> explain the rationale for changes. Seeing who made a change may 
> affect my level of confidence in that change.

This is also irrelevant.  You receive a binary module (this is
your redhat model, remember?) and you want the source code to
that module before you install it.  Redhat gives you the source
used to compile the module.  You don't get the checkin comments
because they weren't used to compile the source.

Your inability to deal with the source in a raw form is YOUR problem,
not the original author's, and not the GPL's raison d'etre.

> Also, seeing which 
> changes were made a unit helps you to know what code affects what 
> other code. Anyone who has ever modified a project that is managed 
> through a version management system will tell you that they prefer to 
> have access to the repository and the metainformation in it than just 
> have the raw source code out of the repository.

Once again, the GPL is giving you access to the source code to the
module you have, not the modules you don't have, not the modules that
were in the past.  Why don't you understand this?

> 	Second, what you say above would imply that if I prefer my source 
> code on 30mm tape in EBCDIC format, then RedHat has to provide it to 
> me since that's my preferred form.

No, that's not what 'preferred form' means.  Instead, it refers to the
form the binary module is preferred to be in when changes are made.

See, in modern computers the CPU speaks what we call 'machine code.'
This isn't really easy to read or to understand because, for the most
part, we're not computers.
In order to facilitate the difficulties inherent in reading 'machine
code' computer programmers routinely use what are called 'higher level
languages' such as assembly language (which is essentially a text-based
version of machine code) or C (which is one step 'further' from machine
code towards the english language) or even APL (which is closer to
martian than english.)

Because binary code is so hard to read (for the most part programmers
don't even use it, resorting to the above mentioned 'higher level'
languages instead) companies are able to sell software products by
shipping a binary package that is, for all intents and purposes,
unmodifiable by the end user.

Because of the notoriously shoddy work done by many corporations, and
the natural desire to have stable and reliable software, RMS started
the Free Software Movement, an attempt to gain access to the source
code to the programs that cause so much instability in our lives.

Thus, it's required under the GPL to distribute the source code that
the binary modules were compiled from, in a form that can be modified.

"a complete machine-readable copy of the corresponding source code, to
be distributed under the terms of Sections 1 and 2 above on a medium
customarily used for software interchange"

(Note that although a 30mm tape is a possible medium for software
interchange, so is ftp, and it quite clearly says 'a' medium.  Meaning
the distributor decides.)

> 	My best attempt at understanding what "preferred form for making 
> changes" is the form that the people making the changes actually do 
> in fact prefer.

The difference here is subtle, so I'll try again.

"Preferred" in english is a relative term.  It implies
that there is a form that is "not preferred" and the GPL
goes to quite a length to explain that binary, machine-code
distributions are the "not preferred" form.

Therefore the "preferred form" is the form that is _not_
the binary machine-code form.  This is the 'source code'
from which the binary form is made.

Because re-distribution counts as distribution, it is important
that the re-distributor distributes the source code, even if they
didn't make any changes.

It is not important that the re-distributor maintain changes over
time, nor that the re-distributor even understand what's going on
in the code, what's important is that the end user doesn't get
something that they can't make changes to, if need be.

> 	What happens when one party gets source code from another and both 
> parties make changes. Suppose, hypothetically, Linus only gave out 
> obfuscated source code. He can do that, since he doesn't distribute 
> binaries. Now, can RedHat ship binaries of Linus' obfuscated source 
> code? If so, anyone can evade the intent of the GPL just by creating 
> a separate company. So it *can't* mean the preferred form of the 
> person you got the binary from.

If Linus only gave out obfuscated source code then he wouldn't be
in business as the leading open source kernel manager for long, now
would he?

Then again, Ulrich Drepper manages to get away with it....

Hmmm....

:) :) :) :)

> 	I think it has to mean the preferred form for making changes by the 
> people who actually do make changes. And I don't think you can 
> justify removing any information that helps the people who make 
> changes do their change-making, as that is not what they prefer.

You can justify whatever the hell you want.  The GPL says the source
code has to be there, pure and simple.  No comments, no system
libraries, no BK notes.

> 	I think I've said all I have to say on this subject, especially 
> since it doesn't affect the Linux kernel at this time. However, I 
> caution against ever allowing a situation where the preferred form 
> for making changes of any GPL'd project, preferred by the people 
> making the changes, is in any way a proprietary system.

I think maybe you need a new license, because the GPL is obviously
not what you want.

Dana "Why didn't David reply in private to the private reply?" Lacoste
Ottawa, Canada

