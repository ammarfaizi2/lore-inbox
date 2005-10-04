Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVJDPdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVJDPdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVJDPdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:33:01 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:33160
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932507AbVJDPdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:33:00 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20051004151635.GA8866@in.ibm.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
	 <20051004142718.GA3195@elte.hu>  <20051004151635.GA8866@in.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 04 Oct 2005 17:34:10 +0200
Message-Id: <1128440050.13057.33.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 20:46 +0530, Dinakar Guniguntala wrote:

> I get a lot of these with -rt7 (One every minute)
> 
> BUG: auditd:3596, possible softlockup detected on CPU#3!
>  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
>  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
>  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
>  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
>  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)
> 

Can you send me your .config please ?

tglx


