Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSIITm1>; Mon, 9 Sep 2002 15:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318809AbSIITm1>; Mon, 9 Sep 2002 15:42:27 -0400
Received: from waste.org ([209.173.204.2]:58082 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318795AbSIITmZ>;
	Mon, 9 Sep 2002 15:42:25 -0400
Date: Mon, 9 Sep 2002 14:47:07 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020909194707.GB31597@waste.org>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com> <alg3ct$pru$1@abraham.cs.berkeley.edu> <20020909165303.GA31597@waste.org> <alik0a$70c$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alik0a$70c$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 04:58:50PM +0000, David Wagner wrote:
> 
> Whether you like it or not, you're already trusting Intel, if you're
> using an Intel chip.  If Intel were malicious and out to get you, they
> could have put a backdoor in the chip.  And a RNG is *much* easier to
> reverse-engineer and audit than an entire CPU, so it would probably be
> riskier for Intel to hide a backdoor in the RNG than in, say, the CPU.

Not sure I buy that. Consider that with a CPU, you control the inputs,
you've got a complete spec of the core functionality, you've got a
huge testbed of code to test that functionality, and you've got a
whole industry of people reverse engineering your work. 

More to the point, the backdoor we're worried about is one that
compromises our encryption keys to passive observers. Doing that by
making the RNG guessable is relatively easy. On the other hand
determining whether a given snippet of code is doing RSA, etc. is
equivalent to solving the halting problem, so it's seems to me pretty
damn hard to usefully put this sort of back door into a CPU without
sacrificing general-purpose functionality.

For other types of back doors, it seems likely that the NSA would go
straight to the OS vendor, or, given the state of mainstream OSes,
just use existing holes.

> >What right-thinking paranoid would place any faith in an analysis with
> >an Intel copyright? This is practically marketing fluff anyway.
> 
> Marketing fluff?  I take it that's a joke: I wish the marketing fluff
> I get had this much technical content and documented its experimental
> procedure like this.

Yes, I was being hyperbolic. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
