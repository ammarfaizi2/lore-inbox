Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSHITLx>; Fri, 9 Aug 2002 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSHITLx>; Fri, 9 Aug 2002 15:11:53 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58377 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315607AbSHITLw>; Fri, 9 Aug 2002 15:11:52 -0400
Date: Fri, 9 Aug 2002 16:15:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: yodaiken@fsmlabs.com
cc: Daniel Phillips <phillips@arcor.de>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <20020809114050.A23656@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.44L.0208091613000.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2002 yodaiken@fsmlabs.com wrote:
> > On Fri, 9 Aug 2002, Rik van Riel wrote:
> > One problem we're running into here is that there are absolutely
> > no tools to measure some of the things rmap is supposed to fix,
> > like page replacement.
>
> But page replacement is a means to an end. One thing tht would be
> very interesting to know is how well the basic VM assumptions about
> locality work in a Linux server, desktop, and embedded environment.
>
> You have a LRU approximation that is supposed to approximate working
> sets that were originally understood and measured on < 1Meg machines
> with static libraries, tiny cache,  no GUI and no mmap.

Absolutely, it would be interesting to know this.
However, up to now I haven't seen any programs that
measure this.

In this case we know what we want to measure, know we
want to measure it for all workloads, but don't know
how to do this in a quantifyable way.

> L.T. writes:
>
> > Read up on positivism.
>
> It's been discredited as recursively unsound reasoning.

To further this point, by how much has the security number
of Linux improved as a result of the inclusion of the Linux
Security Module framework ?  ;)

I'm sure even Linus will agree that the security potential
has increased, even though he can't measure or quantify it.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

