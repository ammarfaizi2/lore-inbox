Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282187AbRLDBwE>; Mon, 3 Dec 2001 20:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282164AbRLDBp5>; Mon, 3 Dec 2001 20:45:57 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:4620 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281880AbRLDBoO>; Mon, 3 Dec 2001 20:44:14 -0500
Date: Mon, 3 Dec 2001 17:55:00 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Donald Becker <becker@scyld.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <Pine.LNX.4.10.10112031239100.978-100000@vaio.greennet>
Message-ID: <Pine.LNX.4.40.0112031722060.1381-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2001, Donald Becker wrote:

> Davide Libenzi (davidel@xmailserver.org) wrote
>
> >And if you're the prophet and you think that the future of multiprocessing
> >is UP on clusters, why instead of spreading your word between us poor
> >kernel fans don't you pull out money from your pocket ( or investors ) and
> >start a new Co. that will have that solution has primary and unique goal ?
>
> I believe that the future of multiprocessing is clusters of small scale
> SMP machines, 2-8 processors each.  And the most important part of
> clustering them together isn't single system image from the programmers
> point of view, it's transparent administration for the end user.  Thus
> our system has a unified process space and a single point of control,
> while imposing no overhead on processes.
>
> You are right that there is no reason to convince people here -- I tried
> to do that a few years ago.  Instead I've put lots of my own time and
> money, as well as investor money, into a company that does only cluster
> system software.
>
> Anyway, my real point is that while I'm a big proponent of designing
> consistent interfaces rather than the haphazard, incompatible changes
> that have been occurring, this is far from predict-the-future design.
>
> The goal of designing the kernel to support 128 way SMP systems is a
> perfect example of the difference.  A few days or weeks of using a
> proposed interface change will show if the advantages are worth the cost
> of the change.  We won't know for years if redesigning the kernel for
> large scale SMP system is useful
>   - does it actually work,
>   - will big SMP machines be common, or even exist?
>   - will big SMP machines have the characteristics we predict
> let alone worth the costs such as
>   - UP performance hit
>   - complexity increase slows other improvements
>   - difficult performance tuning

Don't get me wrong Donald, I like clusters a for a certain type of
applications they fit perfectly and they've a quasi proportional
scalability over the number of computational units.
So, I like clusters.
Quite sadly the real world has applications that cannot be easily fit in a
cluster environment like, for example, heavy threaded applications ( pls
do not start a thread topic from here ) or a more general
share-everything-over-computational-units kind.
Now this kind of design, that we can or cannot call crappy, exist in the
real world and is currently working for a _lot_ of Company's applications
servers.
Now we, as we're all smart guys, know that "work" is GOOD and nobody,
expecially heavy payed managers, is willing to change/rearchitect
something that is currently working.
So these guys are happily running their own application server until one
day they suddendly realize that they need more power.
Now they're going to face a dilemma, that is 1) use a standard
architecture big SMP machine ( high price ) 2) embrace a clustered
solution ( lower price ) having in this way to redesign their application.
I feel quite confortable in excluding SSI for the kind of applications I'm
talking about.
Since I've seen this scenario many many times I'm telling You that, by
followin the 1st theorem of "work" that states that "work is GOOD", our
poor high-salary-senior-manager is going to snatch solution 1 w/out even
thinking about.
No, I do not believe in 128 single CPU SMP machines but, if I've to watch
inside my pretty dirty crystal ball, I see multi-core CPUs as a technology
response to SMP request.
Yes, because after the 1st theorem of "work" there's the 1st lemma of
technology that states that "technology will always follow the
market request".




- Davide


