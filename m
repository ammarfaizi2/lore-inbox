Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVJDPbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVJDPbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVJDPbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:31:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:54178 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964805AbVJDPbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:31:51 -0400
Date: Tue, 4 Oct 2005 17:32:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051004153208.GA4916@elte.hu>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain> <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004151635.GA8866@in.ibm.com>
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


.config please.

	Ingo

* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> On Tue, Oct 04, 2005 at 04:27:18PM +0200, Ingo Molnar wrote:
> > 
> > > Hmm Ingo,
> > > 
> > > Looks like -rt6 got rid of all the _nort defines, but it's still used 
> > > throughout the kernel.
> > 
> > yeah, -rt7 should fix this.
> > 
> 
> 
> I get a lot of these with -rt7 (One every minute)
> 
> BUG: auditd:3596, possible softlockup detected on CPU#3!
>  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
>  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
>  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
>  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
>  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)
> 
> 
> 	-Dinakar
