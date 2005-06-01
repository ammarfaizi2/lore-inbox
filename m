Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFAVNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFAVNC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFAVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:10:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5403
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261307AbVFAVJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:09:27 -0400
Date: Wed, 1 Jun 2005 23:09:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Karim Yaghmour <karim@opersys.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601210915.GC5413@g5.random>
References: <20050601143202.GI5413@g5.random> <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk> <20050601150527.GL5413@g5.random> <429DD533.6080407@opersys.com> <20050601153803.GO5413@g5.random> <1117648391.20785.7.camel@tglx.tec.linutronix.de> <20050601192224.GV5413@g5.random> <1117659367.20785.20.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117659367.20785.20.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 10:56:07PM +0200, Thomas Gleixner wrote:
> I have no permission from the customer who actually payed the survey to
> publish the results yet. But I continue asking for it.

Ok, thanks for asking ;)

> I have a slightly outdated patch with that around on top of RT, but it
> introduces yet another level of ugliness. 
> You must carefully identify the places where you really need the
> hard_local_irq_dis/enable(). It's not hard though. 
> 
> I used it in the early days of PREEMPT_RT to identify the IRQ off
> sections and some other deadlocking scenarios. I kept this always as an
> option for adding on top of Ingos implementation to close the gap to
> "ruby".

I see.
