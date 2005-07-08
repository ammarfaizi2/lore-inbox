Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVGHIxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVGHIxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVGHIxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:53:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4064 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262364AbVGHIw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:52:57 -0400
Date: Fri, 8 Jul 2005 10:52:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
Message-ID: <20050708085253.GA1177@elte.hu>
References: <1119370868.26957.9.camel@cmn37.stanford.edu> <20050621164622.GA30225@elte.hu> <1119375988.28018.44.camel@cmn37.stanford.edu> <1120256404.22902.46.camel@cmn37.stanford.edu> <20050703133738.GB14260@elte.hu> <1120428465.21398.2.camel@cmn37.stanford.edu> <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org> <20050707194914.GA1161@elte.hu> <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org> <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK.
> 
> Just for the heads up, here goes todays summary results regarding my 
> jack_test4.2 test suite against 2.6.12 kernels configured with 
> PREEMPT_RT, but... now with 99.9% certainty :)

thanks for the testing!

>   ------------------------------ ------------- -------------
>                                  RT-V0.7.51-13 RT-V0.7.49-01
>   ------------------------------ ------------- -------------

>   Delay Maximum . . . . . . . . :      333           295     usecs
>   Cycle Maximum . . . . . . . . :      970           943     usecs
>   Average DSP Load. . . . . . . :       45.7          44.4   %
>   Average CPU System Load . . . :       15.6          16.3   %
>   Average CPU User Load . . . . :       32.0          30.1   %

i'm wondering - is this slight increase in CPU utilization (and 
latencies) due to natural fluctuations, or is it a genuine overhead 
increase?

	Ingo
