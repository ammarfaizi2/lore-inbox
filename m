Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUEXVZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUEXVZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUEXVZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:25:33 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:40932 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264503AbUEXVZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:25:31 -0400
From: tglx@linutronix.de (Thomas Gleixner)
Reply-To: tglx@linutronix.de
Organization: linutronix
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Date: Mon, 24 May 2004 23:20:20 +0200
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <1YUY7-6fF-11@gated-at.bofh.it> <200405242250.38442.tglx@linutronix.de> <Pine.LNX.4.58.0405241400280.32189@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405241400280.32189@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405242320.20691.tglx@linutronix.de>
X-Seen: false
X-ID: Ee9GHqZZQeLBdT-T+FoH12AWdkALHWJvkGqqw81+gTdZIiTGdRj+0+@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 May 2004 23:05, Linus Torvalds wrote:
> On the other hand, I'd rather have the process be "we always have the
> sign-off", coupled with just plain common sense.

Makes sense

> So I'd rather encourage people to sign off on even the silly stuff, than
> to have to constantly make a judgement call. At the same time, I think
> that if somebody _didn't_ sign off on the simple stuff, we shouldn't just
> run around in circles like hens in a hen-house, we should just say "hey,
> we've got brains, the process isn't meant to be _stupid_".

:)

One more practical point.

Module maintainers receive patches from various hackers and commit them after 
review with the appropriate "sign-offs" to a subsystem repository.

Subsystem maintainer makes his monthly / whatever upstream update. 

Until now he just reviews the total changes from his last update til now. To 
keep your proposed procedure consistent he would be forced now to go through 
the "trusted" step by step commitments of his module maintainers, extract the 
"sign-offs" and add his own "sign-off" to each single step before pushing the 
improvements upstream. 

IMHO it would suffice for this situation, if the "sign-offs" are tracked in 
the subsystem repository and the subsystem maintainer signs off for the 
overall patch / contribution which is sent upstream.

-- 
Thomas
________________________________________________________________________
Steve Ballmer quotes the statistic that IT pros spend 70 percent of their 
time managing existing systems. That couldn’t have anything to do with 
the fact that 99 percent of these systems run Windows, could it?
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

