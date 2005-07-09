Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVGIXbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVGIXbm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 19:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVGIXbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 19:31:42 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:42253 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261772AbVGIXbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 19:31:13 -0400
Date: Sat, 9 Jul 2005 16:37:41 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org,
       rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
Message-ID: <20050709233741.GA18435@nietzsche.lynx.com>
References: <42CF05BE.3070908@opersys.com> <20050709071911.GB31100@elte.hu> <1120929727.22337.15.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120929727.22337.15.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 10:22:07AM -0700, Daniel Walker wrote:
> PREEMPT_RT is not pre-tuned for every situation , but the bests
> performance is achieved when the system is tuned. If any of these tests
> rely on a low priority thread, then we just raise the priority and you
> have better performance.

Just think about it. Throttling those threads via the scheduler throttles 
the system in super controllable ways. This is very cool stuff. :)

bill

