Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271400AbTHMGvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTHMGvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:51:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:61903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271400AbTHMGvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:51:11 -0400
Message-Id: <5.2.1.1.2.20030813084949.01a159d8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Wed, 13 Aug 2003 08:55:20 +0200
To: Mike Fedyk <mfedyk@matchmail.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: Nick Piggin <piggin@cyberone.com.au>, rob@landley.net,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20030812211137.GH1027@matchmail.com>
References: <5.2.1.1.2.20030812112325.01a06cb8@pop.gmx.net>
 <3F389221.6080202@cyberone.com.au>
 <200308110248.09399.rob@landley.net>
 <200308050207.18096.kernel@kolivas.org>
 <200308052022.01377.kernel@kolivas.org>
 <3F2F87DA.7040103@cyberone.com.au>
 <200308110248.09399.rob@landley.net>
 <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net>
 <3F389221.6080202@cyberone.com.au>
 <5.2.1.1.2.20030812112325.01a06cb8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:11 PM 8/12/2003 -0700, Mike Fedyk wrote:
>On Tue, Aug 12, 2003 at 11:42:16AM +0200, Mike Galbraith wrote:
> > At 05:18 PM 8/12/2003 +1000, Nick Piggin wrote:
> >
> > >And no, X isn't intentionally sleeping. Its being preempted which is
> > >obviously not intentional.
> >
> > Right.  Every time X wakes the gl thread, he'll lose the cpu.  Once the gl
> > thread passes X in priority, X is pretty much doomed.  (hmm... sane [hard]
> > backboost will probably prevent that)
>
>Isn't 2.4 doing exactly that for pipes and such?

At a glance, preemption appears to be primarily a matter of timeslice in 2.4.

         -Mike

