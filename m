Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVFHT2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVFHT2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFHT2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:28:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45478 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261561AbVFHT1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:27:52 -0400
Date: Wed, 8 Jun 2005 21:24:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: kus Kusche Klaus <kus@keba.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050608192403.GB3411@elte.hu>
References: <20050608155049.GA7160@elte.hu> <Pine.LNX.4.10.10506081028140.28001-100000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10506081028140.28001-100000@godzilla.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > Thomas and me already did that - i think Thomas could send a patch for 
> > review?
> 
> Well, making it is one thing, getting Russell to accept it is a whole 
> other issue.. Are you still willing to make the RT patch a sandbox for 
> this?

the patch in essence generalizes the ARM IRQ features and merges them 
into the generic IRQ code - with minimal impact to the current ARM way 
of doing interrupts. The long-term end-result should be more 
architectures using the ARM IRQ handling methods such as irqchip.

	Ingo
