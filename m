Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTEZVYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 17:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTEZVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 17:24:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2437 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262228AbTEZVYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 17:24:39 -0400
Date: Mon, 26 May 2003 18:35:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Willy Tarreau <willy@w.ods.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <20030526212902.GA13550@alpha.home.local>
Message-ID: <Pine.LNX.4.55L.0305261830180.29936@freak.distro.conectiva>
References: <1053732598.1951.13.camel@mulgrave> <20030524064340.GA1451@alpha.home.local>
 <1053923112.14018.16.camel@rth.ninka.net> <Pine.LNX.4.55L.0305261541320.20861@freak.distro.conectiva>
 <20030526212902.GA13550@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 May 2003, Willy Tarreau wrote:

> On Mon, May 26, 2003 at 03:42:42PM -0300, Marcelo Tosatti wrote:
>
> > Splitting up the work with someone is senseless, IMO. As I said before,
> > 2.4.22-pre should be better in that aspect. In case it doesnt, I'm giving
> > up 2.4.x maintenance.
>
> Marcelo,
>
> Reading your words, I have the sad feeling that you take no interest in doing
> this job, and that you do it only because people ask you to. What a shame :-(
>
> Although it sure can be annoying, aren't you proud of each new release ?
> Usually, kernel integrators are proud of their new kernels when they get
> something rock solid ! People like Con Kolivas, J.A.Magallon, Marc-Christian
> Pettersen are often proud to announce us the few bits they changed in their
> tree and which stabilized it. It seems you only do this as an obligation,
> which is sad, really.

What I said is that if people think I'm not maintaining 2.4.x (quoting
Davem, "I really think 2.4.x development is becoming almost non-existent
lately.) in a acceptable way, the work should be done by someone else. I
WANT to keep maintaining 2.4, but only if people are happy with that. Do
you understand ?

> I understand that maintaining the stable tree, the one which MUST NOT FAIL,
> may be frustrating, not being as excitant as playing with kernels which try
> to get the most of every piece of hardware, as others do (although nobody
> prevents you from developing your own Wolk). But you don't seem to share much
> about your feelings, ideas or doubts with others. Alan, for example, exchanges
> a lot with people testing his kernels, suggesting a few tweaks to help them
> workaround their problems, and integrating the tweak in the next release if it
> succeeds. This fast feedback allows him to release more often. It also makes
> his work more intersting for others.

> People often prefer "here is -rcxx-acxx, which my EPIA now fully
> supports" to "here is -rcxx, please test it extensively".

I dont understand what you mean.

>
> Perhaps you don't feel assurance when you have to blindly integrate hundreds
> of patches from people you don't always trust, and that may explain why you
> suddenly announce a new pre-release and keep silent, hoping for patch authors
> to reply to questions if any ? If this is the case, jump into the train,
> there's no risk, except of being caught by Rik's troll-o-meter, or having Viro
> or hch insult you ! And then ? What's the matter ? Every one has his turn. I
> even risk it with this OT mail. When you started with 2.4.16, you said that you
> were afraid you lacked some skills, but you proved to be very capable, because
> the kernel has moved since, and 2.4.21 should be far more stable than 2.4.16 !
>
> This mail is not intended to give you any lesson, but to give a feedback from
> a Linux 2.4 user who, as many others, feels more and more forgotten by his
> maintainer. Unfortunately, what David wrote is what many people currently think
> of 2.4 :-( You threatened to give up, but that would be bad for your image
> and for Linux.
>
> Giving up means no maintainer for a certain amount of time, then
> a self-proclamed new maintainer (or worse, several ones with a tree fork).
> Being replaced is cleaner, since you do the job until the new maintainer is
> ready to start.
>
> If you don't have enough time to do everything, send a source quench, or apply
> one of David's proposed solutions : ask for some help so that only subsystems
> maintainers feed you as some already do (eg: David, Jeff, Greg), or ask for a
> pure replacement. If you're bored, that I could understand, because having to
> deal with arrogant and sometimes even selfish users is not always pleasant,
> ask for a replacement. If you're fed up with patches that you don't understand,
> reject them LOUDLY asking for more documentation. And if you plan to have a
> rest for two weeks, say it, so that people don't send you patches that will be
> lost in a full mailbox at your return. Yes, this may be what Linus did before
> you, when people already complained. But there should be a middle line between
> how he managed his kernel and how you manage it, and BTW, Linus clearly stated
> that maintaining 2.4 bored him.
>
> I've just read your mail about -rc[45]. I'm happy we start to see the light at
> the end of the 2.4.21 tunnel. As others people, I'm now impatient to both 2.4.21
> and 2.4.22-pre1. BTW, as discussed perhaps a year or two ago, you could have a
> preview of 2.4.22-pre1 in parallel with 2.4.21-rc, to feed the impatients,
> although that may be double work, which you don't necessarily need at the
> moment.
>
> And remember, please communicate, communicate, communicate. You and only you
> know what problem you have at a given time. If you don't communicate, people
> always imagine the worst.
>
> Regards,
> Willy
>
