Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318301AbSGYCkV>; Wed, 24 Jul 2002 22:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318305AbSGYCkV>; Wed, 24 Jul 2002 22:40:21 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:16138 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318301AbSGYCkU>; Wed, 24 Jul 2002 22:40:20 -0400
Date: Wed, 24 Jul 2002 19:43:27 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Message-ID: <20020725024327.GF26787@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net> <20020725022454.A8711@unicyclist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725022454.A8711@unicyclist.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 02:24:54AM +0200, Daniel Mose wrote:
> What bothers my self a bit more in the kernel context, and thus 
> makes me an even more eager "Kernel alienate" than I believe Rob
> to be, are the "atomic_" calls/functions and their semantic origin.
> I believe that every Unix has "atomic_" calls all though perhaps 
> differently designed. And I totally fail to understand why some 
> one decided to name theese functions "atomic_"

It is from the Greek
	a -- not
	tomos -- cuttable

I think it was Aristotle who theorized the existance of the
atom.  He described it by discussing an apple.  You can cut
an apple in half. each piece you can cut in half again.
Eventually you would get to a piece, invisibly small, that
could not be cut in half.  That was his atom.

Of course scientists assigned the term to something that
could indeed be split.  Of course you know what happens when
you split the atom...

In programming we describe as atomic any action that cannot
be split (a read(2) from a serial device cannot return just 3
bits) or an action containing multiple sub-actions that if
split/interrupted causes breakage.  If you interrupt an
atomic_* it will set of a chain reaction and the OS will
explode :)

> 
> To my own thinking, the atomical parts of any process in a 
> computer are puny little switches that are mostly referred to as 
> bits, and theese bits have all the software support they can get 
> even with out any "atomic_" call. I don't find anything even 
> remotely close to an electron microscope within Unix either.
> So I fail. 
> 
> Perhaps you Rob can clear me out on this one though? I mean: 
> You have actually managed to endure, being a kernel alienate 
> for a much longer time than I can hope for my self.
> 
> Other words in this ML (and in too many other places =( ) that
> make my own brain go rivetted and short circuit are the "foo" 
> and/or "bar", not to mention the "foobar" place holder.
>  
> I realize that most folks In LKML use "foo", "bar" and it's dad,
> "foobar" with outmost joy and that there is complete and utter 
> understanding of what the "foos" and "bars" actually stand for 
> in your contemporary discussion partners reasoning scheeme. 
> 
> Or is it? 
> 
> Some times I notice that people who write pseudo code find good 
> replacer words which actually explain the place holders function 
> context, where the average linux kernel posters simply puts their
> "foo","bar" or "foobar" But I have yet Not noticed this horrificly
> effective way of clarifying ones intentions anywhere in the postings
> to the linux kernel mailing list. Therefore I conclude that you must
> all be telepathic phenomenons, or that you have all found some other
> odd or mysterious way of mentally tuning in the intentions of your 
> contemporary discussion partners. 

The terms foo, bar, foobar, sna, etc in psuedocode stand for
"something having a name" We use them in places where the
actual name doesn't matter for the sake of the discussion.
The "good replacer words" can often be almost-real or
unintentially real name and cause confusion or divert the
functional discussion into a discussion (argument) over
names.  They are sometimes also used to mean "you make up a
name that has meaning for your purpose".

Once in a while though FUBAR and SNAFU are used in their
classic naval-derived sense.  such as when a certain POTUS
told the world that a grave government agency error was a
SNAFU implying that such erros were "Situation Normal".


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
