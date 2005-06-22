Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVFVX5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVFVX5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVFVX5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:57:45 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25363
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261599AbVFVX5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:57:34 -0400
Date: Thu, 23 Jun 2005 01:57:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, tglx@linutronix.de, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622235720.GA6200@g5.random>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9F673.4040100@opersys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 07:38:27PM -0400, Karim Yaghmour wrote:
> Bare in mind here that what we're trying to find out with such
> tests is what is the bare minimum cost of the proposed rt
> enhancements to Linux, and how well do these perform in their
> rt duties, the most basic of which being interrupt latency.

Agreed. I think it makes more sense to keep comparing it against the UP
kernel with preempt disabled, since most embedded devices aren't smp.

> To be honest, however, I have a very hard time, as a user, to
> convince myself that I should enable preempt_rt under any but
> the most dire situations given the results I now have in front

Same here.
