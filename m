Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbVHYGYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbVHYGYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbVHYGYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:24:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45460 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750926AbVHYGYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:24:14 -0400
Date: Thu, 25 Aug 2005 08:24:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: "lkml, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-rt9
Message-ID: <20050825062449.GA27110@elte.hu>
References: <20050818060126.GA13152@elte.hu> <43065440.5050608@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43065440.5050608@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> Ingo Molnar wrote:
> >i have released the 2.6.13-rc6-rt9 tree, which can be downloaded from 
> >the usual place:
> >
> >  http://redhat.com/~mingo/realtime-preempt/
> >
> 
> I'm looking into getting HRT and RT booting on a SUMMIT NUMA machine 
> (cyclone timer), but after s/error/warning/ in 
> arch/i386/timers/timer.c for the HRT cyclone ifdef, I still get the 
> following link error:

should be fixed in 2.6.13-rc6-rt12 and later patches.

	Ingo
