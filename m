Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268297AbTCAEPe>; Fri, 28 Feb 2003 23:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268316AbTCAEPe>; Fri, 28 Feb 2003 23:15:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:28855 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268297AbTCAEPd>;
	Fri, 28 Feb 2003 23:15:33 -0500
Date: Fri, 28 Feb 2003 20:25:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: Robert Love <rml@tech9.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-Id: <20030228202555.4391bf87.akpm@digeo.com>
In-Reply-To: <1046467381.1346.261.camel@phantasy>
References: <Pine.LNX.4.44.0302281040190.8167-100000@localhost.localdomain>
	<20030228131206.22fc077c.akpm@digeo.com>
	<1046467381.1346.261.camel@phantasy>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2003 04:25:49.0094 (UTC) FILETIME=[A2F11C60:01C2DFAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> On Fri, 2003-02-28 at 16:12, Andrew Morton wrote:
> 
> > - The longstanding problem wherein a kernel build makes my X desktop
> >   unusable is 90% fixed - it is still possible to trigger stalls, but
> >   they are less severe, and you actually have to work at it a bit to
> >   make them happen.
> 
> That is odd, because I do not see any changes in here that would improve
> interactivity.  This looks to be pretty much purely the HT stuff.
> 
> Andrew, if you drop this patch, your X desktop usability drops?

hm, you're right.  It's still really bad.  I forgot that I was using distcc.

And I also forgot that tbench starves everything else only on CONFIG_SMP=n.
That problem remains with us as well.


