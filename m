Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTLEPAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTLEPAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:00:38 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:34031 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264239AbTLEPAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:00:18 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "David Schwartz" <davids@webmaster.com>,
       "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 08:59:45 -0600
X-Mailer: KMail [version 1.2]
Cc: <Valdis.Kletnieks@vt.edu>, "Peter Chubb" <peter@chubb.wattle.id.au>,
       <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKAEJHIHAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEJHIHAA.davids@webmaster.com>
MIME-Version: 1.0
Message-Id: <03120508594500.21696@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 December 2003 05:16, David Schwartz wrote:
> > On Thu, 4 Dec 2003, David Schwartz wrote:
> > > The GPL gives you the unrestricted right to *use* the original work.
> > > This implicitly includes the right to peform any step necessary to use
> > > the work.
> >
> > No it doesn't.
> >
> > Your logic is fundamentally flawed, and/or your reading skills are
> > deficient.
>
> 	I stand by my conclusions.
>
> > The GPL expressly states that the license does not restrict the act of
> > "running the Program" in any way, and yes, in that sense you may "use"
> > the program in whatever way you want.
>
> 	Please tell me how you use the Linux kernel source code. Please tell me
> how you run the Linux kernel source code without creating a derived work.

You compile it without modifications.

> > But that "use" is clearly limited to running the resultant program. It
> > very much does NOT say that you can "use the header files in any way you
> > want, including building non-GPL'd programs with them".
>
> 	Huh? What "resultant program"? Are you talking about an executable that's
> a derived work of the Linux kernel source code?

You don't have "an executable" unless it includes the kernel as the 
executable.

It actually sounds like you are confusing Kernel mode with User mode.

> 	Modules are derived works of the Linux kernel source code, not the kernel
> executable. So the license that would be relevent would be a license that
> restricts how you can use the source code or derived works of the source
> code. License to run a program, when you have source code, is license to
> compile that source code.
>
> 	For example, 2b says:
>
>     b) You must cause any work that you distribute or publish, that in
>     whole or in part contains or is derived from the Program or any
>     part thereof, to be licensed as a whole at no charge to all third
>     parties under the terms of this License.
>
> 	You don't seriously think that's talking about derived works that are
> derived from *executables*, do you?

It is if you are referring to the Kernel. Look at the include files. They are
licened under GPL.

Look at the include files for applications. They are licenced under LGPL.

The kernel include files are NOT.

> > In fact, it very much says the reverse. If you use the source code to
> > build a new program, the GPL _explicitly_ says that that new program has
> > to be GPL'd too.
>
> 	I download the Linux kernel sources from kernel.org. Please tell me what I
> can do with them without agreeing to the GPL. Is it your position that I
> cannot compile them without agreeing to the GPL? If so, how can running the
> program be unrestricted? How can you run the linux kernel soruce code
> without compiling it?

compile them. Read them. run them.

You do not modify them. You do not combine them with propriatary executables 
and distribute them without that executable and it's source becoming GPL.

