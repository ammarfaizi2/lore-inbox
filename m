Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316793AbSE1PXZ>; Tue, 28 May 2002 11:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSE1PXY>; Tue, 28 May 2002 11:23:24 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:23049 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S316793AbSE1PXV>; Tue, 28 May 2002 11:23:21 -0400
Message-ID: <3CF3A009.E7320E98@opersys.com>
Date: Tue, 28 May 2002 11:19:37 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: linux-kernel@vger.kernel.org
Subject: Re: A reply on the RTLinux discussion.
In-Reply-To: <57.c083d0f.2a237c49@aol.com> <20020527123643.9297A11973@denx.denx.de> <20020528060406.A18344@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Victor for taking the time to go through some of the issues.

yodaiken@fsmlabs.com wrote:
> 1. MYTH: "The acceptance of Linux in embedded is being harmed by uncertainty over
>     intellectual property"
> 
>         This is not correct from what I can see. Our customers include
>         several Fortune 500 companies, and an incredible range of smaller
>         companies around the world. The use of the free GPL RTLinux is hard
>         to quantify, but we from all indications it is enormous. There are
>         multiple mirrors, and we still had to limit download bandwidth on our
>         site to 1G/day.
> 
>         Our resellers and OEM partners include some of the most serious
>         players in the embedded Linux business:  LynuxWorks, RedSonic, and
>         Red Hat.

That is your own assesment, which is of course somewhat biased since I
don't see you coming out and telling us: "True, the market has a problem
with my patent." This standpoint is the only one expected. But given
that you are not the only vendor out there, others have testified on this
list that indeed Linux has a hard time penetrating in the embedded/rt
market precisely because of your patent.

I will leave it to the average LKML reader to decide whether the problems
I discribe are "myth" of "fact" in light of all the testimony presented on
this list.

Also, you omit to explain why the 11,000 developers sampled by the VDC
point "real-time limitations" as their #1 show-stopper for using Linux.

>         And most of embedded Linux use does not require hard real-time.

You're trying to play the "niche" trick here, pointing out that your patent
is OK because it's a niche market. As I pointed out very early in this thread,
embedded/rt is far from being a niche.

>         This issue is perhaps based on problems seen by
>         the people who are yelling so loud - although I do not doubt that
>         all the yelling does put off some potential adopters.

So are you suggesting that we all line up behind you and shut up?

>         There are also some issues particular to RTAI technology and
>         support that we believe will put off adopters: an API in flux,
>         no solid commercial support, stability issues and so on.

This is a non-issue. A couple of vendors already provide commercial
support for RTAI. But read what an article in Embedded Systems Programming
had to say about this issue in May 2001:
<quote>
In my opinion, RTAI provides a more practical API while RTLinux is more
elegant. On the other hand, RTAI is more elegant in how it integrates
into the Linux kernel. The RTAI team makes a constant effort to add
features that people ask for, and thus its API has grown to become
reasonably extensive. For example, RTAI includes clock calibration,
dynamic memory management for realtime tasks, LXRT to bring soft/hard
real-time capabilities into user space, remote procedure calls, and
mailboxes.

The RTLinux team aims to keep their real-time Linux extensions as
predictable as possible, adding only features that won't hurt designs
and compatibility in the future. In short, the RTLinux API is more
consistent, but many practitioners prefer to use RTAI.
</quote>

Seems to me that RTAI is the prefered choice.

>         RTLinux is doing very well and there is no uncertainty about
>         it. If other variants are not doing well, there are other reasons.

Well, it's clear that we won't agree on this statement.

> 2. MYTH "The patent license is a terrible burden and terribly vague".
>         The real dispute here has very little to do with the
>         patent itself, and a great deal to do with GPL "linking".
>         Linux itself permits binary modules and is generally pretty
>         relaxed about what you can do to the kernel. But for companies
>         like FSMLabs, Namesys, Trolltech, MySQL, and for many other
>         GPL developers - controlling the right to add non-GPL components
>         to our code is a business fundamental. Behind all the rhetoric
>         of "I'm only in this for the greater glory of free-software" from
>         our die-hard opponents, you find the demand to be allowed to make
>         derivative works that incorporate non-GPL code - without payment of
>         any fee.

FSMLabs cannot be compared in any way to any other open source company:
I can rewrite Qt and distribute it under the license I like
I can rewrite MySQL and distribute it under the license I like
I can't rewrite RTLinux and distribute it under the license I like

As for your dismissal of the "motivation behind the act", it does not
dismiss any of our arguments, but only reinforces them.

>         Robert Schwebel has made the issue quite clear on occasion, by
>         arguing that in the embedded controller world, the valuable IP
>         often is _required_ to be tightly integrated into the base real-time
>         system. I think he is partly right, but this is precisely the
>         advantage we have as owners of the core RTLinux copyright.

Your ownership over the entire core RTLinux still remains an open question.

>         The patent license is absolutely clear: GPL software can
>         use the patented method without payment of any fee. So
>         any dispute is on when one can use non-GPL software as a
>         component - and in many respects the
>         the real-question is whether the Linux binary module exception
>         can be imposed on everyone else.
>         In the dispute with our
>         RTAI friends, most admit that RTAI derives from the RTLinux
>         code base.

So does RTLinux derive from work on RTAI. The arguments nullify each
other here.

> Given this, the absence of a patent would not
>         solve the problem that Schwebel sees: it would still not be
>         permitted to link binary modules into the derived program without
>         our permission.  RTAI "user space"  to me, does not escape this
>         issue.

