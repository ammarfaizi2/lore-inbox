Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWKFHWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWKFHWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWKFHWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:22:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3496 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932766AbWKFHWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:22:08 -0500
Date: Mon, 6 Nov 2006 08:21:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       arjan <arjan@infradead.org>
Subject: Re: [PATCH] lockdep: print current locks on in_atomic warnings
Message-ID: <20061106072143.GA29772@elte.hu>
References: <1162758979.14695.20.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162758979.14695.20.camel@lappy>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Add debug_show_held_locks(current) to __might_sleep() and schedule(); 
> this makes finding the offending lock leak easier.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

good idea.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
