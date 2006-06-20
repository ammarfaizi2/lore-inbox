Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWFTIiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWFTIiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWFTIiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:38:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:62608 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965045AbWFTIiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:38:06 -0400
Date: Tue, 20 Jun 2006 10:33:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock and NMI)
Message-ID: <20060620083305.GB7899@elte.hu>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no> <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no> <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com> <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4497A5BC.4070005@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Otherwise, a straight rwlock->spinlock conversion will have a few more 
> scalability issues, but I'd guess it wouldn't be a problem at all for 
> most workloads on most systems.

curious, do you have any (relatively-) simple to run testcase that 
clearly shows the "scalability issues" you mention above, when going 
from rwlocks to spinlocks? I'd like to give it a try on an 8-way box.

	Ingo
