Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVIZGrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVIZGrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVIZGrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:47:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19371 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932414AbVIZGra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:47:30 -0400
Date: Mon, 26 Sep 2005 08:48:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dwalker@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
Message-ID: <20050926064818.GA3970@elte.hu>
References: <1127345874.19506.43.camel@dhcp153.mvista.com> <433201FC.8040004@yahoo.com.au> <20050926062631.GE3273@elte.hu> <1127716753.5101.25.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127716753.5101.25.camel@npiggin-nld.site>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> On Mon, 2005-09-26 at 08:26 +0200, Ingo Molnar wrote:
> > * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > > You need my atomic_cmpxchg patches that provide an atomic_cmpxchg (and 
> > > atomic_inc_not_zero) for all architectures.
> > 
> > yeah. When will they be merged upstream?
> > 
> 
> Well they're in -mm now, you can put them in your RT tree until 
> they're in mainline... I guess realistically, 2.6.15. They should blow 
> up fairly quickly if there are any problems with them, but they simply 
> need a bit of testing on all architectures which I cannot do and I 
> suspect even -mm isn't tested on at least half of them.

very good - i'll put them into -rt.

	Ingo
