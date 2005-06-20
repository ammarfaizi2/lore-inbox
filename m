Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVFTSZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVFTSZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVFTSZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:25:23 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:14864 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261419AbVFTSZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:25:18 -0400
Date: Mon, 20 Jun 2005 11:31:15 -0700
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050620183115.GA27028@nietzsche.lynx.com>
References: <1119287612.6863.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119287612.6863.1.camel@localhost>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 01:13:32PM -0400, Kristian Benoit wrote:
> For PREEMPT_RT clearly the results are much better than last time.
> Indeed it appears that, as Ingo predicted, a combination of the
> proper configuration options and most recent additions gives
> PREEMPT_RT important gains. In comparison to last week's results
> all measures are lower: average response time, maximum response time,
> minimum response time, and standard deviation. This is very good.
> But that's not all. PREEMPT_RT also comes down virtually neck-to-
> neck with the I-pipe (and the previous numbers from Adeos) in
> terms of maximum interrupt response time. Certainly those backing
> PREEMPT_RT, and others we hope, will find this quite positive.

You might what to try the overall times numbers with the voluntary
preemption instead. That option doesn't convert spinlocks and still
uses interrupt threads. I'd be surprised that the spinlocks would
contribute to that much overhead. Nevertheless, I'll be curious
about those results.

bill

