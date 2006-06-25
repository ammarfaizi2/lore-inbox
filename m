Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWFYLZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWFYLZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWFYLZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:25:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:2284 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932370AbWFYLZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:25:50 -0400
Date: Sun, 25 Jun 2006 13:20:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Problem with 2.6.17-mm2
Message-ID: <20060625112055.GA29623@elte.hu>
References: <20060625103523.GY27143@charite.de> <20060625034913.315755ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625034913.315755ae.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > 1) A lot of "unexpected IRQ trap at vector X" for X=[09,07]
> 
> hm, ack_bad_irq().  That isn't supposed to happen.
> 
> Ingo, Thomas - it's possible that -mm2's genirq is affecting x86?

hm, indeed - investigating.

	Ingo
