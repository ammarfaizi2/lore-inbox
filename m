Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUCAKSy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUCAKSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:18:54 -0500
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:27667 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S261172AbUCAKSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:18:32 -0500
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
From: Paul Wagland <paul@wagland.net>
To: Joachim B Haga <c.j.b.haga@fys.uio.no>
Cc: Peter Williams <peterw@aurema.com>, Timothy Miller <miller@techsource.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <yydjvflp9b8g.fsf@galizur.uio.no>
References: <fa.ftul5bl.nlk3pr@ifi.uio.no> <fa.cvc8vnj.ahebjd@ifi.uio.no>
	 <yydjvflp9b8g.fsf@galizur.uio.no>
Content-Type: text/plain
Message-Id: <1078136291.16756.5.camel@paulw-desktop.allshare.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 11:18:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-01 at 10:18, Joachim B Haga wrote:
> Peter Williams <peterw@aurema.com> writes:
> 
> >> It seems to me that much of this could be solved if the user *were*
> >> allowed to lower nice values (down to 0).
> [snip]
> >> to 10 (normal) to 20. Negative values could still be root-only.  So
> >> why shouldn't this be possible? Because a greedy user in a
>  
> > More importantly it would allow ordinary users to override root's
> > settings e.g. if (for whatever reason) the sysadmin decided to

> And it's not a *security* concern, as long as the lower values are
> still reserved.
> 
> I would say the benefit is very small (I mean: who has ever relied on
> it?) compared to the difficulties created for users.

Under Linux, I can't say, but certainly on my old school machine (~10
years ago) all student accounts would run at +5, all staff accounts
would run at +0. This was handled by the login process, so re-logging in
would not help you at all....

Cheers,
Paul

