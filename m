Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTLETzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTLETzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:55:39 -0500
Received: from mail.webmaster.com ([216.152.64.131]:7110 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264361AbTLETze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:55:34 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Ryan Anderson" <ryan@michonline.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 11:55:26 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEMGIHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20031205140304.GF17870@michonline.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Dec 05, 2003 at 03:16:27AM -0800, David Schwartz wrote:

> > > The GPL expressly states that the license does not restrict the act of
> > > "running the Program" in any way, and yes, in that sense you
> > > may "use" the
> > > program in whatever way you want.
> >
> > 	Please tell me how you use the Linux kernel source code.
> > Please tell me how
> > you run the Linux kernel source code without creating a derived work.

> You "use" the Linux source code by feeding it to a compiler.  Or maybe
> as a hideous fortune file.  The output of that compiler is *clearly* a
> derived work, and thus bound by the GPL.

	So, if you are permitted to "use" the Linux source code, you are permitted
to create derived works of it. Do we agree on that one simple issue?

> So far, I don't see any reason why a module that uses an inline function
> provided via a kernel header could be distributed in binary
> format without
> being a "derived work" and thus bound by the GPL.

	Because the GPL can only bind a derived work if you had to agree to the GPL
to *make* that derived work. The law (at least in the United States) does
not give a copyright holder a separate right to restrict the distribution of
derived works, only to restrict their creation.

> > 	I download the Linux kernel sources from kernel.org. Please
> > tell me what I
> > can do with them without agreeing to the GPL. Is it your position that I
> > cannot compile them without agreeing to the GPL? If so, how can
> > running the
> > program be unrestricted? How can you run the linux kernel soruce code
> > without compiling it?

> Compile it.

	The only way to compile a header file is to include it into a C file and
use that C file to make a derived work from that header file.

> Run the resulting executable (ignoring the case law that says copying
> into ram is a copy under copyright law)
> Read the source code.
> Write a module using the source code (i.e, via headers)
>
> If you want to distribute that module, you must, of course, follow the
> GPL.

	Only if you needed rights granted under the GPL in order to create it. I
think you're missing my point. My point is that *if* you can create the
derived work without having to agree to the GPL, then you can distribute the
derived work without having to agree to the GPL.

> > 	You run a piece of source code by compiling it. If a header file is
> > protected by the GPL, permission to "run" it means permission
> > to include it
> > in files you compile.

> You don't run source code.  Not even in Perl programs (though there, at
> least, the distinction is more complicated.)
>
> You compile source code.  The resultant object code is then run.

	The way you "run" a program, if that program is in C, is you compile it and
then execute it. If you have the right to "run" a header file (because it
was placed under the GPL), then you have the right to include it in C files
and compile them.

> > 	The phrase "results in a GPL'd program" is one that I
> > cannot understand. I
> > have no idea what you mean by it. You have the right to "run" the header
> > file, the GPL gives it to you. The way you "run" a header file
> > is by first
> > compiling a source code that includes it into an executable.

> Repeat after me: The GPL is a copyright license.  It covers
> distribution, not use.

	Right.

> Distribution of any part of the "work" is
> covered.  Inline functions in headers are clearly part of the "work".

	I'd rather not address two complex issues at once. If we agree that you can
include a header file that is (or is part of) a GPL'd work without to accept
the GPL's terms, we can then go on to address whether you need to accept the
GPL to distribute it. Without the first question understood, it's impossible
to address the second.

> If you have a module that uses an inline function, there are two
> options (note: not two legal options):
> 	Distribute source
> 	Distribute a binary
>
> If you distribute a binary and refuse to provide the source under
> the GPL,
> ask yourself this: What gave you the right to distribute the
> compiled form of the inline functions you use?

	The facts that: Distributing a derived work is not a separate right. I had
the unrestricted right to create the derived work. The recipient of the
derived work is has unrestricted rights to use the original work. The
creation of the derived work is a necessary step in using the original work.

> Note: My use of "inline functions" as a bludgeoning device should not be
> interpreted as an acknowledgement that the rest of the header files
> constitute a published "API".

	Except perhaps under the new DMCA, you can't make it necessary for a person
to violate your copyright in order to use something and then argue that
they've violated your copyright by using that something. This is precisely
equivalent to charging someone who purchased a book with making a copy
without authorization because they bounced a light off the book and produced
a copy on their retina.

	If you have unrestricted right to use a header file, you have unrestricted
right to create derived works consisting of C files that include that header
file and the resulting object code. The question of whether you can
distribute that derived work is a non-issue, there is no right recognized
under copyright (at least in the United States) to restrict the distribution
of derived works, only their creation.

	This will be my final post on this issue. I think I've made my position as
clear as I'm capable of making it. IANAL and have not discussed this with an
attorney. If I had to argue against the GPL in court, this is the line of
argumentation I'd take. Specifically, that you are not bound by the GPL
because everything you've done is use, fair use, and necessary steps for
use, so the GPL's distribution prohibitions don't apply.

	Linus wrote:

>Put another way: nVidia by _law_ has the right to do whatever essential
>step they need to be able to run Linux on their machines. That's what the
>exception to copyright law requires for any piece of software.

	So they need not agree to the GPL to *create* the derived work.

>But what they do NOT have the right to do is to create derivative works of
>the kernel, and distribute them to others.

	Yes, they do. Since they have the right to create the derived work and have
not agreed to the GPL, the only thing that could restrict their distribution
is the law, not the GPL. Please show me the law that permits a copyright
holder to restrict the distribution of derived works.

>That act of distribution is not
>essential _for_them_ to utilize the kernel program (while the act of
>_receiving_ the module and using it may be - so the recipient may well be
>in the clear).

	While he is correct that the distribution itself is not essential for use,
the creation of the derivative work is. However, once a derivative work is
created, no special rights to the *original* work are required to distribute
it to licensees of that original work.

	DS


