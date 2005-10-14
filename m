Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVJNTLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVJNTLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVJNTLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:11:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15045 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750885AbVJNTLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:11:19 -0400
Date: Fri, 14 Oct 2005 21:11:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Rigg <lk@sound-man.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt4
Message-ID: <20051014191151.GA19538@elte.hu>
References: <E1EQUdJ-0001Lw-Pq@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EQUdJ-0001Lw-Pq@localhost.localdomain>
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


* John Rigg <lk@sound-man.co.uk> wrote:

> >I am able to apply cleanly. I am trying to see if it fixes my problem
> >or not.
> 
> Something in 2.6.14-rc4-rt4 breaks compilation with my config (with or
> without the extra patch) with following error message:
> 
>   CC      kernel/ktimers.o
> kernel/ktimers.c: In function 'check_ktimer_signal':
> kernel/ktimers.c:1100: error: request for member 'tv' in something not a structure or union
> 
> Am about to try applying the change in the patch to -rt1, which I know 
> compiles.

-rt5 should fix that build problem.

	Ingo
