Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUJZR4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUJZR4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUJZR4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:56:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32205 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261364AbUJZRzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:55:42 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
In-Reply-To: <1098812749.5615.15.camel@cmn37.stanford.edu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com>
	 <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu>
	 <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu>
	 <20041025160330.394e9071@mango.fruits.de> <20041025141008.GA13512@elte.hu>
	 <20041025141628.GA14282@elte.hu>
	 <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>
	 <1098759671.9166.10.camel@krustophenia.net>
	 <1098767513.2926.3.camel@cmn37.stanford.edu>
	 <1098811515.10048.5.camel@krustophenia.net>
	 <1098812749.5615.15.camel@cmn37.stanford.edu>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 13:55:41 -0400
Message-Id: <1098813341.10048.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 10:45 -0700, Fernando Pablo Lopez-Lezcano wrote:
> > AFAIK there is nothing you can do - any other irq that fires on 9 will
> > mask out all the others until it completes.
> 
> Yes, except I did not see all these xruns running 2.4.26 + lowlat +
> preempt (same machine). Things got better with 2.6.x up to, perhaps, S7,
> although I would have to retest to make sure. Now they seem to be worse
> than before. 

Hmm, interesting.  Anyway T3 is the last version that was stable for me,
this is the xrun-free standard that I compare the later ones to.

Lee




