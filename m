Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269492AbUJLGpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269492AbUJLGpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269491AbUJLGpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:45:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35794 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269494AbUJLGgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:36:52 -0400
Date: Tue, 12 Oct 2004 08:37:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, thewade@aproximation.org
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
Message-ID: <20041012063752.GB2947@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <1097542629.1453.117.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097542629.1453.117.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2004-10-11 at 17:59, Ingo Molnar wrote:
> > * Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:
> > 
> > > I would have to say this is "very rough" at this point. I had the
> > > following problems in the build:
> > 
> > i've uploaded -T5 which should fix most of the build issues:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T5
> > 
> 
> Ingo, are any of the VP patches known to work on x64?  Here is
> thewade's latest report:

i have two x64 boxes which i tested with S* -VP and i also did a quick
testboot of -T3 on one of them but YMMV. (There's one caveat: latency
tracing must not be enabled, x64 gcc has a nastiness that makes -pg
unusable for tracing purposes on x64.)

-T4 and upwards will likely not even compile on x64 - i'll fix it up
once the rate of PREEMPT_REALTIME changes calms down.

	Ingo
