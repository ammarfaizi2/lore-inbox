Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVF3Bnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVF3Bnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 21:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVF3Bnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 21:43:51 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:15119 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262704AbVF3Bnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 21:43:49 -0400
Date: Wed, 29 Jun 2005 18:50:41 -0700
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630015041.GA24234@nietzsche.lynx.com>
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629235422.GI1299@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 04:54:22PM -0700, Paul E. McKenney wrote:
> If you were suggesting this to be run on an SMP system, I would agree
> with you.  I, too, would very much like to see these results run on a
> 2-CPU or 4-CPU system, although I am most certainly -not- asking Kristian
> and Karim to do this work -- it is very much someone else's turn in the
> barrel, I would say!

No, I'm suggesting that you and other folks understand the basic ideas
behind this patch and stop asking unbelievably stupid questions. This has
been covered over and over again, and I shouldn't have to repeat these
positions constantly because folks have both a language comprehension
problem and inability to bug off appropriately.

> However, on a UP system, I have to agree with Kristian's choice of
> configuration.  An embedded system developer running on a UP system would
> naturally use a UP Linux kernel build, so it makes sense to benchmark
> a UP kernel on a UP system.

Dual cores are going to be standard in the next few years so RTOSs should
anticipate these things coming down the pipeline.

bill

