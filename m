Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUH2AZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUH2AZm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 20:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUH2AZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 20:25:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18120 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268142AbUH2AZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 20:25:40 -0400
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin
	and others)
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: spaminos-ker@yahoo.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41312174.40707@bigpond.net.au>
References: <20040828015937.50607.qmail@web13902.mail.yahoo.com>
	 <41312174.40707@bigpond.net.au>
Content-Type: text/plain
Message-Id: <1093739136.7078.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 20:25:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 20:21, Peter Williams wrote:
> spaminos-ker@yahoo.com wrote:
> > --- Peter Williams <pwil3058@bigpond.net.au> wrote:

> >     -----------------
> >  => started at: kernel_fpu_begin+0x21/0x60
> >  => ended at:   _mmx_memcpy+0x131/0x180
> > =======>
> > 00000001 0.000ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
> > 00000001 0.730ms (+0.730ms): sub_preempt_count (_mmx_memcpy)
> > 00000001 0.730ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
> > 00000001 0.730ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
> > 
> 
> As far as I can see sub_preempt_count() is part of the latency measuring 
> component of the voluntary preempt patch so, like you, I'm not sure 
> whether this report makes any sense.

Is this an SMP machine?  There were problems with that version of the
voluntary preemption patches on SMP.  The latest version, Q3, should fix
these.

Lee

