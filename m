Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268038AbUHKMGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268038AbUHKMGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUHKMGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:06:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:421 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268038AbUHKMGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:06:43 -0400
X-Authenticated: #4399952
Date: Wed, 11 Aug 2004 14:16:49 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-Id: <20040811141649.447f112f@mango.fruits.de>
In-Reply-To: <20040811090639.GA8354@elte.hu>
References: <20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe>
	<20040811073149.GA4312@elte.hu>
	<20040811074256.GA5298@elte.hu>
	<1092210765.1650.3.camel@mindpipe>
	<20040811090639.GA8354@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 11:06:39 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> i'm currently running a loop of mlockall-test 100MB on a 466 MHz
> Celeron, and not a single blip on the radar with a 1000 usecs
> threshold, after 1 hour of runtime ...

I suppose you're not using jackd. As i have noticed that these critical
sections only get reported when jackd is running. It seems jackd is
producing a certain kind of load which exposes them..

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

