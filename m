Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVAXIDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVAXIDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 03:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVAXIDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 03:03:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53724 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261464AbVAXIDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 03:03:08 -0500
Date: Mon, 24 Jan 2005 09:02:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
Message-ID: <20050124080254.GA7753@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu> <200501221622.24273.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501221622.24273.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> On Saturday 22 January 2005 07:29, Ingo Molnar wrote:
> >i have released the -V0.7.36-00 Real-Time Preemption patch, which
> > can be downloaded from the usual place:
> >
> >  http://redhat.com/~mingo/realtime-preempt/
> >
> >this is mainly a merge to 2.6.11-rc2.
> 
> Humm, by the time I went after the patch it was up to -02.
> 
> And I'm getting a couple of error exits:
> -------------------
> net/sched/sch_generic.c: In function `qdisc_restart':
> net/sched/sch_generic.c:128: error: label `requeue' used but not 
> defined

indeed - !PREEMPT_RT compilation broke. I've uploaded -03 with the fix
(and other fixes).

	Ingo
