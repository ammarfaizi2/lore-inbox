Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVFLNvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVFLNvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVFLNvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:51:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64728 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262611AbVFLNtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:49:49 -0400
Date: Sun, 12 Jun 2005 15:49:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050612134907.GA17467@elte.hu>
References: <20050608112801.GA31084@elte.hu> <200506120502.01752.gene.heskett@verizon.net> <20050612103513.GA10808@elte.hu> <200506120940.11698.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506120940.11698.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> I think I see.  Do you have a swag as to how much runtime overhead 
> using softirq's only might cause? [...]

should be barely measurable for desktop workloads. For servers it might 
be significant, depending on the amount of IRQ traffic. For any box 
doing less than 2000-3000 irqs/sec it should be very small.

	Ingo
