Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVFKTTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVFKTTy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVFKTTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:19:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26525 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261787AbVFKTTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:19:41 -0400
Date: Sat, 11 Jun 2005 21:14:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050611191448.GA24152@elte.hu>
References: <42AA6A6B.5040907@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AA6A6B.5040907@opersys.com>
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

> In the following, interrupts are triggered by the logger at every 1ms. 
> It would be interesting to redo such tests with shorter trigger times. 
> However, we wanted to keep the logger as "off-the-shelf" as possible.
> 
> Interrupt response times (all in micro-seconds):

how were interrupt response times measured, precisely? What did the 
target (measured) system have to do to respond to an interrupt? Did you 
use the RTC to measure IRQ latencies?

	Ingo
