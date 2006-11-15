Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030847AbWKOSsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030847AbWKOSsR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030867AbWKOSsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:48:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15526 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030863AbWKOSsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:48:15 -0500
Date: Wed, 15 Nov 2006 19:46:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mikael Pettersson <mikpe@it.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061115184655.GA5748@elte.hu>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061112212941.GA31624@flint.arm.linux.org.uk> <20061112220318.GA3387@elte.hu> <20061112235410.GB31624@flint.arm.linux.org.uk> <20061114110958.GB2242@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114110958.GB2242@elf.ucw.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1230]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > I wasn't talking about in-flight IO.  Take a moment to think about 
> > it.
> > 
> > - You have a floppy inserted and mounted.
> 
> Notice that Ingo is not talking about floppy being mounted.

yeah. I was thinking in terms of "mdir a:".

if a floppy is mounted then i agree that suspending is probably a bit 
too much to expect from the kernel - but this particular bug affects 
normal mtool use (which you can think of to be equivalent to mounting, 
using and then umounting the floppy).

	Ingo
