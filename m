Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWIVME6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWIVME6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWIVME6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:04:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7351 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932338AbWIVME5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:04:57 -0400
Date: Fri, 22 Sep 2006 13:56:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: john cooper <john.cooper@third-harmonic.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rt1
Message-ID: <20060922115636.GA12212@elte.hu>
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <45134829.9040708@third-harmonic.com> <20060922063621.GA1283@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922063621.GA1283@xi.wantstofly.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lennert Buytenhek <buytenh@wantstofly.org> wrote:

> On Thu, Sep 21, 2006 at 10:19:21PM -0400, john cooper wrote:
> 
> > >ok, i've uploaded -rt3:
> > 
> > Attached is a patch which fixes a build problem
> > for ARM pxa270, and general ARM boot issue when
> > LATENCY_TRACE is configured.
>
> This patch (queued for Linus) lifts that 4MB limitation:
> 
> 	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3809/2
> 
> (I ran into the limit when enabling lockdep on ARM.)

ok, i've added this no-4M-limit patch to -rt. John, does that solve your 
problem?

	Ingo
