Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWCUJQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWCUJQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWCUJQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:16:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61643 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751496AbWCUJQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:16:30 -0500
Date: Tue, 21 Mar 2006 10:14:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Willy Tarreau <willy@w.ods.org>
Cc: Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: interactive task starvation
Message-ID: <20060321091422.GA9207@elte.hu>
References: <20060307152636.1324a5b5.akpm@osdl.org> <cone.1141774323.5234.18683.501@kolivas.org> <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu> <1142592375.7895.43.camel@homer> <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer> <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer> <20060321091353.GA25248@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321091353.GA25248@w.ods.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Willy Tarreau <willy@w.ods.org> wrote:

> 
> On Tue, Mar 21, 2006 at 08:51:38AM +0100, Mike Galbraith wrote:
> > On Tue, 2006-03-21 at 07:47 +0100, Willy Tarreau wrote:
> > > Hi Mike,
> > 
> > Greetings!
> 
> Thanks for the details,
> I'll try to find some time to test your code quickly. If this fixes this
> long standing problem, we should definitely try to get it into 2.6.17 !

the time window is quickly closing for that to happen though.

	Ingo
