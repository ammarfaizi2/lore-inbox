Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUH1QZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUH1QZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUH1QWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:22:04 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2308 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267424AbUH1QSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:18:49 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q0
Date: Sat, 28 Aug 2004 18:18:27 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <20040828120309.GA17121@elte.hu>
In-Reply-To: <20040828120309.GA17121@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408281818.28159.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 August 2004 14:03, Ingo Molnar wrote:

> Similarly, there are 4 independent options for the .config:
> CONFIG_PREEMPT, CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS and
> CONFIG_PREEMPT_HARDIRQS. (In theory all of these options should compile
> independently, but i've only tested all-enabled so far.)

I must be missing something, but after applying diff-bk-040828-2.6.8.1.bz2 and 
voluntary-preempt-2.6.9-rc1-bk4-Q1 on top of 2.6.8.1, I'm unable to find 
neither CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS, nor 
CONFIG_PREEMPT_HARDIRQS.

Any ideas are welcome.
