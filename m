Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289051AbSAPKoA>; Wed, 16 Jan 2002 05:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290397AbSAPKnl>; Wed, 16 Jan 2002 05:43:41 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:34712 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289051AbSAPKnj>; Wed, 16 Jan 2002 05:43:39 -0500
Message-Id: <200201161043.g0GAh01g019103@tigger.cs.uni-dortmund.de>
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
In-Reply-To: Message from Andrew Pimlott <andrew@pimlott.ne.mediaone.net> 
   of "Tue, 15 Jan 2002 07:29:58 EST." <20020115072958.A7900@pimlott.ne.mediaone.net> 
Date: Wed, 16 Jan 2002 11:42:59 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott <andrew@pimlott.ne.mediaone.net> said:

[...]

> It's just as easy in principle to write a friendly front-end that
> downloads sources and compiles them, as one that downloads binaries.

That it is _possible_ do do so doesn't mean it is _worthwhile_. I do trust
Red Hat's binaries (because of QA), there is reasonable support for them to
correlate bug reports, etc. I _don't_ trust kernel.org sources, at least
not for production use. Sure, I fool around with them on my machines. There
they have eaten a few filesystems, some crashed on boot, others were
useless.

Aunt Tillie (and Nephew Mervin, and the whole bunch of relatives) present a
support (i.e., distribution and people) problem. They are _production_, not
_experiments_. Sure, we could mandate that kernels from the stable series
go through rigurous QA before being posted. Progress would slow to a crawl,
the fun of hacking Linux would soon be over, and so would be Linux. Or
there would be trhee branches: Production quality, stable, and
experimental. Next you know, Uncle Eric would then demand autobuilding for
Aunt Tillie from the stable (or even experimantal) branch for updated
driver for the Foomatic 37.

Autobuilding *is here*, *right now*. It is called "distribution's kernel",
aided by something hacked up a time ago called "modules" and "autoloading".

As techies we always try to find a technical solution to problems, but
there are problems where the best solution isn't technical at all. It is
organizational, education, setting up a support network, ... There are even
problems that _have_ no technical solutions. Or even problems that have
perfectly adequate non-technical solutions right now, which we overlook.

> The obstacle is reliability, because there are more things that can
> go wrong.

Bingo! With a binary, the vendor _knows_ what was shipped, and has checked
that configuration to death. With autoconfiguration this is probably the
_only_ copy of that particular configuration on the whole world. And
Point&Drool Nephew Mervin is supposed to find out why it doesn't boot
today. Forget about eyeing Penelope, he won't have time for that.
-- 
Horst von Brand			     http://counter.li.org # 22616
