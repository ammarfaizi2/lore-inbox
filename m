Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312264AbSCRJLV>; Mon, 18 Mar 2002 04:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312262AbSCRJLM>; Mon, 18 Mar 2002 04:11:12 -0500
Received: from slip-202-135-75-213.ca.au.prserv.net ([202.135.75.213]:24982
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312264AbSCRJK5>; Mon, 18 Mar 2002 04:10:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, rgooch@ras.ucalgary.ca
Subject: Re: bit ops on unsigned long? 
In-Reply-To: Your message of "Mon, 18 Mar 2002 01:03:30 CDT."
             <3C958332.4050508@mandrakesoft.com> 
Date: Mon, 18 Mar 2002 20:13:10 +1100
Message-Id: <E16mtCt-00013Y-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C958332.4050508@mandrakesoft.com> you write:
> David S. Miller wrote:
> 
> >   From: Rusty Russell <rusty@rustcorp.com.au>
> >   Date: Sat, 16 Mar 2002 14:08:08 +1100
> >
> >   +#ifdef CONFIG_PREEMPT
> >    	/* Set the preempt count _outside_ the spinlocks! */
> >    	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
> >   +#endif
> >
> >This part of your patch has to go.  Every port must
> >provide the preempt_count member of thread_info regardless
> >of the CONFIG_PREEMPT setting.

Sorry, slipped in so I could compile on PPC.  Discard that part of the
patch please.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
