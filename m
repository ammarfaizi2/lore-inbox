Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUHPDO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUHPDO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHPDO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:14:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46250 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267385AbUHPDOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:14:47 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816031420.GA10919@elte.hu>
References: <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu>
	 <20040816025846.GA10240@elte.hu>
	 <1092625901.867.130.camel@krustophenia.net>
	 <20040816031420.GA10919@elte.hu>
Content-Type: text/plain
Message-Id: <1092626132.867.132.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 23:15:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 23:14, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > i've attached mlock-test2.cc that should test this theory. The code
> > > breaks up the mlock-ed region into 8 equal pieces and does mlock() on
> > > them separately. It's basically a lock-break done in user-space. Does
> > > this change the nature of xruns?
> > 
> > This does change the xruns.  I have to `mlock-test2 8000' to produce
> > any xrun at all, and that only produces a 2-300 usec xrun.  With
> > mlockall-test the threshold to produce an xrun was ~1500.
> 
> did you try mlock-test.cc too? Just to make sure that mlock-test.cc is
> equivalent to mlockall-test.cc.
> 

That attachment was also missing.

Lee

