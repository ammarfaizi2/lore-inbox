Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUJOL63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUJOL63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUJOL62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:58:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49052 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267725AbUJOL6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:58:13 -0400
Date: Fri, 15 Oct 2004 13:58:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Daniel Walker <dwalker@mvista.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
Message-ID: <20041015115858.GA23299@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015022341.GA22831@nietzsche.lynx.com> <20041015070839.GA8373@elte.hu> <416FB8B4.6080908@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416FB8B4.6080908@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> >>>i have released the -U2 PREEMPT_REALTIME patch:
> >>>
> >>> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2
> >>
> >>mm/shmem.c: In function `shmem_dir_map':
> >>mm/shmem.c:103: warning: implicit declaration of function `kmap_atomic_rt'
> >>mm/shmem.c:103: error: `KM_USER0' undeclared (first use in this function)
> >
> >
> >as a workaround enable HIGHMEM and PREEMPT_TIMING+LATENCY_TRACE.
> >
> >(i fixed this in my tree, will be in -U3.)
> >
> >	Ingo
> >
> Sorry Bill. Is there a brown paper bag you can get that is not for 
> writing the bug but misdiagnosing it? :)

no you thief! Are you trying to steal my preciousss? :-)

	Ingo
