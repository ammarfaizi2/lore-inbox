Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVFHQwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFHQwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVFHQvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:51:11 -0400
Received: from opersys.com ([64.40.108.71]:23311 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261364AbVFHQk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:40:29 -0400
Message-ID: <42A721F9.2070608@opersys.com>
Date: Wed, 08 Jun 2005 12:51:05 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>,
       RTAI-Users <rtai@rtai.org>
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050608022646.GA3158@us.ibm.com>
In-Reply-To: <20050608022646.GA3158@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

I've finished reading your summary and I must say that it's excellent.
I don't remember ever reading a non-partisan comparison of this level
on the issue of real-time and Linux. Thanks for writing _and_ having
the guts to post it :)

There is only one issue I would like to further highlight.

Note: None of the following should be in any way controversial, I'm
just providing further background.

Paul E. McKenney wrote:
> the corresponding approach's strengths and weaknesses.  I do not address
> "strength of community", even though this may well be the decisive factor.

Indeed what you state here is entirely true. While Adeos and RTAI
development has been very active for quite a few years now, it must
be said that this development has largely gone unnoticed to LKML
participants -- as was obvious by the amount of surprise caused by
the realization of the existence of key Adeos and RTAI features.

Part of this is historical. 10 years ago, Linux's state was such
that those who were interested in doing rt with it realized that
it wasn't about to become rt-capable any time soon. Hence, they
"went away" and did their own little thing. They had their mailing
lists, their own flame-wars, their own conferences, and there was
very little common shared with the mainstream LKML community.

In fact, for a very long time, most kernel developers I spoke to
about real-time would refer back to a single project, RTLinux. To
this day, actually, if you look in the MAINTAINERS file, it still
says:
> RTLINUX  REALTIME  LINUX
> P:      Victor Yodaiken
> M:      yodaiken@fsmlabs.com
> L:      rtl@rtlinux.org
> W:      www.rtlinux.org
> S:      Maintained
Yet, the days where RTLinux was _the_ real-time Linux extension
are long gone and www.rtlinux.org has been a redirect to a .com
site for quite some time now -- I've suggested in the past that
this entry be replaced by RTAI, but I was told that neither should
in fact be in there, which is fair-enough, but nothing came of
this suggestion and the entry is still in the maintainers file.

This state of things remained until May 2002 when I picked up on
a post by Andrea to point out a "few" problems the RTAI community
saw with the RTLinux project. The ensuing thread was remarkably
intense -- not for the faint of heart. Here's the root of it if
you're ever interested in reading a huge flame-fest:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102227589127072&w=2
While that discussion did serve to put RTAI on the map for some
developers, it also highlighted problems with the RTAI project
that needed to be solved.

Part of the issues was the patent problem, and that was solved
with the introduction of Adeos. However, with this and other
problems solved, the RTAI developers went back the way they came
from: to their own separate mailing lists.

In the past few years, though, a new bread of real-time developers
have become interested in making Linux fit for real-time
applications. Unlike the previous generation, though, these folks
have concentrated their efforts on working within the framework
already agreed upon by existing kernel developers: the LKML. And
in that, they have achieved a level of awareness amongst the kernel
crowd that I think RTAI and Adeos have not yet reached.

I've tried to remedy to this situation as best I can, by pointing
out what was obvious to me when appropriate. However, it must be
said that I haven't been actively involved with either Adeos or
RTAI in quite some time. So while I did play a part in the
history of both projects, there are others that are in a much
better position than I am to present to the LKML the work done
by the RTAI and Adeos communities.

In essence, therefore, what I have to say is this:
- To those who are actively involved in the development of RTAI
and Adeos, now is the time to drop the historical tendency of
acting as an entirely separate community and to start sharing
your work on the LKML.
- To those who are actively involved in finding solutions to the
real-time issues in Linux, do not be fooled by the apparent lack
of activity in the Adeos or RTAI projects, they are both very
active and warrant consideration.

As you correctly state, "strength of community" is likely a decisive
factor. What is important here is not to confuse "apparent" strength
of community -- or lack thereof -- with "actual" strength of
community -- or lack thereof.

Thanks again for a great piece.

Karim Yaghmour
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
