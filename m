Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUA3NG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 08:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUA3NG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 08:06:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64448 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263823AbUA3NGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 08:06:55 -0500
Date: Fri, 30 Jan 2004 10:10:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adam Koszela <lameaim@bredband.tiscali.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc2-mm1 scheduler badness
Message-ID: <20040130091003.GA3841@elte.hu>
References: <1075317961.3505.4.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075317961.3505.4.camel@arrakis>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Koszela <lameaim@bredband.tiscali.se> wrote:

> So here's my problem:
> Performance, especially when switching/launching apps is awful,
> and dmesg spits out massive amounts of:
> 
> Badness in try_to_wake_up at kernel/sched.c:722

unapply this patch:

 ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/broken-out/futex-wakeup-debug.patch

	Ingo
