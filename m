Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUHKTIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUHKTIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268176AbUHKTIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:08:00 -0400
Received: from pop.gmx.net ([213.165.64.20]:61646 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268175AbUHKTH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:07:58 -0400
X-Authenticated: #4399952
Date: Wed, 11 Aug 2004 21:18:08 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-Id: <20040811211808.48bd6b1d@mango.fruits.de>
In-Reply-To: <20040811124342.GA17017@elte.hu>
References: <20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe>
	<20040811073149.GA4312@elte.hu>
	<20040811074256.GA5298@elte.hu>
	<1092210765.1650.3.camel@mindpipe>
	<20040811090639.GA8354@elte.hu>
	<20040811141649.447f112f@mango.fruits.de>
	<20040811124342.GA17017@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 14:43:42 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> so you can only trigger the latencies via mlockall-test if jackd is
> also running? Or do the latencies only trigger in jackd (and related 
> programs)?

Hi,

i also want to say that some of the sprocadic xruns i see do also not
seem to be cause by latencies. The preempt timing reports i saw where
rather results of the xrun_debug reports i think..

How do i come to this conclusion? Well i have jack running w/o ALSA
xrun_debug reports but with preempt timing running for quite a while and
i see about the same number of xruns as before, but i don't see any
preempt timing reports anymore...

So i think jackd itself is doing some weird stuff. Or the driver of my
soundcard. 

Flo


-- 
Palimm Palimm!
http://affenbande.org/~tapas/

