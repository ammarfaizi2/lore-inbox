Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUHEFCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUHEFCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267550AbUHEFAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:00:54 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:8619 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267544AbUHEE7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:59:51 -0400
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
From: Albert Cahalan <albert@users.sf.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <4111A418.5030101@yahoo.com.au>
References: <1091638227.1232.1750.camel@cube>
	 <41118AAE.7090107@bigpond.net.au> <41118D0C.9090103@yahoo.com.au>
	 <411196EE.9050408@bigpond.net.au> <41119A3B.2020202@yahoo.com.au>
	 <4111A39C.40200@bigpond.net.au>  <4111A418.5030101@yahoo.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1091672930.3547.1781.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Aug 2004 22:28:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 23:06, Nick Piggin wrote:
> Peter Williams wrote:
> 
> > Nick Piggin wrote:
> >
> >> However if you add or remove scheduling policies, your
> >> p->policy method breaks.
> >
> >
> > Not if Albert's numbering system is used.
> >
> 
> What if another realtime policy is added? Or one is removed?

What if, what if...

You're going to have to change the code anyway.
One might toss this into <linux/sched.h> to make
as a nice reminder:

#define SCHEDS_RT (SCHED_RR|SCHED_FIFO)

As it is now, SCHED_FIFO is already used as a
bit flag in one place.


