Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWAODuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWAODuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 22:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWAODuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 22:50:06 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:15747 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751805AbWAODuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 22:50:04 -0500
Date: Sun, 15 Jan 2006 04:50:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, "Martin J. Bligh" <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Message-ID: <20060115035005.GA19720@elte.hu>
References: <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com> <43C6B60E.2000003@bigpond.net.au> <43C6D636.8000105@bigpond.net.au> <43C75178.80809@bigpond.net.au> <43C9477B.8060709@google.com> <43C991D0.3040808@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C991D0.3040808@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Williams <pwil3058@bigpond.net.au> wrote:

> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Acked-by: Ingo Molnar <mingo@elte.hu>

nice work! There's a small typo here:

> + * To aid in avoiding the subversion of "niceness" due to uneven distribution
> + * of tasks with abnormal "nice" values accross CPUs the contribution that

s/accross/across

	Ingo
