Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbUJ3XPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUJ3XPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUJ3XOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:14:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1739 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261406AbUJ3XM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:12:56 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041030233849.498fbb0f@mango.fruits.de>
References: <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
	 <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu>
	 <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu>
	 <20041030214738.1918ea1d@mango.fruits.de>
	 <1099165925.1972.22.camel@krustophenia.net>
	 <20041030221548.5e82fad5@mango.fruits.de>
	 <1099167996.1434.4.camel@krustophenia.net>
	 <20041030231358.6f1eeeac@mango.fruits.de>
	 <1099171567.1424.9.camel@krustophenia.net>
	 <20041030233849.498fbb0f@mango.fruits.de>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 19:12:54 -0400
Message-Id: <1099177974.1441.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 23:38 +0200, Florian Schmidt wrote:
> While there's no way to deterministically force missed irq's by window
> wiggling [we should make it olympic discipline :)], UI action seems to raise
> the probability somewhat.
> 

OK, I am seeing the exact same results.  They are so close to yours that
I am not going to bother posting them.  UI activity does seem to trigger
missed IRQs - if I switch to my mail window or Mozilla and back to the
test I see that 4 or 5 IRQs in a row got skipped.  So maybe context
switching triggers the bug.

Lee

