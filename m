Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWCTKZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWCTKZD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWCTKZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:25:02 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33243 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750735AbWCTKZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:25:00 -0500
Date: Mon, 20 Mar 2006 11:22:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: interactive task starvation
Message-ID: <20060320102251.GB21917@elte.hu>
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org> <cone.1141774323.5234.18683.501@kolivas.org> <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu> <1142592375.7895.43.camel@homer> <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142838553.8441.13.camel@homer>
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


* Mike Galbraith <efault@gmx.de> wrote:

> <plug>
> Even a desktop running with these settings is so interactive that I 
> could play a game of Maelstrom (asteroids like thing) while doing a 
> make -j30 in slow nfs mount and barely feel it.  In a local 
> filesystem, I could't feel it at all, so I added a thud 3, irman2 and 
> a bonnie -s 2047 for good measure.  Try that with stock :)
> </plug>

great! Please make sure all the patches make their way into -mm. We 
definitely want to try this for v2.6.17. Increasing starvation 
resistance _and_ interactivity via the same patchset is a rare feat ;-)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
