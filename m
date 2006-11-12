Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWKLSQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWKLSQo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbWKLSQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:16:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62988 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752129AbWKLSQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:16:43 -0500
Date: Sun, 12 Nov 2006 14:28:13 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
Message-ID: <20061112142813.GA4371@ucw.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com> <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz> <20061107212614.GA6730@ucw.cz> <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz> <20061107231456.GB7796@elf.ucw.cz> <Pine.LNX.4.64.0611081921170.5694@artax.karlin.mff.cuni.cz> <20061110090303.GB3196@elf.ucw.cz> <Pine.LNX.4.64.0611101606090.20654@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611101606090.20654@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>You can't tell that CPUs behave exactly 
> >>probabilistically --- it may
> >>happen that one gets out of the wait loop always too 
> >>late.
> >
> >Well,  I don't need them to be _exactly_ 
> >probabilistical.
> >
> >Anyway, if you have 2048 CPUs... you can perhaps get 
> >some non-broken
> >ones.
> 
> No intel document guarantees you that if more CPUs 
> simultaneously execute locked cmpxchg in a loop that a 

If we are talking 2048 cpus, we are talking ia64.

> CPU will see compare success in a finite time. In fact, 
> CPUs can't guarantee this at all, because they don't 
> know that they're executing a spinlock --- for them its 
> just an instruction stream like anything else.

...even i386 has monitor/mwait these days.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
