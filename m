Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWC3Mkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWC3Mkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWC3Mkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:40:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19333 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932152AbWC3Mkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:40:35 -0500
Date: Thu, 30 Mar 2006 14:38:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060330123805.GA18726@elte.hu>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <20060330121030.GA14621@elte.hu> <20060330121638.GA13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330121638.GA13476@suse.de>
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


* Jens Axboe <axboe@suse.de> wrote:

> > I agree with the purpose of making sys_splice() generic and in 
> > particular usable in scripts/shells where pipes are commonly used, but 
> > we should also fulfill the original promise (outlined 15 years ago or 
> > so) and not limit this to pipes. That way i could improve TUX to make 
> > use of it for example ;)
> 
> There's absolutely no reason why we can't add fd -> fd splicing as 
> well, so no worries. Right now we just require a pipe transport. It's 
> extendable :-)

ok :) I think this code should be merged into v2.6.17 - it's very clean 
and unintrusive.

	Ingo
