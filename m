Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWJWS6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWJWS6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWJWS6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:58:11 -0400
Received: from www.osadl.org ([213.239.205.134]:64485 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965041AbWJWS6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:58:10 -0400
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mark Knecht <markknecht@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <5bdc1c8b0610231144s420c1523p43af2a8349bac04@mail.gmail.com>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe> <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
	 <5bdc1c8b0610231144s420c1523p43af2a8349bac04@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 20:59:15 +0200
Message-Id: <1161629955.22373.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 11:44 -0700, Mark Knecht wrote:
> Hi Thomas,
>    Some differences/questions between 2.6.18-rt6 and 2.6.18-rt7:
> 
>    In 2.6.18-rt6, using make menuconfig, there were options on the
> front page for HRT Support. This seems to have moved under Processor
> Type with 2.6.18-rt7. Was that on purpose?

Yes

>    In 2.6.18-rt6 I turned on HRT support, left 1000 nanoseconds for
> the timing, but did not enable dynamic ticks since I wasn't sure it
> was OK on AMD64. Should I be using DynTicks with an AMD64 single
> processor? With a dual-processor?

Should work

>    On 2.6.18-rt7 it seems there is no time value setting or it's been
> moved somewhere I haven't found. does that 1000 nanosecond time
> setting still apply?

Basically yes. It is handled internally.

	tglx


