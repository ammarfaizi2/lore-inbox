Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbUKCUrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUKCUrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKCUo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:44:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53899 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261875AbUKCUms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:42:48 -0500
Date: Wed, 3 Nov 2004 21:43:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041103204352.GA855@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041103134626.GA13852@elte.hu> <200411031853.03050.l_allegrucci@yahoo.it> <200411032141.05571.l_allegrucci@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411032141.05571.l_allegrucci@yahoo.it>
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


* Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:

> On Wednesday 03 November 2004 18:53, Lorenzo Allegrucci wrote:
> > On Wednesday 03 November 2004 14:46, Ingo Molnar wrote:
> > > 
> > > * Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
> > > 
> > > >   LD      init/built-in.o
> > > >   LD      .tmp_vmlinux1
> > > > net/built-in.o(.text+0x1887f): In function `netpoll_setup':
> > > > : undefined reference to `rcu_read_lock_up_read'
> > > > net/built-in.o(.text+0x188ed): In function `netpoll_setup':
> > > > : undefined reference to `rcu_read_lock_up_read'
> > > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > fixed in -V0.7.3.
> > 
> > I've just tried V0.7.3 but my PS/2 mouse and keyboard don't work.
> > No message from the kernel.  I attach my .config
> 
> Problem solved disabling ACPI.

does the same problem happen in vanilla 2.6.10-rc1-mm2 too?

	Ingo
