Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUCALp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUCALp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:45:29 -0500
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:47559 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261222AbUCALpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:45:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] SMT Nice 2.6.4-rc1-mm1
Date: Mon, 1 Mar 2004 22:45:01 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200403011752.56600.kernel@kolivas.org> <200403012225.59538.kernel@kolivas.org> <4043205C.7050109@cyberone.com.au>
In-Reply-To: <4043205C.7050109@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403012245.01776.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004 10:37 pm, Nick Piggin wrote:
> Con Kolivas wrote:
> >On Mon, 1 Mar 2004 05:52 pm, Con Kolivas wrote:
> >>This patch provides full per-package priority support for SMT processors
> >>(aka pentium4 hyperthreading) when combined with CONFIG_SCHED_SMT.
> >
> >And here are some benchmarks to demonstrate what happens.
> >P4 3.06Ghz booted with bios HT off as UP (up), SMP with mm1(mm1), SMP with
> >mm1-smtnice(sn)
>
> Pretty impressive numbers.
>
> How does it go on the desktop when running mprime at nice +19?

Woops forgot to answer this one. Since this was the problem that started it 
all you can imagine it works well and indeed I find it works very nicely. 
Actually I tend to run two mprime clients with affinity set for each logical 
cpu and it's not noticable. Previously one mprime client would make the 
machine run at half speed and it was painfully obvious.

Con
