Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVJCPIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVJCPIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVJCPIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:08:48 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:29960 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751045AbVJCPIs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:08:48 -0400
To: jonathan@jonmasters.org
Cc: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	<35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: or perhaps you'd prefer Russian Roulette, after all?
Date: Mon, 03 Oct 2005 16:08:43 +0100
In-Reply-To: <35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com> (Jon
 Masters's message of "2 Oct 2005 19:53:50 +0100")
Message-ID: <87oe66r62s.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Oct 2005, Jon Masters suggested tentatively:
> Besides, having a *fully* XML parser/generator in the kernel is
> extremely braindead, even if it's called libkernelxml ("I'm not really
> quite in the kernel really") or something. What's so wrong with really
> simple files being exposed to userspace? Most of these are less than a
> single page of data and it's just dandy like that.

I beat off a suggestion last week[1] that the kernel should `not bother
with any of this /proc and /sys stuff' but just export a single vast
heap of XML, because XML is `properly structured'.

(As opposed to, oh, a filesystem, which is apparently not structured
enough.)

Considerations of ugliness and difficulty of implementing the equivalent
of writes to procs files did not shift the twit: but starting top on a
busy system and showing said twit the CPU load spikes as /proc/[0-9]*
got iterated over, and asking `how severe would this be if *all* of
/proc and /sys had to be generated for every single request?' seems to
have imparted enough clue.


I have a large notice by my desk at work reading simply `XML is not a
panacea'. It's amazing how few people wandering by read it.


[1] by someone who couldn't have implemented it in a month of Sundays,
    thankfully

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
