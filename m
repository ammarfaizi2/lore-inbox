Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUIJHxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUIJHxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUIJHwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:52:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22669 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266173AbUIJHuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:50:14 -0400
Date: Fri, 10 Sep 2004 09:51:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Kevin Hilman <kjh-lkml@hilman.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: voluntary-preemption: understanding latency trace
Message-ID: <20040910075139.GB27722@elte.hu>
References: <83656nk9mk.fsf@www2.muking.org> <1094763737.1362.325.camel@krustophenia.net> <20040910063749.GA25298@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910063749.GA25298@elte.hu>
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


> - modify the second sched_clock() call to do this instead:
                   ^--- first
> 
>      user_trace_start();
> 
>   modify the second sched_clock() call to do:
> 
>      user_trace_stop();

