Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUHQH4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUHQH4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268140AbUHQH4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:56:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44994 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268139AbUHQH4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:56:02 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>, tytso@mit.edu
In-Reply-To: <20040817074826.GA1238@elte.hu>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092374851.3450.13.camel@mindpipe>
	 <1092375673.3450.15.camel@mindpipe> <20040813103151.GH8135@elte.hu>
	 <1092699974.13981.95.camel@krustophenia.net>
	 <20040817074826.GA1238@elte.hu>
Content-Type: text/plain
Message-Id: <1092729419.816.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 03:56:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 03:48, Ingo Molnar wrote:
> > +	return nbytes;
> > +    
> 
> since this effectively disables the random driver i cannot add it to the
> patch.
> 

Yes, I figured as much, this is more of a temporary workaround, so we
can continue to identify other issues - otherwise this one shows up
constantly in latency_trace.

> there's another thing you could try: various SHA_CODE_SIZE values in
> drivers/char/random.c. Could you try 1, 2 and 3, does it change the
> overhead as seen in the trace?
> 

Sure, I will test this.

Lee

