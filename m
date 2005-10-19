Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbVJSGqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbVJSGqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 02:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbVJSGqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 02:46:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31623 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751553AbVJSGqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 02:46:44 -0400
Date: Wed, 19 Oct 2005 08:46:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051019064643.GA24482@elte.hu>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com> <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu> <Pine.LNX.4.61.0510172227010.1386@scrub.home> <20051018084655.GA28933@elte.hu> <Pine.LNX.4.61.0510190311140.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510190311140.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > and no, ktimers are not "optimized for process usage" (or tied to 
> > whatever other process notion, as i said before), they are optimized 
> > for:
> > 
> >  - the delivery of time related events
> > 
> > as contrasted to the timeout-API (a'ka "timer wheel") code in 
> > kernel/timers.c that is optimized towards:
> > 
> >  - the fast adding/removal of timers
> > 
> > without too much focus on robust and deterministic delivery of events.
> 
> You forgot the main property of high resolution, which implies a 
> higher maintainance cost.

what did i forget? I did not mention "high resolution" anywhere. And 
what precisely do you mean by "higher maintainance cost"?

	Ingo
