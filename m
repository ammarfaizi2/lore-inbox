Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132843AbQLJCtN>; Sat, 9 Dec 2000 21:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbQLJCtE>; Sat, 9 Dec 2000 21:49:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13041 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132843AbQLJCsq>;
	Sat, 9 Dec 2000 21:48:46 -0500
Date: Sat, 9 Dec 2000 21:18:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E144r5r-0005iI-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0012092014550.896-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Alan Cox wrote:

> > > <shrug> From what I've seen in GNOME it's mostly about avoiding pipes
> > > religiously and putting everything and a kitchen sink into the same
> > > process. I'm not saying that it has no valid uses, but it definitely
> > > had contributed to the bloat in case of GNOME.
> > > 
> > 
> > Please consider to read this article 
> > especially the section about unix pipes...
> > 
> > http://www.helixcode.com/~miguel/bongo-bong.html
> > 
> > Maybe this changes your view of the problem.
> 
> If you needed a demonstration that Miguel does not get Unix that URL you cited
> is the favoured one 8)

Oh, that hardly counts as news. Both the Miguel's, erm, persuasion and
his arguments themselves.

It's a real shame that nobody had shown him polymorphic typed functional
languages. Imagine Genera-like environment with LML instead of LISP and
G-machine as the engine. _That_ has plumbing power at least equivalent
to shell. And yes, it can very well use CORBA for talking to G-machine.
I would prefer something like 9P, though. Moreover, it can easily
incorporate normal scripting. But use of strongly-typed glue without
polymorphism... Ew. There is a reason why scripting languages are not
done that way.

If you are trying to design an OS you might as well try to make it
simple and elegant...

BTW, gotta love the argument about UI consistency as a reason to make
everything monlithic - one might think that separating UI code from
the payload one would simplify making the former consistent, just
by virtue of having less code to take care of... Especially since
UI programmers tend to be, well, a distinctly separate bunch.

What came as real surprise was the defense of bloat. No, not the fact
in itself, but general, erm, disdain to logics. "People say that X is
bad since it has property P. But Y also has that property, Y runs on
UNIX, so P is OK". Especially since Y is a bunch of really crappy programs,
most of them either of non-UNIX origin or emulating non-UNIX ones.
Logics: F-. Rethorics: D, and that's being bloody generous...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
