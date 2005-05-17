Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVEQHoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVEQHoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVEQHmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:42:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46744 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261351AbVEQHlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:41:06 -0400
Date: Tue, 17 May 2005 09:40:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org, paulus@samba.org,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] improve SMP reschedule and idle routines
Message-ID: <20050517074037.GA13810@elte.hu>
References: <42881FE2.2000302@yahoo.com.au> <20050515.220455.59467677.davem@davemloft.net> <42899E78.6040306@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42899E78.6040306@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> David S. Miller wrote:
> 
> >I'll test this once you work out that obvious bug.
> >
> 
> David's got it tested and working. No difference in the tbench
> test reported for SPARC64.
> 
> Following are some numbers for a tbench 3.03 test: 1 client, 1 server
> in different configurations.
> 
> Xeon and G5 seem to be significantly improved on the order of 1-5%. I2 
> may be slightly down, but if it is significant I expect real world 
> workloads to be either not impacted, or hopefully some might see a 
> small improvement.
> [...]

> Unless anyone has an objection, I'm going to hack up untested 
> implementations for the rest of the architectures and see if Andrew 
> will put the patch in -mm for a while.

the patch looks good to me and builds / boots on my testsystems (x86, 
x64) too.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
