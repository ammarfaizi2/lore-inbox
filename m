Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVJDNrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVJDNrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVJDNrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:47:07 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:17309 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932431AbVJDNrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:47:07 -0400
Date: Tue, 4 Oct 2005 09:47:05 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051004134705.GQ7949@csclub.uwaterloo.ca>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net> <20051003015302.GP6290@lkcl.net> <20051003181924.GB8011@csclub.uwaterloo.ca> <20051004125354.GO10538@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004125354.GO10538@lkcl.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 01:53:54PM +0100, Luke Kenneth Casson Leighton wrote:
>  you elaborate, therefore, on my point.
> 
>  anyone else, therefore, cannot hope to compete or even enter the
>  market, at 90nm.
> 
>  which is why the first VIA eden processors maxed out at 800mhz (i'm
>  guessing they were a 0.13micron and therefore 2.5 volts)

Sticking with 0.13 also seems to make for a better embedded processor
since it seems when you go to 0.09 or smaller it becomes nearly
impossible to run at high and low temperatures which is what some
embedded applications want (like -40 to +85C).  We had to change compact
flash suppliers when our supplier went to 90nm since they said their new
process couldn't work reliably at industrial temperature anymore.  If
VIA wants the eden to run at a wide temperature range, it appears they
are better off sticking to a larger process and keeping the cpu speed
down to something reasonable.  I imagine at some point someone will
manage to make a 90nm chip that does handle bigger temperature ranges
but I haven't seen one yet myself.

>  you lend weight to my earlier points: the push is to
>  drive the engineers towards less gates on the excuse of
>  cart-before-horsing the market with their "performance / watt"
>  metrics, such that if 0.65nm comes off it's less painful
>  and not too much of a jump, and they aim for more parallel
>  processing (multiple cores).

If that was the goal the x86 architecture should be dumped.  It spends
too many gates converting x86 junk into something reasonable to execute.
People don't appear very eager to dump the x86 unfortunately.  Something
to do with backwards compatibility and such.

>  current  : 200 million gates with 90nm at 1.65 volt
>  estimated: 40 million gates with 65nm at 1.1 volt
>  estimated: 1 million gates with 45nm at 0.9 volt.

A 1 million gate chip at 45nm would be rather tiny.  The yield would
probably be amazingly good.  Of course if it does give off a lot of heat
you still have the problem of how to get rid of the heat given it is
focused in a very very small space.  Of course just reducing the size of
the cache on intel's chips to something sane would reduce the gate count
enourmously.  But that won't happen until they make a more efficient
chip.

>  the "off" voltage of a silicon germanium transistor is 0.8 volts.
> 
>  at 45nm the current leakage is so insane that the heat
>  dissipation, through the oxide layer which covers the chip,
>  ends up blowing the chip up.

Unless someone finds a way to reduce the leakage.  It is worth a lot of
money to some companies to solve that problem after all.

Len Sorensen
