Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVC3IDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVC3IDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 03:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVC3IDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 03:03:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16324 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261815AbVC3IDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 03:03:32 -0500
Date: Wed, 30 Mar 2005 10:03:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
Message-ID: <20050330080322.GC19683@elte.hu>
References: <20050325145908.GA7146@elte.hu> <1112135516.5386.27.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112135516.5386.27.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2005-03-25 at 15:59 +0100, Ingo Molnar wrote:
> > i have released the -V0.7.41-10 Real-Time Preemption patch, which can be 
> > downloaded from the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> 
> Ingo,
> 
> -15 has a typo that prevents building with my config.
> 
> Lee
> 
> --- include/linux/mm.h~	2005-03-29 17:28:57.000000000 -0500
> +++ include/linux/mm.h	2005-03-29 17:30:05.000000000 -0500
> @@ -845,7 +845,7 @@
>  #else
>   static inline int check_no_locks_freed(const void *from, const void *to)
>   {
> -	return 0
> +	return 0;

thanks - applied this to 41-20.

	Ingo
