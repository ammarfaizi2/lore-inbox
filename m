Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVJDQBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVJDQBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVJDQBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:01:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45493 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964834AbVJDQBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:01:50 -0400
Date: Tue, 4 Oct 2005 21:39:49 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051004160949.GB8873@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain> <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com> <20051004153208.GA4916@elte.hu> <20051004155043.GA8873@in.ibm.com> <1128440793.13057.35.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128440793.13057.35.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 05:46:33PM +0200, Thomas Gleixner wrote:
> On Tue, 2005-10-04 at 21:20 +0530, Dinakar Guniguntala wrote:
> > > > BUG: auditd:3596, possible softlockup detected on CPU#3!
> > > >  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
> > > >  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
> > > >  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
> > > >  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
> > > >  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)
> > > > 
> > 
> > 
> > .config attached this time
> 
> Can you try with high resolution timers disabled ?
> 

Hi, I tried with CONFIG_HIGH_RES_TIMERS off, doesnt seem to help.
I get the same messages

	-Dinakar
