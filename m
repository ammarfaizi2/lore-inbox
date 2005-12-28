Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVL1IAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVL1IAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVL1IAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:00:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:10666 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932501AbVL1IAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:00:50 -0500
Date: Wed, 28 Dec 2005 09:00:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
Message-ID: <20051228080029.GA5641@elte.hu>
References: <43B22FBA.5040008@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B22FBA.5040008@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> This patch implements a prototype version of a simplified interactive 
> bonus mechanism.  The mechanism does not attempt to identify 
> interactive tasks and give them a bonus (like the current mechanism 
> does) but instead attacks the problem that the bonuses are supposed to 
> fix, unacceptable interactive latency, directly.

i think we could give this one a workout in -mm, to see the actual 
effects. Would you mind to merge this to -mm's scheduler queue, to right 
after sched-add-sched_batch-policy.patch?

	Ingo
