Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269878AbRHNTMd>; Tue, 14 Aug 2001 15:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269866AbRHNTMN>; Tue, 14 Aug 2001 15:12:13 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:52219 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S269875AbRHNTMI>; Tue, 14 Aug 2001 15:12:08 -0400
Date: Tue, 14 Aug 2001 12:25:34 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: Francois Romieu <romieu@cogenit.fr>
Subject: Re: Are we going too fast?
Message-ID: <Pine.LNX.4.20.0108141219001.769-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PinkFreud <pf-kernel@mirkwood.net> :
> [...]
> > The unthinkable has happened - it locked up again.  Same problem.  No
> > keyboard, no mouse, no display, no network.  It was as far gone as
> > possible.
> 
> Is the nmi_oopser (Documentation/nmi_watchdog.txt) inefficient here ?

>From Documentation/nmi_watchdog.txt:
NOTE: currently the NMI-oopser is enabled unconditionally on x86 SMP
boxes.

I'm not specifically enabling it in LILO, but according to the docs, it's
enabled already.  Unfortunately, the lockup happens when switching between
virtual consoles, so even if something WERE printed to the screen, I'm unlikely
to see it.

Side note: The lockup does *NOT* occur on 2.2.19 with SMP.

> Ueimor


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

