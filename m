Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUJ3Qsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUJ3Qsz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUJ3Qsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:48:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:36321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261215AbUJ3QsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:48:14 -0400
X-Authenticated: #15156664
Message-ID: <001b01c4bea0$492dce40$8511050a@alexs>
From: "Alexander Stohr" <alexander.stohr@gmx.de>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: <airlied@gmail.com>, <kendallb@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>
References: <1098806794.6000.7.camel@tara.firmix.at> <015101c4bde1$1051bce0$8511050a@alexs> <9e47339104102916141019bd23@mail.gmail.com>
Subject: Re: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?]
Date: Sat, 30 Oct 2004 18:48:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments inline...

From: "Jon Smirl" <jonsmirl@gmail.com>
> The best way to make this work would be to get ATI, nVidia, IBM and
> Intel into a room and do a cross licensing deal on the interface
> portion of the designs.

Unless there is some benefit for them i dont expect them to spent any efforts 
on a think like that. They are stock based companies and act this way.

Some of them do dominate a market. If news are correct then nVidia has 
lost a not that small market share in the last 12 month so they are less likely
to even turn their closed linux driver business (that is closed for years) into
open source. Publishing old specs is not very likely, publishing new specs
is much less likely in such a situation. They are reall not a wellfare organisation.

On the other hand, ATI realy does not want to give nVidia or Intel
or any other sort of startup any sort of clues where there is space
for chip design improvement or where there are trapdoors when
implementing a specific grafics standard. They dont want to hint
others in designing better chips for sole comercial reasons.
Unlike main processors, grafic chips just need a driver - but they
dont need large scale information for user programmability.

> If the four companies also enter into a mutual
> defense pact that will stop any third parties from causing trouble.

That wont stop anything out there from sueing one after another, 
winning a few battles and then and receiving a multi million dollar 
payment from those big ones any now and then.

> On the other hand, this strategy doesn't work if you are currently,
> knowingly violating an existing valid patent.

It is much more the case that tons of patents are valid but you have
spent tons of research on the chip development as well, so the problem
of finding a case of infrignment before starting up with production is
a "N x N" problem which results in the need for checking some
million a-to-b-match cases with an intelligent human. You never 
ever can make sure, so you better not publish at all.

> Keeping things secret does nothing to protect you from a patent
> infringement suit. All it does is make it a little harder to initially
> detect that there are grounds for one. Once someone files suit they
> will use the legal process to get all your secret designs anyway.

If you publish anything then its just a nice reader and all is open.
If nothing is published then anthing needs much effort to get unveiled,
so the average time between two infrignment discoverys is significantly
different in its magnitude. Sorry, we are in a closed age of grafics
technology, its long ago when IBM sent out exhautive chip and board 
docu with its IBM-PC deliverys.

> I also question if keeping interfaces secret is gaining anyone any
> advantages over the competitors. Everyone involved possess an
> excellent engineering staff capable of easily figuring out what the
> other groups are doing. GPUs compete on functional units, chip
> processes, parallelism, marketing and manufacturing cost, not on the
> device driver programming model.

If you are a big-fish company then it is easy, but consider the startups.
As grafics business turned into a head to head show, there is good
reasons for the two heads to not raise the danger of changing anything
with that. Both heads are located in North America, but who would
ever stop for e.g. china from deploying its very own grafics company?

Compare to the situation in about 1995 where there was really much
of duplicate development, call it overhead, which was just a nasty
but it never really impacted market. Other things indeed did.
Hardware 3D was one major aspect that changed the situation
so that it was highly important to protect the small advantages
and this situation still has not changed.

If you really want an open source grafics standard, then you have
to launch your very own chip project. This will get you into the
state of beeing a hardware vendor and then you can check if it
is that easy. But be warned, others with much more comercial
backgrounder have failed already, like bitboys and their kyro.

> My belief is that everyone involved would gain from contributing to a
> common pool of code for Linux. I don't believe that doing this is
> going to alter anyone's market share; but it will make the users a lot
> happier and breed goodwill for all involved.

Drivers never were common code. Driver code is the mediator
between proprietary hardware and a general software interface.
It is okay to find generally needed resources and interfaces,
such as the AGP-gart does represent it, but it all fails where
some chip vendor is bound to its existing designs which tend to
be unique compared to any other vendors design. At least those
hardware does want that much different code that it rarely makes
sense to merge in any other dirver code. Look at the DRI codebase
and you will see a bunch of kernel modules, each for another user
space driver. If there were so much in common then there would
have been never a code split or already a merge between those code.

I do understand that you do want to have open source drivers for
all grafics hardware, maybe even in a unified form, but that does
conflict with the other vital interests of market oriented companies.

May i mention the for characters "S3TC" here?
It was long time clear how to implement and that it was know to be
implemented in an academic fashion for personal interest and research.
And then the debate ran for a longer time on how that could get 
implemented into DRI without getting the project and the users
into the legal danger of getting sued for patents infrignment.
On one hand it was so simple to resolve that technically, on the other
hand it was nearly impossible to integrate the solution into a release.

But the big fish companys of graphics business do have a license
and therefore only they were in state to release respective drivers.
OpenSource had no license and therefore felt impossible to merge
that. So even if some, many or all of the secrets of todays graphics 
chips would get published, there is still the question if it will ever be
open source and free software than. The industry is multi connected
trough its patents cross licensing, the OS/FS is not connected to 
that network and it does not look like it would ever be.

Open source must find its very own way - hoping that suddenly
something rather boosting will happen is not really a likely thing.
Not that you should stop asking for getting specs and documentation
but if it were all that easy and with no risk and no impact to other
sensitive aspects of the companys business - i am sure it would
have happened then. As it dont happens, assume there are such 
cases of possible bad impact, and none must of them must be
related to intentional patents infrigment, as long even the unintentional
can have the very same rather deep impact. Further the concurrency
battle is nothing that has suddenly ended in that market jsut because
the amount of market participants has massivly diminished and 
even the danger of a new company entering the market still exists.

You have to understand how stock based companies do operate
in order to see why they do behave as they do behave towards
you and towards other open source programmers, but even to
the rest of the world. Their business is not done wellfare reasons.

-Alex.

