Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVG1LyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVG1LyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVG1LyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:54:24 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:18657 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261404AbVG1LyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:54:20 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, "K.R. Foley" <kr@cybsft.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050728072210.GA20055@elte.hu>
References: <Pine.OSF.4.05.10507271852030.3210-100000@da410.phys.au.dk>
	 <1122485137.29823.109.camel@localhost.localdomain>
	 <20050728072210.GA20055@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 28 Jul 2005 07:53:56 -0400
Message-Id: <1122551636.29823.209.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 09:22 +0200, Ingo Molnar wrote:

> nitpicking: i guess the answer also depends on what the precise 
> requirement is. If the requirement is 'run for 4 seconds every 10 
> seconds, uninterrupted, else the power plant melts down', i'd sure not 
> make the washing machine process the higher priority one ;-)
> 
> (also, i'd give the power plant process higher priority even if the 
> requirement is not as strict, just from a risk POV: what if the washing 
> machine control program is buggy and got into an infinite loop 
> somewhere.)

Doug also said that you're an idiot if you run a washing machine from
the same computer you run a nuclear power plant from :-) 

The point that he was making though is that if you want a system that
runs without flaws, you don't always prioritize the same way the real
world would prioritize.  You need to do it with math.

-- Steve


