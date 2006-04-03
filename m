Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWDCMVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWDCMVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWDCMVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:21:48 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:1507 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750785AbWDCMVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:21:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [RFC] sched.c : procfs tunables
Date: Mon, 3 Apr 2006 22:21:31 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200603311723.49049.a1426z@gawab.com> <200604010044.09185.kernel@kolivas.org> <200604031459.43105.a1426z@gawab.com>
In-Reply-To: <200604031459.43105.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604032221.32461.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 21:59, Al Boldi wrote:
> Con Kolivas wrote:
> > None of the current "tunables" have easily understandable heuristics.
> > Even those that appear to be obvious, like timselice, are not. While
> > exporting tunables is not a bad idea, exporting tunables that noone
> > understands is not really helpful.
>
> Couldn't this be fixed with an autotuning module based on cpu/mem/ctxt
> performance?

You're assuming there is some meaningful relationship between changes in 
cpu/mem/ctxt performance and these tunables, which isn't the case. 
Furthermore if this was the case, noone understands it, can predict it or 
know how to tune it. Just saying "autotune it" doesn't really tell us how 
exactly the change those tunables in relation to the other variables. Since 
Mike and I understand them reasonably well I think we'd both agree that there 
is no meaningful association.

Cheers,
Con
