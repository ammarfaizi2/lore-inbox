Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTBTQeu>; Thu, 20 Feb 2003 11:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTBTQet>; Thu, 20 Feb 2003 11:34:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39327 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265863AbTBTQeq>;
	Thu, 20 Feb 2003 11:34:46 -0500
Date: Thu, 20 Feb 2003 17:44:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201743270.30865-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:

> Ok, this is definitely a stack overflow:

> Does anybody have an up-to-date "use -gp and a special 'mcount()'
> function to check stack depth" patch? The CONFIG_DEBUG_STACKOVERFLOW
> thing is quite possibly too stupid to find things like this (it only
> finds interrupts that overflow the stack, not deep call sequences).

i had CONFIG_DEBUG_STACKOVERFLOW on, but i'll make it more agressive. It's
fairly easy to reproduce the oops. (at least it was when i was trying to
avoid them :-)

	Ing

