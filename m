Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVDCJDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVDCJDc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 05:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVDCJDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 05:03:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52895 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261621AbVDCJD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 05:03:29 -0400
Date: Sun, 3 Apr 2005 01:01:39 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Paul Jackson <pj@engr.sgi.com>
Cc: mingo@elte.hu, kenneth.w.chen@intel.com, torvalds@osdl.org,
       nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403010139.275b8ece.pj@engr.sgi.com>
In-Reply-To: <20050402215332.79ff56cc.pj@engr.sgi.com>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, Paul wrote:
> Note the first 3 chars of the panic message "4.5".  This looks like it
> might be the [00]-[01] entry of Ingo's table, flushed out when the
> newlines of the panic came through.

For the record, the above speculation is probably wrong.

More likely, the first six characters "4.5(0)" of my quoted panic
message came out some time before the panic, and represent the the
[0]-[1] entry of the table.  These six chars came out at approx.
nine minutes into the calculation, and the timer panic'd the system at
ten minutes.  I didn't look at the screen between the 9th and 10th
minute, to realize that it had finally computed one table entry.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
