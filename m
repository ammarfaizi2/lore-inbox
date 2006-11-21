Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934337AbWKUHVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934337AbWKUHVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934262AbWKUHVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:21:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3263 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S934337AbWKUHVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:21:53 -0500
Date: Tue, 21 Nov 2006 08:20:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061121072029.GB20621@elte.hu>
References: <20061120220230.GA30835@elte.hu> <200611202318.11142.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611202318.11142.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Got this when I mounted my /home partition:
> 
> [  375.927366] XFS mounting filesystem md2
> [  376.724666] Ending clean XFS mount for filesystem: md2
> [  441.121031] stopped custom tracer.
> [  441.121067]
> [  441.121068] =============================================
> [  441.121131] [ INFO: possible recursive locking detected ]

if you use XFS you should turn off CONFIG_PROVE_LOCKING.

> Also, I assume latency tracing still isn't working on x86_64? I don't 
> get a /proc/sys/kernel/preempt_max_latency file, but I have the right 
> option enabled.

i'm using it every day on both x86_64 and i386. I'll try your config.

	Ingo
