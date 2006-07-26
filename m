Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWGZEoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWGZEoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 00:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWGZEo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 00:44:29 -0400
Received: from [213.184.169.84] ([213.184.169.84]:42761 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030381AbWGZEo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 00:44:29 -0400
From: Al Boldi <a1426z@gawab.com>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
Date: Wed, 26 Jul 2006 07:45:33 +0300
User-Agent: KMail/1.5
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
References: <200607241857.52389.a1426z@gawab.com> <200607252127.14024.a1426z@gawab.com> <200607251940.k6PJeWbu023928@turing-police.cc.vt.edu>
In-Reply-To: <200607251940.k6PJeWbu023928@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607260745.33264.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 25 Jul 2006 21:27:14 +0300, Al Boldi said:
> > Peter Williams wrote:
> > > It's probably not a good idea to have different schedulers managing
> > > the same resource.  The way to do different scheduling per process is
> > > to use the scheduling policy mechanism i.e. SCHED_FIFO, SCHED_RR, etc.
> > > (possibly extended) within each scheduler.  On the other hand, on an
> > > SMP system, having a different scheduler on each run queue (or sub set
> > > of queues) might be interesting :-).
> >
> > What's wrong with multiple run-queues on UP?
>
> On an SMP system, you can have one CPU doing one class of scheduling (long
> timeslice for computational, for example), while another CPU is dedicated
> to doing RT scheduling, and so on.  It's not clear to me that "different
> classes per CPU" makes any real sense on a UP....

Conceptually there should be no difference between UP and MP.

Think HyperThreading.


Thanks!

--
Al

