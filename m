Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270044AbUJTNMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270044AbUJTNMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270153AbUJTNKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:10:15 -0400
Received: from mail.gmx.de ([213.165.64.20]:58762 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270009AbUJTNIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:08:54 -0400
X-Authenticated: #4399952
Date: Wed, 20 Oct 2004 15:25:07 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020152507.3c167ca8@mango.fruits.de>
In-Reply-To: <20041020125500.GA8693@elte.hu>
References: <20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu>
	<20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041020145019.176826cb@mango.fruits.de>
	<20041020125500.GA8693@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 14:55:00 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> i dont think it's caused by trace_enabled - the trace you sent last time
> clearly showed erratic behavior. There's one piece of code i suspect in
> particular - could you try the patch below ontop of -U8? (i have
> compile- and boot- tested it)

mango:/usr/src/linux-2.6.9-rc4-mm1-U8# patch -p1 </home/tapas/foo.patch 
patching file kernel/sched.c
Hunk #5 succeeded at 3843 with fuzz 1.

building anyways, reporting later..

flo
