Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUHMF1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUHMF1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269004AbUHMF1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:27:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41622 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269003AbUHMF05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:26:57 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040812235116.GA27838@elte.hu>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu>  <20040812235116.GA27838@elte.hu>
Content-Type: text/plain
Message-Id: <1092374851.3450.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 01:27:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 19:51, Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>      
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6

My results with -O6 confirm Florian's results that when xrun_debug is
off, mlockall() does not produce a long non-preemptible section at all,
but does cause xruns in jackd.  I have no idea how this is possible.

Lee

