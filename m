Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318071AbSFTAKz>; Wed, 19 Jun 2002 20:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318072AbSFTAKz>; Wed, 19 Jun 2002 20:10:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1008 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318071AbSFTAKy>; Wed, 19 Jun 2002 20:10:54 -0400
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020620000751.GI22262@dualathlon.random>
References: <Pine.LNX.4.44.0206200123470.25434-100000@e2>
	<1024530423.917.21.camel@sinai>  <20020620000751.GI22262@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 17:10:52 -0700
Message-Id: <1024531852.917.29.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-19 at 17:07, Andrea Arcangeli wrote:

> obviously not. Supporting 4G cpus is enough for this century, so the
> other 32bit would be just wasted space. the 1 in the shiftleft needs the
> UL anyways to be correct with >32 cpus (it's not strictly a bug right
> now to forget the UL but if we get it right we'll be able to go 64-way
> on 64bit systems with no change other than NR_TASKS). So the bitmasks
> must be all unsigned longs, the cpu numbers are definitely fine as
> unsigned ints.

Eh, very true.  I was confusing the bitmasks and the counts.

Sorry, Ingo - ignore me.

	Robert Love

