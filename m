Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUIJT2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUIJT2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUIJT1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:27:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64420 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267839AbUIJTYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:24:43 -0400
Date: Fri, 10 Sep 2004 21:26:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@raytheon.com, Lee Revell <rlrevell@joe-job.com>,
       Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040910192608.GA18761@elte.hu>
References: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com> <20040908184231.GA8318@elte.hu> <41411214.4000205@cybsft.com> <4141EAE5.5080202@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4141EAE5.5080202@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> I also have some other traces from this system that I have not seen
> before on my slower system. For instance this one where we spend ~204
> usec in __spin_lock_irqsave:
> 
> http://www.cybsft.com/testresults/2.6.9-rc1-bk12-S0/trace1.txt
> 
> Or this one where we spend ~203 usec in sched_clock. That just doesn't
> seem possible.
> 
> http://www.cybsft.com/testresults/2.6.9-rc1-bk12-S0/trace4.txt

seems quite similar to Mark's IDE-DMA related hardware latencies. Does 
reducing the DMA mode via hdparm reduce these latencies?

	Ingo
