Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284918AbRLKHsZ>; Tue, 11 Dec 2001 02:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284925AbRLKHsQ>; Tue, 11 Dec 2001 02:48:16 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51610 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284918AbRLKHsA>; Tue, 11 Dec 2001 02:48:00 -0500
Date: Tue, 11 Dec 2001 00:47:51 -0700
Message-Id: <200112110747.fBB7lpj31524@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: David Weinehall <tao@acc.umu.se>
Cc: "Justin Hibbits <jrh29@po.cwru.edu>"@opus.INS.cwru.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Exporting GPLONLY symbols (Please CC to my email address)
In-Reply-To: <20011211075530.O360@khan.acc.umu.se>
In-Reply-To: <20011210224156.E14022@po.cwru.edu>
	<jrh29@po.cwru.edu>
	<20011211075530.O360@khan.acc.umu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall writes:
> On Mon, Dec 10, 2001 at 10:41:56PM -0500, "Justin Hibbits <jrh29@po.cwru.edu>"@opus.INS.cwru.edu wrote:
> > Umm....I'm a new poster here to the list, but, nonetheless, I have a
> > small complaint about the track the kernel is taking with respect to
> > kernel modules, specifically the exporting of symbols as GPLONLY.  I
> > understand that several hackers are pushing to export many symbols as
> > GPLONLY, which I feel is a very bad idea.  The NVidia drivers will no
> > longer work, and any other module which depends on symbols which will
> 
> The only thing that makes NVidia's drivers troublesome is that they
> are stupid enough not to open-source it. It's their problem though; they
> have to release fixed versions ever so often to keep up with the kernel.
> They won't have any problems with GPLONLY symbols, however, as none of
> the symbols they use are exported as GPLONLY.
> 
> > eventually be exported as GPLONLY will also no longer work.  Do you guys
> 
> Linus specifically stated that no old symbols were to be reexported as
> GPLONLY; only new symbols would be eligible for this.

This looks like it could end up being a FAQ. Hence a new entry:
http://www.tux.org/lkml/#s1-23

> > really want to restrict everyone to using modules licensed under the
> > GPL?  I've read and understand the GPL all too well, and came to the
> 
> Obviously you haven't.
> 
> > conclusion that it's a horrible license to begin with, given the simple
> > fact that Stallman's communist views are in it, forcing everything

Are people still searching for reds under the bed? It's getting pretty
hard to find a communist these days. I'm surprised and amused when I
still hear people using this old term of vilification. Get with the
times, dude! You're now supposed to use the terms "child molester",
"child pornographer", and, to be really hip, "terrorist". What's the
fun in using a term when it doesn't have the same emotional impact?

> Huh? I find nothing communist about the GPL. Rather, it goes along
> pretty well with my liberal views.

Oh, stop being rational! It's so much less fun.

> > licensed under it to be under every future license....with one change to
> > the license, he can claim all source licensed under the GPL.
> 
> No, it doesn't, and he can't. The existance of newer versions of the
> GPL does _NOT_ override the terms in code licensed with the older
> ones; you simply get the _choice_ of which version to choose. In the
> Linux-kernel, however, the default is that the v2 of the GPL is the
> only version valid, unless specifically stated.

Indeed. This has been stated on a number of occasions.

> > I agree with Cox that something has to be done to warn the average user
> > that inserting closed source modules might cause something bad, and you
> > guys can't do anything about it, but FORCING all modules to become GPL
> 
> It doesn't.

And this too has been discussed. I wish people would read the archives
(or even the FAQ) before flaming. But why let facts stand in the way
of a good flame^H^H^H^H^Htroll?

> > is the stupidest idea yet!  Linux is starting to take the road of M$,
> > forcing a one-licensed approach.  Not cool guys.

Not that Linux is trying to shut out proprietary drivers, but if you
believe in the right of a developer to distribute code under a
restrictive proprietary licence, you'd be a hypocrite to suggest that
developers shouldn't distribute under a strict GPL licence. Freedom of
choice means that I get to do things that *I* want but *you* don't.

Or perhaps you just want freedom to control *my* choice?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
