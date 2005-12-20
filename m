Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVLTN2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVLTN2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVLTN2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:28:46 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58305 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751004AbVLTN2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:28:46 -0500
Date: Tue, 20 Dec 2005 14:28:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -RT] Add softirq waitqueue for CONFIG_PREEMPT_SOFTIRQ (was: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 ...)
Message-ID: <20051220132803.GB24408@elte.hu>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de> <1134507927.18921.26.camel@localhost.localdomain> <20051214084019.GA18708@elte.hu> <20051214084333.GA20284@elte.hu> <1134568080.18921.42.camel@localhost.localdomain> <1134568867.4275.7.camel@tglx.tec.linutronix.de> <1134575022.18921.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134575022.18921.56.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> This patch fixes the problem I have.  I've added a waitqueue per all 
> softirq threads IFF a CONFIG_PREEMPT_SOFTIRQ is set.

thanks, applied.

	Ingo
