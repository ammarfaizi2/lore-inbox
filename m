Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWCaGE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWCaGE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWCaGE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:04:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:4252 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751004AbWCaGE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:04:27 -0500
Date: Fri, 31 Mar 2006 08:01:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
Message-ID: <20060331060155.GA21975@elte.hu>
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com> <4429BCAC.80208@tmr.com> <20060329152643.GA13194@elte.hu> <442C3F3F.5050107@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442C3F3F.5050107@tmr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Davidsen <davidsen@tmr.com> wrote:

> >>>There are no such situations anymore in an optimal userlevel
> >>>implementation.  The last problem (in pthread_cond_signal) was fixed
> >>>by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
> >>>at is simply not optimized for the modern kernels.
> >>What are you suggesting here, that the kernel can be inefficient as 
> >>long as the user has a way to program around it?
> >
> >What are you suggesting here, that FUTEX_WAKE_UP is a "user way to 
> >program around" an inefficiency? If yes then please explain to me why 
> >and what you would do differently.
> 
> The point I'm making is that even if an application is "not optimized 
> for modern kernels" or whatever, there's no reason to ignore 
> inefficiencies. [...]

What are you suggesting here, that the implementation of FUTEX_WAKE_UP
is "ignoring inefficiencies"? Please explain why and what you would do
differently to solve that inefficiency.

	Ingo
