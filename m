Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVFAO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVFAO6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVFAO6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:58:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62018
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261401AbVFAO6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:58:01 -0400
Date: Wed, 1 Jun 2005 16:57:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601145746.GK5413@g5.random>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random> <20050601144544.GA13936@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601144544.GA13936@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 04:45:44PM +0200, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > > you are wrong. This codepath is not running with interrupts disabled on 
> > > PREEMPT_RT. irqs-off spinlocks dont turn off interrupts on PREEMPT_RT.  
> > 
> > Then I'm afraid preempt-RT infringe on the patent [...]
> 
> i'd have expected you to say "oops, i was wrong, thanks for the 
> explanation", but now you come up with a completely nontechnical topic 
> instead?

Perhaps you didn't follow the story of RTAI, RTAI nanokernel adeos
etc..etc.. has all been implemented to workaround that US patent. So to
me redefining cli in any way has always been a no-way. Originally RTAI
users were infringing and they've been forced to switch to nanokernel
AFIK.

In US patents exists, if you've a problem with that it's sure not me
that you should talk with. I'd be very happy not having to come up with
nontechnical topics.

> of PREEMPT_RT - today you finally seem to have gotten closer to 
> understanding its basics ;-) ]

You also got closer to learn how and why RT has developed in linux
the way it did.

The main confusion come from the fact your patch is obviously covered by
the patent since you're redefinining cli, while I assumed it wasn't.
