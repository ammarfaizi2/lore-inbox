Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263658AbUDTRna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbUDTRna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 13:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbUDTRna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 13:43:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50066 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263658AbUDTRn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 13:43:28 -0400
Subject: sched_domains and Stream benchmark
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Content-Type: text/plain
Message-Id: <1082482996.2711.17.camel@farah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 10:43:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

You have mentioned the stream benchmark when reporting on the
performance of the Opteron NUMA sched-domains scheduler.  I am trying to
reproduce your results and am struggling with the benchmark.  Can you
rpovide the details of the tests you ran.  Namely your compiler
settings, compile command line, and your value of N.  Also I didn't see
how to specify the number of threads to run, how did you specify that? 
I have a 4 way 1.4 GHz 1MB cache opteron machine with 7 GB of RAM.

When I ran the steeam_omp benchmark with N=4000000 I got nearly
identical results (within statistical noise) from 2.6.5, 2.6.5-mm5, and
2.6.5-mm5-with_flat_domains (the patch I sent earlier).  Clearly not
what is expected, so I assume I am not running or building the benchmark
correctly.  I found the projects build system (none) and docs (minimal)
to be lacking.

You mentioned your problem was fixed by some of "Ingo's tweaks".  Which
patches are these tweaks in and are they in the mm tree yet?

Thanks,

Darren

