Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVJDPJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVJDPJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVJDPJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:09:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:23504 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932529AbVJDPJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:09:06 -0400
Date: Tue, 4 Oct 2005 20:46:35 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051004151635.GA8866@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain> <20051004142718.GA3195@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004142718.GA3195@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 04:27:18PM +0200, Ingo Molnar wrote:
> 
> > Hmm Ingo,
> > 
> > Looks like -rt6 got rid of all the _nort defines, but it's still used 
> > throughout the kernel.
> 
> yeah, -rt7 should fix this.
> 


I get a lot of these with -rt7 (One every minute)

BUG: auditd:3596, possible softlockup detected on CPU#3!
 [<c0144c48>] softlockup_detected+0x39/0x46 (8)
 [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
 [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
 [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
 [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)


	-Dinakar
