Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286834AbRLVSMd>; Sat, 22 Dec 2001 13:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286835AbRLVSM1>; Sat, 22 Dec 2001 13:12:27 -0500
Received: from mail1.eznet.net ([209.105.128.6]:14860 "HELO mail1.eznet.net")
	by vger.kernel.org with SMTP id <S286834AbRLVSMO>;
	Sat, 22 Dec 2001 13:12:14 -0500
Message-ID: <3C24CD00.CD3EF09@eznet.net>
Date: Sat, 22 Dec 2001 13:12:17 -0500
From: "David A. Frantz" <wizard@eznet.net>
Reply-To: wizard@eznet.net
Organization: just me
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17
In-Reply-To: <3C23988D.47A96760@ixiacom.com> <Pine.LNX.4.33.0112212203460.1184-100000@fargo> <sr182u8fptii0ptu44s0uvrhafn44hoi8a@4ax.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone;

At this point I'm not a kernel developer, most likely never will be, but I do
use linux exclusively.    So from that perspective here are my comments for
consideration.

At some point in the development of a new kernel there must be an emphasis on
quality and reliability.   I personally do not see how it is even possible to
release a "final" kernel revision with only one or two days testing.
Granted everyone expects a new kernel series to have a few issues upon
release, but once the ** in a 2.4.** kernel move past 10 it really is time to
think quality.

Realizing that excessive time spent on quality issues would lead to many
delays, I'd like to suggest that the third dot number use an odd even
numbering system to seperate the heavly tested kernels from the heavily
modified kernels.    In other words all pre-kernels leading up to a 2.4.18
kernel would be aimed at stabilizing the code and quality.    When this is
done the pre-kernels for the 2.4.19 series would aim to oimplement the more
major changes that everyone wants or needs.

I'd to be able to pick up a kernel from www.kernel.org and have some
confidence that it will work correctly without extensive patching.    The idea
that vendors can supply us with a heavily tested kernel is, to me anyways,
against the spirit of the whole community.    After all there are many fly by
night Linux distributions, a stable kernel available from www.kernel.org would
go a long way to maintaining these sort of systems.

Now this may seem a bit demanding but consider this.    If the users of this
list did not have prior knowledge of the kernels available on www.kernel.org
how would they know which ones to avoid totally, which ones are OK, and which
ones seem to be well done?    Its really a shame that we need to talk about a
stable kernel this way, on the other hand due to reading this list I
understand how the various revisions came about.   The problem, as I see it,
is that there were to many kernels released before everything stabilized.
If your implementing or testing new technology them by all means release a
pre-kernel, a patch against a stable kernel, or a technology specific
pre-kernel (such as the -aa releases) but lets not go on with throwing out
grossly buggy release kernels.   Even if it takes months, release a kernel
that for most people will work.

I hope these comments are helpful.    Like I say Linux is the only thing that
I use at home, I really want it to succeed.   So for the 2.4.** kernel lets
concentrate on quality, it would be nice to know that from now on each new
kernel release is beter than the one before it.

Thanks
dave


John Alvord wrote:

> On Fri, 21 Dec 2001 22:09:09 +0100 (CET), "David Gomez"
> <davidge@viadomus.com> wrote:
>
> >
> >> > final:
> >> >
> >> > - Fix more loopback deadlocks                   (Andrea Arcangeli)
> >> > - Make Alpha with Nautilus chipset and
> >> >   Irongate chipset configuration compile
> >> >   correctly                                     (Michal Jaegermann)
> >> >
> >> > rc2:
> >> >
> >> > - Fix potential oops with via-rhine             (Andrew Morton)
> >> > - sysvfs: mark inodes as bad in case of read
> >> > ...
> >>
> >> Um, what happened to the idea of 'no changes between the last
> >> release candidate and final'?
> >
> >I think the policy is 'not to add unnecessary changes' , not 'no changes'.
> >
> >> I'm disappointed; I thought we were entering a new era of
> >> release discipline in the stable kernel.
> >
> >I'd be dissapointed if Marcelo had released and stable kernel still
> >with the loopback deadlocks. And i don't think the alpha compile fix is
> >going to break anything.
>
> One possibility would be to release 2.4.17 and 2.4.18-pre1
> simultaneously, with the otherwise last minute changes. There have
> been so many brown-bag bugs introduced by the last changes, there
> everyone is or should be nervous. Immediately launching the next -pre
> series will help keep the momentum moving while preserving the more
> certain knowledge of the quality of the last -rc level.
>
> john alvord
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

