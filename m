Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVLTP7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVLTP7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVLTP7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:59:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42195 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751106AbVLTP7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:59:30 -0500
Date: Tue, 20 Dec 2005 16:58:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RT 00/02] SLOB optimizations
Message-ID: <20051220155838.GA10095@elte.hu>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain> <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <1135094196.13138.306.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135094196.13138.306.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2005-12-20 at 10:44 -0500, Steven Rostedt wrote:
> > (Andrew, I'm CC'ing you and Matt to see if you would like this in -mm)
> > 
> > OK Ingo, here it is.
> 
> I just tested it out on SMP (2x), and it boots. Ingo, do you have a 
> good memory test that I can do benchmarks with?  Something better that 
> my "make install" test.

networking is the most SLAB-intensive, so your test over NFS ought to be 
pretty good already.

	Ingo
