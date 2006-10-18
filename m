Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWJRJPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWJRJPJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJRJPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:15:09 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:21378 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932146AbWJRJPH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:15:07 -0400
Subject: Re: 2.6.18-rt6
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20061018083921.GA10993@elte.hu>
References: <20061018083921.GA10993@elte.hu>
Date: Wed, 18 Oct 2006 11:14:55 +0200
Message-Id: <1161162895.3888.1.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/10/2006 11:21:19,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/10/2006 11:21:22,
	Serialize complete at 18/10/2006 11:21:22
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Ingo, 

  nice work,

On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> i've released the 2.6.18-rt6 tree, which can be downloaded from the 
> usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-mostly release. Changes since -rt4:
> 
>  - fix for module loading / symbol table crash (John Stultz)
>  - scheduler fix (Mike Galbraith)
>  - fix x86_64 NMI watchdog & preempt-rcu interaction
>  - fix time-warp false positives
>  - jiffies_to_timespec export fix (Steven Rostedt)
>  - ll_rw_block.c warning fix (Mike Galbraith)
>  - PPC updates (Daniel Walker)
>  - MIPS updates (Manish Lachwani)
>  - ARM oprofile fix (Kevin Hilman)
>  - traditional futexes queued via plists (Séstien Duguése)

  Thanks for including this in your tree.
 BTW, my name is Sébastien Dugué.

>  - (various other smaller fixes)
> 
> to build a 2.6.18-rt6 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.18-rt6
> 
> as usual, bugreports, fixes and suggestions are welcome,
> 
> 	Ingo

  Sébastien.

