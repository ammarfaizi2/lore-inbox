Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbUKWKuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUKWKuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUKWKuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:50:00 -0500
Received: from mx1.elte.hu ([157.181.1.137]:33429 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262481AbUKWKt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:49:58 -0500
Date: Tue, 23 Nov 2004 12:52:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041123115201.GA26714@elte.hu>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com> <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com>
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


* Adam Heath <doogie@debian.org> wrote:

> > >i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
> > >downloaded from the usual place:
> > >
> > >            http://redhat.com/~mingo/realtime-preempt/
> 
> I'm seeing something very odd.  It's against 29-0.  I also seem to
> recall seeing something similiar reported earlier.
> 
> I'm seeing pauses on my system.  Not certain what is causing it. 
> Hitting a key on the keyboard unsticks it.

at first sight this looks like a scheduling/wakeup anomaly. Please
re-report this if it happens with the current (30-4) kernel too. Also,
could you test the vanilla -mm tree, it has a few scheduler updates too.

	Ingo
