Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263522AbUJ2WSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUJ2WSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbUJ2WQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:16:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29082 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263597AbUJ2VyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:54:05 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041029214602.GA15605@elte.hu>
References: <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 17:53:55 -0400
Message-Id: <1099086836.1468.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 23:46 +0200, Ingo Molnar wrote:
> correct. softirqs are not used by the sound subsystem so there's no
> ksoftirqd dependency.
> 

I only recommended this because it did seem to make a difference in a
previous version, probably due to debug overhead or something.  It does
not seem like it should.

Lee

