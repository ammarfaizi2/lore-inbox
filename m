Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFLWUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFLWUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 18:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVFLWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 18:20:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24408
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261253AbVFLWUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 18:20:20 -0400
Date: Mon, 13 Jun 2005 00:20:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050612222011.GG5796@g5.random>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB662B.4010104@opersys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 06:31:07PM -0400, Karim Yaghmour wrote:
> The logger used two TSC values. One prior to shooting the interrupt to the
> target, and one when receiving the response. Responding to an interrupt

Real life RT apps would run the second rdtsc in user space and not
kernel space, right?

And thanks for your benchmarking efforts!
