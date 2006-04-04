Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWDDN2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWDDN2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWDDN2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:28:43 -0400
Received: from [212.33.180.135] ([212.33.180.135]:59152 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932268AbWDDN2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:28:41 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Tue, 4 Apr 2006 16:27:09 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Peter Williams <pwil3058@bigpond.net.au>
References: <200604031459.51542.a1426z@gawab.com> <200604041012.04591.kernel@kolivas.org> <4431CC12.8060707@bigpond.net.au>
In-Reply-To: <4431CC12.8060707@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604041627.09740.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Con Kolivas wrote:
> >>>> Al Boldi wrote:
> >>>>> Also, different schedulers per cpu could be rather useful.
> >>>>
> >>>> I think that would be dangerous.  However, different schedulers per
> >>>> cpuset might make sense but it involve a fair bit of work.
> >>>
> >>> I'm curious. How do you think different schedulers per cpu would be
> >>> useful?
> >>
> >> I don't but I think they MIGHT make sense for cpusets e.g. one set with
> >> a scheduler targeted at interactive tasks and another targeted at
> >> server tasks.  NB the emphasis on might.

Exactly.

> > I am curious as to Al's answer since he asked for the feature.

Can you imagine how neat it would be to set timeslice per cpuset/workload?

> > It would be
> > easy for me to modify the staircase cpu scheduler to allow the
> > interactive and compute modes be set on a per-cpu basis if that was
> > desired.  For that to be helpful of course you'd have to manually set
> > affinity for the tasks or logins you wanted to run on each cpu(s).

Your staircase scheduler is great, and adding this feature would make it 
unique.

Thanks!

--
Al

