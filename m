Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVDBUKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDBUKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVDBUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:10:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57012 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261248AbVDBUKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:10:16 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1112470675.27149.14.camel@localhost.localdomain>
References: <20050325145908.GA7146@elte.hu>
	 <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com>
	 <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
	 <1112470675.27149.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 15:10:14 -0500
Message-Id: <1112472615.28826.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 14:37 -0500, Steven Rostedt wrote:
> What the test program does, is spawn 5 processes, each with a different
> priority. Starting with 10 and going to 14. All are SCHED_FIFO.  Each of
> these processes just do a scan of all directories starting with the root
> directory '/' and going down. I usually run this with a directory NFS
> mounted too, but I don't think this was a problem.

My knowledge of the kernel is still pretty limited, but it looks to me
like something corrupted the timer list.

Have you tried kdb?  Last time I checked it worked great with
PREEMPT_RT.

Lee

