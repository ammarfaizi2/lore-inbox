Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263458AbUJ3DJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbUJ3DJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ3DJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:09:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54459 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263458AbUJ3DJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:09:26 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <20041029163135.1886d67f@mango.fruits.de>
References: <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
	 <20041027135309.GA8090@elte.hu>
	 <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
	 <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu>
	 <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
	 <20041028063630.GD9781@elte.hu>
	 <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
	 <20041028085656.GA21535@elte.hu>
	 <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
	 <20041028093215.GA27694@elte.hu>
	 <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
	 <20041029163135.1886d67f@mango.fruits.de>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 23:09:24 -0400
Message-Id: <1099105764.1504.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 16:31 +0200, Florian Schmidt wrote:
> i tried a V0.5.2 with PREEMPT_REALTIME and all debugging off (config
> attached). I cannot reproduce your results. I have experienced around 30
> xruns in 10 minutes. And big ones, too (> 5ms). I don't know exactly what
> kind of load triggers them. Here's a bit of qjackctl message window (btw:
> jackd was idle, no clients connected, except for qjackctl):
> 

I am seeing the same behavior, about 30 xruns in 10 minutes.  It seems
to be triggered by display activity, among other things.  This cannot be
a jackd issue, because with an earlier version (T3) I can run for 24
hours without a single xrun.

There has to be a bug somewhere in the RT preempt patch.

Lee

