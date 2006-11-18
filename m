Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756201AbWKRHBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbWKRHBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 02:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbWKRHBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 02:01:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16581 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1756201AbWKRHBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 02:01:13 -0500
Date: Sat, 18 Nov 2006 08:00:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, John Stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC: -mm patch] remove kernel/timer.c:wall_jiffies
Message-ID: <20061118070006.GC32226@elte.hu>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117235945.GQ31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117235945.GQ31879@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0880]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> "wall_jiffies" was added, but it's completely unused...
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

yeah, that's a merge leftover in:

  gtod-persistent-clock-support-core.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
