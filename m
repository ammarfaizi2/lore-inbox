Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbQKJT7P>; Fri, 10 Nov 2000 14:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbQKJT6z>; Fri, 10 Nov 2000 14:58:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51983 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131663AbQKJT6n>; Fri, 10 Nov 2000 14:58:43 -0500
Date: Fri, 10 Nov 2000 11:56:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: jt@hpl.hp.com
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dagb@fast.no>
Subject: Re: The IrDA patches !!! (was Re: [RANT] Linux-IrDA status)
In-Reply-To: <20001109192404.B25828@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.10.10011101143330.990-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Nov 2000, Jean Tourrilhes wrote:
> 
> 	I spent my full day going through my archives and splitting
> the big patch of Dag into lots of small patches (see attached). I'm
> glad I've got a big hard drive full of junk.

When I say multiple mails, I mean multiple mails. NOT "26 attachements in
one mail". In fact, not a single attachment at all, please. Send me
patches as a regular text body, with the explanation at the top, and the
patch just appended.

Why?

Attachements may look simple, but they are not. I end up having to open
each and every one of them individually, remembering which one I've
checked, save them off individually, remembering what the file name was,
and then apply them each individually.

See the picture? Attachements are evil. 

In contrast, imagine that you (and everybody else) sends me plain-text
patches, with just an explanation on top. What do I do?

I see the explanation immediately when I open the mail (ie when I press
the "n" key for "next email").

I can save it off with a simple "s../doit", which saves it in _one_ "doit"
file appended to all the other pending stuff. Alternatively, I can skip
it, or leave it pending, and let the _mail_software_ remember whether I
answered that particular patch.

I can reply to it individually, and that patch (and nothing else) will be
automatically set up for the reply so that I can easily quote whatever
parts I want to point out.

I can apply all the patches that I have approved with a single

	patch -p1 < ~/doit

without having to go through them individually.

None of the above works with attachments. 

> > Basically, if you send me a big patch with tons of changes, how the hell
> > DO you expect me to answer them? Does anybodt really expect me to go
> > through ten thousand lines of code that I do not know, and comment on it?
> > Obviously not, as anybody with an ounce of sense would see.
> 
> 	If somebody send you 1000 lines in one go or as 100 times 10
> lines, it doesn't matter, it is still 1000 lines of code to read
> through. Even small patches can be totally obscure for somebody not
> familiar with the code and what it is supposed to do.

You are WRONG.

10 emails with 1000-line patches are _much_ easier to handle. I can
clearly see the parts that belong together (nothing is mixed up with other
issues), and I can keep the explanation in mind. I do not have to remind
myself what that particular piece is doing.

It has other advantages too. With a single 10000-line patch, if I don't
like something, I have a hard time just removing THAT part. So I have to
reject the whole f*cking patch, and the person who sent it to me has to
fix up the whole thing (assuming I'd bother answering to it, poitning out
the parts that I don't like from the large patch, which I will not).

With 10 1000-line emails, I can decide to apply 8 of them outright, apply
one with comments, and discard one that does something particularly
nauseating. And I can much more easily explain to the submitter which one
I hate, without having to edit it down.

See?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
