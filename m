Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269054AbUHMKWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269054AbUHMKWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269062AbUHMKWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:22:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65461 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269054AbUHMKT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:19:29 -0400
Date: Fri, 13 Aug 2004 12:21:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <roland@topspin.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813102109.GF8135@elte.hu>
References: <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092360317.1304.72.camel@mindpipe> <1092360704.1304.76.camel@mindpipe> <1092364786.877.1.camel@mindpipe> <1092369242.2769.1.camel@mindpipe> <1092370997.2769.5.camel@mindpipe> <527js31wpv.fsf@topspin.com> <1092372092.3450.0.camel@mindpipe> <523c2r1w7v.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523c2r1w7v.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland Dreier <roland@topspin.com> wrote:

> Look at Ingo's patch; it only adds mcount() to arch/i386 (although
> __mcount is defined in kernel/latency.c, there's no way for any other
> arch to call it).

should be trivial to add it to other arches. But the patch indeed is
x86-only for the time being - 100% of the testers so far were x86 users
so i dont see any point in bloating the patch with untested arch
changes. Tested contributions are welcome of course!

	Ingo
