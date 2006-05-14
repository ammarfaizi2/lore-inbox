Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWENQEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWENQEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWENQEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:04:42 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:415 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751483AbWENQEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:04:41 -0400
Date: Sun, 14 May 2006 12:04:22 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: akpm@osdl.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] update comment in rtmutex.c and friends
In-Reply-To: <200605141728.05752.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.58.0605141158510.24209@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605131846250.2208@gandalf.stny.rr.com>
 <200605141728.05752.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 May 2006, Ingo Oeser wrote:

> >
> > -static void
> > +static vid

  (buries head in sand)

>
> Typo here.

Yeah, I already sent Andrew an apology offline. It was a result of
hanging out with Thomas Gleixner to 2am drinking Hefe Weisens.  He
even reviewed the patch (unfortunately, he was in the same state as I
was).  You think that I could still send a patch that just changes
comments without breaking code.

>
> >  rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
> >  		   unsigned long mask)
> >  {
> > @@ -365,6 +371,7 @@ static int try_to_take_rt_mutex(struct r
>
> PS: Compile testing ANY changes to *.c and *.h files
> 	will catch most obvious brown paper bag typos for you :-)

;)  I do compile all my patches, but this one had beer muscles :)

No more drunken patches.

>
> Regards
>
> Ingo Oeser
>

Thanks,

-- Steve

