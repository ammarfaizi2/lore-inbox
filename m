Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263705AbUD0Cwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbUD0Cwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUD0Cwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:52:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27792 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263705AbUD0Cwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:52:42 -0400
Date: Tue, 27 Apr 2004 04:54:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Darren Hart <dvhltc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: sched_domains and Stream benchmark
Message-ID: <20040427025425.GA31747@elte.hu>
References: <1N7xQ-7fh-29@gated-at.bofh.it> <m3r7uitr1r.fsf@averell.firstfloor.org> <1083018633.3070.8.camel@farah> <20040427023327.GB11321@colin2.muc.de> <408DC909.7030605@yahoo.com.au> <20040427024859.GC11321@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427024859.GC11321@colin2.muc.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> I said it was fixed with Ingo's patch, nothing more. 
> The patch isn't in mm5 yet as far as I know.

sched-balance-context.patch in recent -mm kernels is a morphed version
of my previous patch. Could you try something like 2.6.6-rc2-mm2 and
check whether performance is linear?

	Ingo
