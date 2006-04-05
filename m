Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWDEIRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWDEIRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 04:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWDEIRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 04:17:35 -0400
Received: from dial169-41.awalnet.net ([213.184.169.41]:38674 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751174AbWDEIRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 04:17:35 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Wed, 5 Apr 2006 11:16:08 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Jake Moilanen <moilanen@austin.ibm.com>
References: <200604031459.51542.a1426z@gawab.com> <200604041627.14871.a1426z@gawab.com> <4432FF26.6050207@bigpond.net.au>
In-Reply-To: <4432FF26.6050207@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604051116.08353.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > Peter Williams wrote:
> >> Al Boldi wrote:
> >>> The default values for spa make it really easy to lock up the system.
> >>> Is there a module to autotune these values according to cpu/mem/ctxt
> >>> performance?
> >>
> >> Jake Moilanen had a genetic algorithm autotuner for Zaphod at one time
> >> which I believe he ported over to PlugSched
> >
> > Would this be a load-adaptive dynamic tuner?
>
> Yes.

Wow!

> > What I meant was a lock-preventive static tuner.  Something that would
> > take hw-latencies into account at boot and set values for non-locking
> > console operation.
>
> I'm not sure what you mean here.  Can you elaborate?

In another thread Al Boldi wrote:
> After playing w/ these tunables it occurred to me that they are really
> only deadline limits, w/ a direct relation to cpu/mem/ctxt perf.
>
> i.e timeslice=1 on i386sx means something other than timeslice=1 on amd64
>
> It follows that w/o autotuning, the static default values have to be
> selected to allow for a large underlying perf range w/ a preference for
> the high range.  This is also the reason why 2.6 feels really crummy on
> low perf ranges.
>
> Autotuning the default values would allow to tighten this range specific
> to the hw used, thus allowing for a smoother desktop experience.

> >> I could generate a patch to gather the statistic again and make them
> >> available via /proc if you would like to try a user space version of
> >> Jake's work (his was in kernel).
> >
> > That would be great!
>
> OK, I'll put it on my "to do" list.

Thanks!

--
Al

