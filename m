Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVIXFC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVIXFC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 01:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVIXFC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 01:02:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35775 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751413AbVIXFC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 01:02:28 -0400
Date: Sat, 24 Sep 2005 07:03:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
Message-ID: <20050924050305.GA29052@elte.hu>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509221816030.3728@scrub.home> <1127464041.24044.809.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509232258270.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509232258270.3728@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Fri, 23 Sep 2005, Thomas Gleixner wrote:
> 
> > Each network connection, each disk I/O operation arms a timeout timer to
> > cover error conditions. Increasing the load on those increases the
> > number of armed timers. At the same time this increased load keeps the
> > timers longer active as it takes more time to detect that the "good"
> > condition arrived on time.
> 
> You're still rather vague here...

as i said before, millions of timers are easily possible, and i 
personally saw in excess of 16 million active timers. I hope there was 
nothing vague about that ;-)

	Ingo
