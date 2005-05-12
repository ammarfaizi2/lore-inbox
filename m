Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVELSRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVELSRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVELSRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:17:04 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:8140 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262094AbVELSQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:16:51 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 12 May 2005 11:16:45 -0700
From: Tony Lindgren <tony@atomide.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: vatsa@in.ibm.com, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050512181644.GD15812@atomide.com>
References: <20050507182728.GA29592@in.ibm.com> <1115913679.20909.31.camel@mindpipe> <20050512161636.GA15653@atomide.com> <200505120928.55476.jesse.barnes@intel.com> <20050512171251.GA21656@in.ibm.com> <4283999F.8080609@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4283999F.8080609@virtuousgeek.org>
User-Agent: Mutt/1.5.8i
X-Broken-Reverse-DNS: no host name found for IP address 192.168.100.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesse Barnes <jbarnes@virtuousgeek.org> [050512 11:01]:
> Srivatsa Vaddagiri wrote:
> 
> >Even if we were to go for this tickless design, the fundamental question
> >remains: who wakes up the (sleeping) idle CPU upon a imbalance? Does some 
> >other
> >(busy) CPU wake it up (which makes the implementation complex) or the idle 
> >CPU checks imbalance itself at periodic intervals (which restricts the 
> >amount of
> >time a idle CPU may sleep).
> > 
> >
> Waking it up at fork or exec time might be doable, and having a busy CPU 
> wake up other CPUs wouldn't add too much complexity, would it?

At least then it would be event driven rather than polling approach.

Tony
