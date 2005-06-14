Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFNUhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFNUhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFNUhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:37:18 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36563 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261328AbVFNUhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:37:10 -0400
Date: Tue, 14 Jun 2005 13:37:37 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050614203737.GA1297@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608112801.GA31084@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608112801.GA31084@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 01:28:01PM +0200, Ingo Molnar wrote:
> 
> i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
> downloaded from the usual place:

FYI, -V0.7.48-25 runs a round of kernbench and LTP on a 4-CPU x86 box.

						Thanx, Paul

>     http://redhat.com/~mingo/realtime-preempt/
> 
> this release includes an improved version of Daniel Walker's soft 
> irq-flag (hardirq-disable removal) feature. It is an unconditional part
> of the PREEMPT_RT preemption model - other preemption models should not
> be affected that much (besides possible build issues). Non-x86 arches
> wont build. Some regressions might happen, so take care..
> 
> Changes since -47-29:
> 
>  - soft IRQ flag support (Daniel Walker)
> 
>  - fix race in usbnet.c (Eugeny S. Mints)
> 
>  - further improvements to the soft IRQ flag code
> 
> to build a -V0.7.48-00 tree, the following patches should to be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
>    http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.48-00
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
