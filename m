Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUDZWbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUDZWbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 18:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDZWbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 18:31:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58804 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261169AbUDZWbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 18:31:13 -0400
Subject: Re: sched_domains and Stream benchmark
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>
In-Reply-To: <m3r7uitr1r.fsf@averell.firstfloor.org>
References: <1N7xQ-7fh-29@gated-at.bofh.it>
	 <m3r7uitr1r.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1083018633.3070.8.camel@farah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 15:30:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 11:58, Andi Kleen wrote:
> Darren Hart <dvhltc@us.ibm.com> writes:
> 
> > Andi,
> >
> > You have mentioned the stream benchmark when reporting on the
> > performance of the Opteron NUMA sched-domains scheduler.  I am trying to
> > reproduce your results and am struggling with the benchmark.  Can you
> > rpovide the details of the tests you ran.  Namely your compiler
> > settings, compile command line, and your value of N.  Also I didn't see
> > how to specify the number of threads to run, how did you specify that? 
> > I have a 4 way 1.4 GHz 1MB cache opteron machine with 7 GB of RAM.
> 
> I didn't actually compile them myself; someone sent me executables
> compiled with the PGI compiler.  Maybe your compiler has a different
> runtime and behaves differently? 
> 
> You can find them and my test script that tests everything in 
> ftp://ftp.suse.com/pub/people/ak/bench/stream.tar.gz

Thanks Andi,

I noticed your binary ran with N=2000000 which is only sufficient for a
2 proc 1 MB cache opteron box according to the documentation on the
stream faq.  I also noticed wide variation in results (25% or so) when
running with 4 threads on a 4 proc opteron on linux-2.6.5-mm5.  Can you
provide me with the specs of the system you ran your tests on?

Thanks,

Darren

