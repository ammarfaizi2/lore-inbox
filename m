Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268969AbUHMElu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268969AbUHMElu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUHMElu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:41:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45969 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268969AbUHMEk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:40:56 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Roland Dreier <roland@topspin.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <527js31wpv.fsf@topspin.com>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092360317.1304.72.camel@mindpipe> <1092360704.1304.76.camel@mindpipe>
	 <1092364786.877.1.camel@mindpipe> <1092369242.2769.1.camel@mindpipe>
	 <1092370997.2769.5.camel@mindpipe>  <527js31wpv.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1092372092.3450.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 00:41:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 00:35, Roland Dreier wrote:
>     Lee> I believe this is the correct patch, based on
>     Lee> arch/sparc64/kernel/sparc64_ksyms.c.  Ingo, are you using a
>     Lee> sparc64 for your testing?
> 
> He's probably just not using modules.  There's no way LATENCY_TRACE
> can work on anything except i386, since that's the only definition of
> mcount that's provided (and if one were being anal, it would probably
> make more sense to add the config stuff to arch/i386/Kconfig rather
> than init/Kconfig).
> 

It also exists on sparc64, it's just called _mcount.

Lee

