Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbUJ0U7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbUJ0U7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUJ0U6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:58:41 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:31497 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262695AbUJ0UzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:55:14 -0400
Date: Wed, 27 Oct 2004 13:54:45 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027205445.GB24732@nietzsche.lynx.com>
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com> <20041027150548.GA11233@elte.hu> <20041027204935.GA24732@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027204935.GA24732@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 01:49:35PM -0700, Bill Huey wrote:
> I've got a latency/histogram patch here, but I've been having problems
> trying to integrate it into Ingo's irq-threads and getting that simple
> subtraction returning something sensible. The basic logic works otherwise.
> 
> Maybe another pair of eyes can figure this out, since I could have missed
> something pretty simple...

It was originally mean to go in between the irq-thread wake attempt and
the actual running of the thread body itself. Somehow this is breaking
in my effort to integrate this logic into Ingo's (your) stuff. Brain
farting severely right now.

bill

