Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269761AbUJSRFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269761AbUJSRFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269842AbUJSRDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:03:33 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:8098
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269818AbUJSQwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:52:37 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <20041019155722.GA9711@elte.hu>
References: <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019144642.GA6512@elte.hu>
	 <28172.195.245.190.93.1098199429.squirrel@195.245.190.93>
	 <1098200660.12223.923.camel@thomas>  <20041019155722.GA9711@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098204276.12223.992.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 18:44:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 17:57, Ingo Molnar wrote:
> any chance for serial logging on that box?

No

> and does this bootup crash go away if you unset PREEMPT_TIMING or
> LATENCY_TRACE, as suggested by Rui?

It comes into init now, but dies when loading the AGP driver. Have to
look into this.

tglx


