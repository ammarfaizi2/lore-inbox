Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVFAX0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVFAX0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFAX0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:26:49 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:9490 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261452AbVFAXPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:15:21 -0400
Date: Wed, 1 Jun 2005 16:19:36 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601231936.GA11536@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com> <20050601210716.GB5413@g5.random> <20050601214257.GA28196@nietzsche.lynx.com> <20050601215913.GB28196@nietzsche.lynx.com> <20050601223250.GH5413@g5.random> <20050601230244.GA11262@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601230244.GA11262@nietzsche.lynx.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 04:02:44PM -0700, Bill Huey wrote:
> > people will just assume it to be hard-RT and they could build hardware
> > with random drivers thinking that they will get the gurantee. I
> > understand it's ok with you since you're able to evaluate the RT-safety
> > of every driver you use, but I sure prefer "ruby hard" solutions that
> > don't require looking into drivers to see if they're RT-safe.
> 
> Again, this has been covered previously by this thread. It's ultimately
> about writing RT apps that have a more sophisticated use that RTAI or
> RT Linux.

Also, I'm telling you as a person that works for a well known RTOS company
that this patch is very very close to achieving the hard determinism goals
outlined. It has good latency and good overall kernel performancei and it's
much closer to your notion of "ruby" hard RT that you might realize. What's
needed to be done is largely driver mop up and nothing more that I can tell.

There hasn't been any major driver changes submitted recently with this
patch so the code base is pretty stable at the moment.

bill