> > > Please tell me how you use a kernel header file, other than by
> > > including it in a code file, compiling that code file, and executing
> > > the result.
> >
> > You are a weasel, and you are trying to make the world look the way you
> > want it to, rather than the way it _is_.
>
> 	That is a serious example of projection.
>
> > You use the word "use" in a sense that is not compatible with the GPL.
> > You claim that the GPL says that you can "use the program any way you
> > want", but that is simply not accurate or even _close_ to accurate. Go
> > back and read the GPL again. It says:
> >
> > 	"The act of running the Program is not restricted"
> >
> > and it very much does NOT say
> >
> > 	"The act of using parts of the source code of the Program is not
> > 	 restricted"
>
> 	You run a piece of source code by compiling it. If a header file is
> protected by the GPL, permission to "run" it means permission to include it
> in files you compile.
>
> 	The GPL says:
>
>   0. This License applies to any program or other work which contains
> a notice placed by the copyright holder saying it may be distributed
> under the terms of this General Public License.  The "Program", below,
> refers to any such program or work, and a "work based on the Program"
> means either the Program or any derivative work under copyright law:
> that is to say, a work containing the Program or a portion of it,
>
> 	The work that was placed under the GPL is the Linux kernel source. The
> "program" is the source code. Please, tell me how you "run" the Linux
> kernel source code other than by compiling it to form a derived work.
>
> 	Perhaps you misunderstand the GPL to mean that a 'program' must be an
> executable? Not only does section zero clearly refute that, but if it were
> true, it would mean that a module is not a derived work from a GPL'd work!
> It is a program that's placed under the GPL, and a module is not a derived
> work from any other executable.
>
> > In short: you do _NOT_ have the right to use a kernel header file (or any
> > other part of the kernel sources), unless that use results in a GPL'd
> > program.
>
> 	The phrase "results in a GPL'd program" is one that I cannot understand. I
> have no idea what you mean by it. You have the right to "run" the header
> file, the GPL gives it to you. The way you "run" a header file is by first
> compiling a source code that includes it into an executable.

Quite simple. If you include the Linux kernel include files you get a derived
program that must be released under GPL if you distribute that program.

> > What you _do_ have the right is to _run_ the kernel any way you please
> > (this is the part you would like to redefine as "use the source code",
> > but that definition simply isn't allowed by the license, however much you
> > protest to the contrary).
>
> 	How can I run the kernel without compiling it? And how can I compile it
> without creating a derived work? The GPL says:
>
>   5. You are not required to accept this License, since you have not
> signed it.  However, nothing else grants you permission to modify or
> distribute the Program or its derivative works.  These actions are
> prohibited by law if you do not accept this License.  Therefore, by
> modifying or distributing the Program (or any work based on the
> Program), you indicate your acceptance of this License to do so, and
> all its terms and conditions for copying, distributing or modifying
> the Program or works based on it.
>
> 	Of course, the second sentence is utterly false. Fair use and necessary
> step provisions do just that.

It is not fair use to create and distribute derived works that use Kernel 
include files without agreeing to the GPL.

> > So you can run the kernel and create non-GPL'd programs while running it
> > to your hearts content. You can use it to control a nuclear submarine,
> > and that's totally outside the scope of the license (but if you do,
> > please note that the license does not imply any kind of warranty or
> > similar).
> >
> > BUT YOU CAN NOT USE THE KERNEL HEADER FILES TO CREATE NON-GPL'D BINARIES.
> >
> > Comprende?
>
> 	I have no idea what you mean by a "NON-GPL'D BINARY". *Any* binary you
> create from a kernel header file is, at least to some extent, a derived
> work of that header file. However, the question for whether it would be
> covered by the GPL is whether you exercised a privilege in creating that
> work that you were only granted by the GPL.

Nope. You are confusing GPL with LGPL. Not the same thing.

> 	Again, what I'm trying to say is that the term "program" in the GPL means
> whatever it is that's placed under the GPL (which can be an executable
> and/or source code). Of course, placing an executable under the GPL
> effectively places its source code under the GPL (as soon as you distribute
> it to someone else, as you are required to do, who is limited only by the
> GPL).
>
> 	In the case of the Linux kernel, the source code was initially placed
> under the GPL. Once source code is placed under the GPL, your right to "run
> the program" means a right to compile the source code. In the case of
> header files, this means the right to include the header file in code files
> and thereby produce and use derived works. (Whether or not you can
> distribute those derived works is, of course, a whole different argument.)
>
> 	So my point is that the GPL isn't really even relevant here. You have all
> the rights you need without agreeing to it. "Activities other than copying,
> distribution and modification are not
> covered by this License; they are outside its scope." Including a header
> file in your own class file is not copying, distribution, or modification
> of that header file. It is use, mere use.

Depends on where that class file ends up. If it is in a binary, that you 
intend to distribute, then that binary, and its source is GPL.

Check the headers. If it says GPL, then anything compiled that uses that
header should be GPL when/if distributed.

