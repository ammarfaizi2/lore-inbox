Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269107AbTBXDkE>; Sun, 23 Feb 2003 22:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269108AbTBXDkE>; Sun, 23 Feb 2003 22:40:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55490 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269107AbTBXDkD>;
	Sun, 23 Feb 2003 22:40:03 -0500
To: davidm@hpl.hp.com
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Minutes from Feb 21 LSE Call 
In-reply-to: Your message of Sun, 23 Feb 2003 15:59:12 PST.
             <15961.24656.733807.819204@napali.hpl.hp.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3076.1046058578.1@us.ibm.com>
Date: Sun, 23 Feb 2003 19:49:38 -0800
Message-Id: <E18n9cZ-0000ng-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003 15:59:12 PST, David Mosberger wrote:
> >>>>> On Sun, 23 Feb 2003 15:06:56 -0800, "Martin J. Bligh" <mbligh@aracnet.com> said:
>   Martin> Got anything more real-world than SPECint type
>   Martin> microbenchmarks?
> 
> SPECint a microbenchmark?  You seem to be redefining the meaning of
> the word (last time I checked, lmbench was a microbenchmark).
> 
> Ironically, Itanium 2 seems to do even better in the "real world" than
> suggested by benchmarks, partly because of the large caches, memory
> bandwidth and, I'm guessing, partly because of it's straight-forward
> micro-architecture (e.g., a synchronization operation takes on the
> order of 10 cycles, as compared to order of dozens and hundres of
> cycles on the Pentium 4).

Two major types of high end workloads here (and IA64 is definitely
still in the "high end" category).  There are the scientific and
technical style workloads, which SPECcpu (of which CINT and CFP are
the integer and floating point subsets) might reasonably categorize,
and some of the "system" workloads, such as those roughly categorized
by things like TPC-C/H/W/etc, or SPECweb/jbb/jvm/jAppServer which
exercise some more complex, multi-tier interactions.

I haven't seen anything recently on the higher level System bencmarks
for IA64 - I'm not sure that anyone is doing much that is significant
in this space, where IA32 results practically saturate the overall
reported results.

I know SGI is generally more interested in the scientific and
technical area.  I would assume that HP would be more interested
in the broader system deployment, except that too much activity in
that area might endanger parisc sales.  IBM is doing some stuff in
the IA64 space, but more in IA32 and obviously PPC64.  That leaves
NEC and a few others that I don't know about.  It may be that IA64
isn't really ready for the system level stuff or that it competes
with too many entrenched platforms to make it economically viable.

But, I would be really interested in seeing anything other than
"scientific and technical" based benchmarks for IA64.  I don't think
there is much out there.  That implies that nobody is interested in
IA64 or that it doesn't perform "competitively" in that space...

gerrit
