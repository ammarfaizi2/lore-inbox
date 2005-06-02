Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFBI6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFBI6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFBI5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:57:53 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:11706 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261295AbVFBIwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:52:08 -0400
Date: Thu, 2 Jun 2005 10:50:41 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <bhuey@lnxw.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050601231936.GA11536@nietzsche.lynx.com>
Message-Id: <Pine.OSF.4.05.10506021048020.27013-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Bill Huey wrote:

> On Wed, Jun 01, 2005 at 04:02:44PM -0700, Bill Huey wrote:
> > > people will just assume it to be hard-RT and they could build hardware
> > > with random drivers thinking that they will get the gurantee. I
> > > understand it's ok with you since you're able to evaluate the RT-safety
> > > of every driver you use, but I sure prefer "ruby hard" solutions that
> > > don't require looking into drivers to see if they're RT-safe.
> > 
> > Again, this has been covered previously by this thread. It's ultimately
> > about writing RT apps that have a more sophisticated use that RTAI or
> > RT Linux.
> 
> Also, I'm telling you as a person that works for a well known RTOS company
> that this patch is very very close to achieving the hard determinism goals
> outlined. It has good latency and good overall kernel performancei and it's
> much closer to your notion of "ruby" hard RT that you might realize. What's
> needed to be done is largely driver mop up and nothing more that I can tell.
> 
> There hasn't been any major driver changes submitted recently with this
> patch so the code base is pretty stable at the moment.
> 
> bill
> 
I can add that even with the commercial hard-RT OS we use at work, I 
have had to rewrite 2nd source (isn't that the expression?) drivers to
make it fit into the RT world!

Esben



