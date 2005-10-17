Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVJQJ36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVJQJ36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVJQJ36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:29:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58782 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932226AbVJQJ35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:29:57 -0400
Date: Mon, 17 Oct 2005 11:29:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20051017075917.GA4827@elte.hu>
Message-ID: <Pine.LNX.4.61.0510171054430.1386@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509301825290.3728@scrub.home> <1128168344.15115.496.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
 <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005, Ingo Molnar wrote:

> the thing is that Thomas has advanced the whole issue of timeouts and 
> timekeeping by leaps and bounds and he has written thousands of lines of 
> new and excellent code for a kernel subsystem that has seen little 
> activity for many years, before John got involved. One of Thomas' 
> accomplishments is a timer/time design that allows the enabling of HRT 
> timers via an _18 lines_ architecture patch. (!)

Did I say these patches were bad in general? All I'm asking for is an 
explanation for a few design decisions to understand the patch and its 
behaviour better and evaluate alternative solutions.
Neither of you have shown any real interest in this so far.

> the moment you express yourself via patches we'll know that 1) you 
> understand what we have done so far 2) you have useful ideas of what 
> should be done differently 3) you have the coder capability to implement 
> and test those ideas. Patches wont be ignored, i can assure you. Get the 
> patches rolling!

This "shut up and show code" attitude is sometimes quite funny, but it's 
no real threat to me. I hoped to avoid this and solve this more civilized. 
Of course I'll understand the issues better afterwards, but you could as 
easily just tell me. It will waste my time, I could spend on other 
projects and it will put Andrew in the unfortunate position to decide, 
which patch to accept.
Is this really what you want?

bye, Roman
