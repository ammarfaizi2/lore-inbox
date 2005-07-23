Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVGWRLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVGWRLu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVGWRLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:11:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5829 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262374AbVGWRJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:09:23 -0400
Subject: Re: [PATCH] 2.6.13rc3: RLIMIT_RTPRIO broken
From: Lee Revell <rlrevell@joe-job.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <42E22D0C.1010608@domdv.de>
References: <42E22D0C.1010608@domdv.de>
Content-Type: text/plain
Date: Sat, 23 Jul 2005 13:09:18 -0400
Message-Id: <1122138559.15281.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-23 at 13:42 +0200, Andreas Steinmetz wrote:
> RLIMIT_RTPRIO is supposed to grant non privileged users the right to use
> SCHED_FIFO/SCHED_RR scheduling policies with priorites bounded by the
> RLIMIT_RTPRIO value via sched_setscheduler(). This is usually used by
> audio users.
>
> Unfortunately this is broken in 2.6.13rc3 as you can see in the excerpt
> from sched_setscheduler below:

Please provide the Signed-Off-By line.  Also I have cc'ed Matt Mackall,
the original author of the patch.

This should definitely make it in 2.6.13.

Lee

