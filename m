Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVJDPp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVJDPp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVJDPp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:45:28 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41352
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964818AbVJDPp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:45:27 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <20051004155043.GA8873@in.ibm.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
	 <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com>
	 <20051004153208.GA4916@elte.hu>  <20051004155043.GA8873@in.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 04 Oct 2005 17:46:33 +0200
Message-Id: <1128440793.13057.35.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 21:20 +0530, Dinakar Guniguntala wrote:
> > > BUG: auditd:3596, possible softlockup detected on CPU#3!
> > >  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
> > >  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
> > >  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
> > >  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
> > >  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)
> > > 
> 
> 
> .config attached this time

Can you try with high resolution timers disabled ?

tglx