Wait. Are you saying here that the GPL in a module extends to "user space"?

>         All that said: we're not against making allowances for small support
>         companies: ask.

Thanks for the offer, I am sure some will find it useful, but the larger
issues remain.

> 3. Although most RTAI developers agree that RTAI started from the RTLinux
>    code base, this issue keeps being obscured.  In the Linux tradition:
>   the code is definitive. If you look at
>     ftp://ftp.llp.fu-berlin.de/LINUX-LAB/RTAPPS/paolo/
>   you can see most of the history of RTAI, from "myrtlinux 0.6" which
>   is openly billed as a variant of RTLinux 0.4  - note the peculiar copyright
>   statement.
> 
> There is certainly a lot
> more there than modified RTLinux, but whatever the virtues or lack
> thereof of this extra material, the absence of any of the RTLinux developer
> copyright notices in RTAI is noteworthy.

So is the inverse.

> 4. The point of the argument.
> It is is obviously not worth arguing with people like David Schleef
> who can baldly assert that RTAI predated RTLinux and did not fork from it.
> 
> Karim Yahgmour writes that he has
> asked the same questions over and over and not received a response.
> The tactic of asking questions that are really insinuations is
> to me an indication of the ethics of the questioner.

If my questions are "far off" or if my insinuations are misleading, then
it should be rather easy to dismiss every single of them. As for my
ethics, I leave this for people who actually know me to judge. That being
said, this is not the first time you use personnal attacks against me. First,
you dismissed my opinions because you thought I had made no open source
contributions, then you said that my opinion were "for sale" because I
had done some work for Lineo (remarkably my opinions have not changed
although Lineo entered in agreement with you), then you said I was a
nutcase, and the list goes on and on. But then again, you're the one
who said the following during one of earlier discussion:
"All of us who have actually developed commercially significant GPL software
have to spend too much time explaining to customers that Slashdot crazies
and other freelance zealots have no standing and nothing to do with us."

To which I replied:
"It strikes me as odd that you may find it to marginalize "Slashdot crazies"
and "other freelance zealots" when you owe them, at the very least, your
current bread and butter. This is rather ungrateful and condescending at
best.

Others who have come to make money out of GPL software have taken the
time to explain to their clients what this mosaic of characters is all
about and why it is so important to Open Source and Free Software."

My point of view regarding your personnal attacks against every single
person who disagrees with you run somewhere along those lines.

> "Questions" of the
> form "did you steal XYZ code?" asked in the absence of any evidence are
> not  questions, they are a dishonest way of damaging a reputation.
> 
> Q:Why is there no copyrighted material in RTLinux from Paolo Mantegazza?
> A: Because none of his code was incorporated.
> Q: Did we take Wolfgang Denk's MPC860 patches?
> A: No. Why would we? Cort and I shipped working code for MPC860/Linux
>    as our first consulting project, long before FSMLabs existed.
> Q: Are other people allowed to contribute code to RTLinux?
> A: Learn how to use FTP.  The answer is yes.

Fine, then reread my other question regarding those contributions. Has
no one ever contributed any code to RTLinux? If no one has then RTLinux
is certainly not an open source project. If someone has, then why do
the headers contain only the name of FSMLabs? Why are those 20 persons
named in the credits file credited for anyway? Why do people who have
worked for you readily recognize that code has been exchanged between
both RTLinux and RTAI?

> Q: Various questions implying shabby treatment of Michael Barabanov.
> A: Karym has been "asking" such "questions" for years. In all that time
>    he has refused to take my suggestion that he ask Michael whether Michael
>    appreciates this effort.

Hmm... If I disagree with something you're doing, I usually tell you
without you asking. If Michael dislikes what I'm doing, he's got my
email address.

I ask questions about Michael because it really seems incongruent that
this project which was implemented by one of the students you were
supervising is now entirely in your hands and that you are the single
author on the patent although, as you said in your own article, he took
it from concept to implementation all by himself while adding concepts
you hadn't thought of.

BTW, my first name is actually "Karim", with an "i", the "karym" thing
used to be my login. "Karim" is actually the french translation of
my (clearly) arabic name which means "generous". It's often spelled as
"Kareem" in english because that's how it sounds like in the original.

> and so on. It's both annoying and tedious.

Fine, if it's so annoying and so basic, why don't you answer those
questions and get rid of them once and for all?

Note that you didn't answer the most important questions of all #1 and #2.

> As for the requests for legal advice: Yahgmour has been playing Internet
> lawyer and encouraging people to sue us for a long time.

I don't remember "encouraging people to sue" you. If I did, it would be
a mistake. What I did do, however, is point out that there is serious
potential for this given the presence of foreign copyrighted material
belonging to outside contributor, as can be seen my looking in the
credits file and as recognized by your own people.

As for the patent issue, then yes, I have been intensively researching
every aspect about how this patent can be dismissed and presenting those
to the public. At this point, I think it is more than obvious that it
can be dimissed. Anyone wanting to pick this up can now do so without my
help. I still do have a couple of other facts which can help in this
regard, but I won't post these here.

BTW: "Yahgmour" isn't my last name, it's "Yaghmour", which means
rain in turkish. That "Yahgmour" doesn't mean anything.

> The presence he
> makes to simply be asking for information is as believable as the rest of his
> pitch.

Very early on, I pointed out that this sort of argumentation is called "sophism".
Dimissing me != dismissing my arguments.

Notice that I haven't dismissed you. I have argumented every point you
brought forth and you have not answered a singled email by me.

For all your personnal attacks against me Victor, you have yet to
dismiss my main claim.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
