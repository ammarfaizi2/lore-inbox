Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUKFP3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUKFP3K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUKFP3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:29:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18048 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261401AbUKFP3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:29:07 -0500
Date: Sat, 6 Nov 2004 17:30:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Amit Shah <amitshah@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Message-ID: <20041106163034.GA17369@elte.hu>
References: <200411051837.02083.amitshah@gmx.net> <200411061414.11719.amitshah@gmx.net> <20041106120525.GA15363@elte.hu> <200411062054.40384.amitshah@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411062054.40384.amitshah@gmx.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Amit Shah <amitshah@gmx.net> wrote:

> IRQ#18 thread RT prio: 46.
> ifconfig/4106: BUG in enable_irq at kernel/irq/manage.c:112
>  [<c0107fc0>] dump_stack+0x1e/0x22 (20)
>  [<c0142a9b>] enable_irq+0xeb/0xf0 (52)
>  [<f892b290>] e100_up+0x111/0x20c [e100] (48)
>  [<f892c4d7>] e100_open+0x2c/0x71 [e100] (32)

> But as you say, this should be harmless.

correct. It also happens with the vanilla -mm kernel.

	Ingo
