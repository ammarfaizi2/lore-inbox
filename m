Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267665AbUIAUUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267665AbUIAUUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbUIAUUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:20:21 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:20245 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S267665AbUIAULS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:11:18 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1094058546.6465.2.camel@localhost>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <20040901082958.GA22920@elte.hu>
	 <20040901135122.GA18708@elte.hu>  <1094058546.6465.2.camel@localhost>
Content-Type: text/plain
Date: Wed, 01 Sep 2004 22:11:13 +0200
Message-Id: <1094069473.7477.2.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 19:09 +0200, Thomas Charbonnel wrote:
> Ingo Molnar wrote :
> > i've released the -Q7 patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q7
> 
> With Q7 I still get rx latency issues (> 130 us non-preemptible section
> from rtl8139_poll). Moreover network connections were extremely slow
> (almost hung) until I set /proc/sys/net/core/netdev_backlog_granularity
> to 2.
> 
> Thomas
> 

Me too!
I too have a rtl8139 network card.

kr, what kind of nic do you have since this does not occur on your
machine?

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

