Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284885AbRLFAVs>; Wed, 5 Dec 2001 19:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbRLFAVk>; Wed, 5 Dec 2001 19:21:40 -0500
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:45814 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284879AbRLFAQL>; Wed, 5 Dec 2001 19:16:11 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rob Landley <landley@trommello.org>
To: =?iso-8859-1?q?Ra=FAlN=FA=F1ez=20de=20Arenas=20Coronado?= 
	<raul@viadomus.com>,
        esr@thyrsus.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Wed, 5 Dec 2001 11:14:16 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16BKL5-0001yJ-00@DervishD.viadomus.com>
In-Reply-To: <E16BKL5-0001yJ-00@DervishD.viadomus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011206001610.OQGR485.femail3.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 December 2001 01:30 pm, RaúlNúñez de Arenas	 Coronado wrote:
>     Hi Eric :))
>
> >(2) Requiring Python introduces another tool into the requisites list for
> >kernel building.
>
>     I'm happy to see that out of your 'silly' list...
>
> >I'm just going to say "Today's problems, today's tools."
>
>     Hey, hope that Python never gets considered a 'today's tool' or
> we will end up needing 256 CPU mainframes just to issue an 'ls'

And you've been smoking what to come to this conclusion?  My laptop's a 
pentium 266, and it runs stuff just fine.  (My DESKTOP is a pentium pro 
180...)

You can't attack the performance of the current implementation of CML2, so 
you attack python's performance generically.  Makes perfect sense.

You are aware that what it's replacing in this instance is, in large part, 
shell scripts?  Hello?

You may also want to look at the python-SDL binding, which people have used 
to write action games in python.  (Really.  http://www.pygame.org )

> (maybe this will not be enough if filesystem drivers are written in
> Python too. In the future, I mean...).
>
>     And yes, Python is a today's problem. Fortunately, people keeps
> rewriting their Python code in true languages. 

Ah, you've rediscovered nixon's silent majority, then?  The mysterious "they" 
who always conveniently support your arguments.

Personally, I'm re-writing other stuff in python.  I'm currently working 
(microscopically part-time) on a python nameserver because bind is 
frightening and djbdns is annoying, and it looks like a simple one in python 
should only be a few hundred lines of code.

Are you volunteering to rewrite Anaconda in C?

> >Progress happens.
>
>     Python is not progress, is just bloatware. I don't think that the
> kernel *building* should be made dependant on such a fatware. And,
> how about the 'Python License'.

The most recent version of which is, I believe, GPL compatable.

> I'm pretty sure that it is compatible
> with the rest of the kernel, but we should pray for it not to change.

If a new vesion comes out with an unusable language the project will fork 
into free and non-free versions like dozens of projects before it, several of 
which ARE in the kernel.  You know this, you're just ignoring it.

>     And, well, Python is fatware just for me: anyway will see
> reasonable to install a 6Mb sources language just for the
> configuration of the kernel.

The sources of which already take 260 megs, not counting the space to 
actually compile them or the tools needed to do so now.  (And then if you 
want to look at the source code to those other tools...  Look at glibc ye 
mighty and despair...)

> Very reasonable.

Yes.

> >If you don't like it, feel free to go back to writing Autocoder on your
> > 1401.
>
>     Good policy... People who don't like Python are morons... And
> maybe those that neither use Java or C# for the kernel will be too in
> a near future,

You're confusing "writing the kernel in $LANGUAGE" with "using a tool written 
in $LANGUAGE to build the kernel".  Replace $LANGUAGE with C++ and go search 
the archives to see this boundary previously deliniated...

> is that what you're trying to say?

Well, at least you admit you don't know.  There's hope.

>     Eric, I think that this is an important issue and that the
> decision about adding such a big dependence to the kernel should be
> studied with care, and not imposed.

Why start now?

The kernel tree currently uses perl and tcl/tk.  Anybody remember those being 
debated at length before they went in?  Anybody volunteering to MAINTAIN perl 
code?  (A write-only language?)

Eric's stated that there's a net reduction in the number of dispirate tools 
needed to configure the kernel.  There's certainly less in terms of lines of 
code...

Have you ever looked at the current configurator mess? 

>     Raúl

Rob
