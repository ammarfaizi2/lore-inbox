Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVHLHDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVHLHDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 03:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHLHDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 03:03:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18836 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1751137AbVHLHDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 03:03:07 -0400
Date: Fri, 12 Aug 2005 09:03:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High Resolution Timers & RCU-tasklist features
Message-ID: <20050812070334.GA13938@elte.hu>
References: <20050811110051.GA20872@elte.hu> <1123816044.4453.7.camel@mindpipe> <1123816760.4453.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123816760.4453.10.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2005-08-11 at 23:07 -0400, Lee Revell wrote:
> > Very nice to see this going in (via) the RT patch.
> > 
> 
> Also, does not compile for me with ACPI PM timer selected:

i fixed the build errors, but HIGH_RES_TIMER_ACPI_PM does not boot - so 
i've disabled it in the -53-03 patch for the time being.

	Ingo
