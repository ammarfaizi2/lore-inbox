Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSGZT7a>; Fri, 26 Jul 2002 15:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSGZT73>; Fri, 26 Jul 2002 15:59:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30371 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318502AbSGZT73>;
	Fri, 26 Jul 2002 15:59:29 -0400
Date: Fri, 26 Jul 2002 22:01:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rohan Deshpande <rohan@myeastern.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3-ac3 --> sched.c errors
In-Reply-To: <20020726182151.GA3392@myeastern.com>
Message-ID: <Pine.LNX.4.44.0207262159530.23120-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Jul 2002, Rohan Deshpande wrote:

> Upon compiling kernel 2.4.19rc3-ac3, I have been getting the following
> errors.  GCC is 2.95.4, on Debian Unstable.  Config is also attached.
> 
> --> begin errors <--
> 
> sched.c: In function `task_rq_lock':
> sched.c:176: structure has no member named `cpu'

i suspect the patching must have failed somewhere - this looks like as if
only half of the O(1) scheduler patch had been applied. Exactly what
patches have you applied to what tree, in what order?

	Ingo

