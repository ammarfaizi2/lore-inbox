Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSEYEdG>; Sat, 25 May 2002 00:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSEYEdF>; Sat, 25 May 2002 00:33:05 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:44816 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S313477AbSEYEdC>; Sat, 25 May 2002 00:33:02 -0400
Message-ID: <3CEF139A.1572367C@opersys.com>
Date: Sat, 25 May 2002 00:31:22 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205241440210.28644-100000@home.transmeta.com> <3CEEC729.74625C2B@opersys.com> <20020524162228.D28795@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Larry McVoy wrote:
> Eben Moglen is the lawyer for the FSF, right?  So he's hardly objective
> about this topic, right?  Isn't his point to try and get everything to
> be GPLed?

As I said, the FSF and Eben's public message are not the entire story,
but only part of it.

> So?  Eben is not objective on the topic, FSMlabs holds the patents, if you
> listen to what Eben says, that's meaningless.  He is not a judge, he is not
> objective, he's got a particular ax to grind.  That's fine, except for one
> thing: he doesn't hold the patent.  So if you are going to listen to anyone,
> I'd be listening to FSMlabs.

Exactly, so would I. Except that they haven't been very verbose. All we
ever got from them  was "speak to your lawyer". Sure that's fair enough,
but my entire point is: This uncertainty and lack of clarity is hurting
Linux very badly.

> > One last thing: Clearly, if non-GPL applications were not allowed
> > with Linux, we wouldn't be talking today. The same holds for non-GPL
> > RT apps.
> 
> Ahh, I get it.  I think I see the problem.  You are applying GPL rules
> to the RTLinux patent.  You're saying that the boundary where the patent
> applies stops at the same place as the boundary where the GPL stops.

Not really. I'm saying that Linux is in deep-shit (sorry for the wording)
because of this patent and until someone gets rid of it, other OSes will
be chosen instead of it.

It matters little whether I look at this from the copyright perspective
or from the patent perspective. What I'm trying to highlight is that the
current real-time Linux patent/copyright situation is killing Linux in
an entire application field.

It doesn't matter if we agree/disagree with any of the players involved,
whether it be me, Victor, the FSF, Moglen, Linus, or God konws who. What
I'm pointing out is that the current situation is killing Linux in an
entire application field and that it needs to be sorted out.

> I'll bet that is the cause of all the confusion.  The patent and the
> GPL have no correlation.  It's completely up to FSMlabs to define what
> is an application and what is not.  And it's a very reasonable thing
> for them to consider everything which runs on top of the RTLinux substrate
> to be required to be covered by the GPL.  That's certainly within their
> rights.

It most certainly is. I have no disagreement with you there.

>  You can't take the GPL rules and impose that on his patent
> license, the two have nothing to do with each other.  He who holds
> the patent makes the rules.

Again, I agree. I don't question any of this and I perfectly understand
the copyright/patent laws involved.

> I think the bottom line is that the RT idea that Victor came up with is
> pretty cool,

Well, here I disagree. "came up with" is very strong wording. Care to
look at a paper by Stodolsky, Chen, and Bershad entitled "Fast Interrupt
Priority Management in Operating System Kernels" published in 1993 as
part of the Usenix Microkernels and Other Kernel Architectures Symposium.
That is one paper that describes the software emulation of interrupts.

In fact, this paper is so crucial to RTLinux that Barbanov writes the
following about it in his masters thesis:
"It turns out that using software interrupts [23], together with several
other techniques, it is nevertheless possible to modify Linux so as to
overcome these problems. The idea to use software interrupts so that a
general-purpose operating system could coexist with a hard real-time
system is due to Victor Yodaiken (personal communications)."

Curiously, though, this paper is recognized by Barbanov as a pilar of
the RTLinux technique, it is never mentionned in the literature reference
to the patent.

> it is obviously something that you want, and so you get to
> live with those rules.  Listening to a lawyer's opinion, when that
> lawyer works for the FSF and is charged with furthering the cause of
> the FSF, that's just asking for trouble.  He isn't going to give you
> an unbiased view.  I think Victor's suggestion is good - if you want to
> know what the rules are, consult your own lawyer.

I have no problem consulting the lawyer. What I am saying is that
developers who have to fear being sued over their use of an OS
because of loose patents will simply avoid using the OS altogether
and stick with the established OSes who never got anyone in trouble
(or, at least, the majority of people).

> As someone who's been down this path pretty extensively, I do not think
> that you are seeing it clearly, you are mixing the patent and the GPL
> and you are not entitled to do that.  FSMlabs has to play by the GPL
> rules for any modifications they make to the kernel, but you have to
> play by their rules if you use their patent.  You can't apply the GPL
> rules and expect those to override the patent rules, it doesn't work
> like that.

Thanks for taking the time to explain, but I think the issues go
far beyond copyright and patent applicability. The issues goes to
the heart of developers' perception of a technology. Today, most
developers who take a deep look at using Linux for real-time apps
simply avoid it. We can choose to look at this from whichever
perspective we want. The bottom line is that Linux is just no being
used in those apps. And the one main reason we got to this is the
existence of the patent. As simplistic as it may sound, take the
patent away and the entire problem disappears. No more fuss about
GLP/non-GPL and no more fuss about which abstraction is allowed,
processes, kernels, modules etc.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
