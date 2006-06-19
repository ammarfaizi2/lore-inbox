Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWFSWco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWFSWco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWFSWcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:32:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41435 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964958AbWFSWcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:32:22 -0400
Date: Tue, 20 Jun 2006 00:25:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060619222528.GC1648@openzaurus.ucw.cz>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619202354.GD26759@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Try it. I have had
>  > broken plastic heat-sink hold-downs let the entire heat-sink fall off
>  > the CPU. The machine just stops.
> 
> Your single datapoint is just that, a single datapoint.
> There are a number of reported cases of CPUs frying themselves.
> Here's one: http://www.tomshardware.com/2001/09/17/hot_spot/page4.html
> Google no doubt has more.
> 
> Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
> (as in broke in two pieces) under extreme heat.
> 
> This _does_ happen.

If it happens to you... you needed a new cpu anyway. Anything non-historical
*has* thermal protection.

BTW I doubt those old athlons can be saved by cli; hlt . (Someone willing to try if old
athlon can run cli; hlt code w/o heatsink?).

And no, we probably do not want to enter C2 or C3 from doublefault handler.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

