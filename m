Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbUJ1NQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbUJ1NQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbUJ1NQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:16:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39047 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263051AbUJ1NPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:15:10 -0400
Date: Thu, 28 Oct 2004 15:16:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041028131622.GA13744@elte.hu>
References: <20041023194721.GB1268@us.ibm.com> <417F12F1.5010804@opersys.com> <20041026212956.4729ce98.akpm@osdl.org> <20041027081044.GA14451@elte.hu> <4180DF18.5060808@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4180DF18.5060808@opersys.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> >with -RT-V0.3 i get lower than 20 usec _maximum_ latencies during
> >'./hackbench 20'. (the average latency is 1 usec) So while i'm not yet
> >in the sub-femtosecond category, things are looking pretty good in
> >PREEMPT_REALTIME land :)
> 
> Just curious: what's the setup here? (CPU speed, peripherals, distro,
> applications being run to load the system, etc.) [...]

2 GHz Athlon running stock Fedora Core. './hackbench 20' was the
workload.

> I'm assuming that the timings are measured using the tracing
> functionality currently in the patches.

no, i used a user-space timing app called 'realfeel', but the numbers
were corroborated by the in-kernel tracer too.

but ... the best test would be if you tried the patch, it's not hard ;)
There are newer versions since i did the above measurement and testing
feedback is always welcome.

	Ingo
