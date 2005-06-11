Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVFKPCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVFKPCP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVFKPCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:02:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30343 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261736AbVFKPCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:02:02 -0400
Date: Sat, 11 Jun 2005 16:56:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, Karim Yaghmour <karim@opersys.com>,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050611145620.GA13726@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu> <20050611103707.GA8799@elte.hu> <1118499800.5786.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118499800.5786.24.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kristian Benoit <kbenoit@opersys.com> wrote:

> > one has to make sure the default debug options are disabled.  
> > (DEADLOCK_DETECT, PREEMPT_DEBUG, etc.)
> 
> Can you tell me the exact list of option where talking about ?

just send me a .config and i'll review it for PREEMPT_RT latency 
performance. There can be many things depending on whether it's UP or 
SMP, etc.

	Ingo
