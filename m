Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUHMBIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUHMBIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268920AbUHMBIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:08:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:5861 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264997AbUHMBIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:08:19 -0400
X-Authenticated: #4399952
Date: Fri, 13 Aug 2004 03:18:34 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-Id: <20040813031834.3b45aee5@mango.fruits.de>
In-Reply-To: <1092358530.1304.63.camel@mindpipe>
References: <20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe>
	<20040811073149.GA4312@elte.hu>
	<20040811074256.GA5298@elte.hu>
	<1092210765.1650.3.camel@mindpipe>
	<20040811090639.GA8354@elte.hu>
	<20040811141649.447f112f@mango.fruits.de>
	<20040811124342.GA17017@elte.hu>
	<1092268536.1090.7.camel@mindpipe>
	<20040812072127.GA20386@elte.hu>
	<1092347654.11134.10.camel@mindpipe>
	<1092355488.1304.52.camel@mindpipe>
	<1092356877.1304.58.camel@mindpipe>
	<20040813025546.1372fbc6@mango.fruits.de>
	<1092358530.1304.63.camel@mindpipe>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 20:55:30 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Even if it is not a long non-preemptible section, mlockall-test is
> still doing *something* that causes an xrun in jackd.  Maybe
> interrupts are being disabled for a long time.  Whatever it is, it
> cannot possibly be a jackd bug, because mlockall by an unrelated,
> normal-priority process causes an xrun in the SCHED_FIFO jackd
> process.

Hmm, yes, that makes sense. I wonder: does mlockall have any influence
on IPC?

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

