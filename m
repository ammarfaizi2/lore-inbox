Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSHIQ2T>; Fri, 9 Aug 2002 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSHIQ2T>; Fri, 9 Aug 2002 12:28:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51463 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S314514AbSHIQ2S>; Fri, 9 Aug 2002 12:28:18 -0400
Date: Fri, 9 Aug 2002 13:31:52 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <E17dCQa-0001Nv-00@starship>
Message-ID: <Pine.LNX.4.44L.0208091328240.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2002, Daniel Phillips wrote:
> On Friday 09 August 2002 17:56, Linus Torvalds wrote:

> > Also, I think the jury (ie Andrew) is still out on whether rmap is worth
> > it.
>
> Tell me about it.  Well, I feel strongly enough about it to spend the
> next week coding yet another pte chain optimization.

Well yes, we've _seen_ that 2.4 -rmap improves system behaviour,
but we don't have any tools to _quantify_ that improvement.

As long as the only measurable thing is the overhead (which may
get close to zero, but will never become zero) the numbers will
continue being against rmap.  Not because of rmap, but just
because the overhead is the only thing being measured ;)

Personally I'll spend some more time just improving the behaviour
of the VM, even if we don't have tools to quantify the improvement.

Somehow there seems to be a lack of meaningful "macrobenchmarks" ;)

(as opposed to microbenchmarks, which can don't always have a
relation to how the performance of the system as a whole will
be influenced by some code change)

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

