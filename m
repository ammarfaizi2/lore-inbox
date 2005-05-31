Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVEaUQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVEaUQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVEaUQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:16:12 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:48888 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261400AbVEaUQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:16:05 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andi Kleen <ak@muc.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, karim@opersys.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       James Bruce <bruce@andrew.cmu.edu>, kus Kusche Klaus <kus@keba.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <bhuey@lnxw.com>
Date: Tue, 31 May 2005 13:14:40 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: RT patch acceptance
In-Reply-To: <20050531200114.GD9372@muc.de>
Message-ID: <Pine.LNX.4.62.0505311312410.19864@qynat.qvtvafvgr.pbz>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
 <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com>
 <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com>
 <429B9E85.2000709@opersys.com> <1117556975.2569.37.camel@localhost.localdomain>
 <20050531200114.GD9372@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

how much of a slowdown is it?

distros already throw >20% performance improvements on the floor to 
simplify their lives by reduceing the number of different binary kernels 
they have to support.

somehow I don't think a 5% or so (which is the locking overhead of running 
a SMP kernel on UP last I heard) would be the end of the world for them, 
especially if it made multimedia eye candy work smoother.

David Lang

  On Tue, 31 May 2005, Andi Kleen wrote:

> Date: 31 May 2005 22:01:14 +0200  Tue, 31 May 2005 22:01:14 +0200
> From: Andi Kleen <ak@muc.de>
> To: Steven Rostedt <rostedt@goodmis.org>
> Cc: karim@opersys.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
>     hch@infradead.org, dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
>     Sven-Thorsten Dietrich <sdietrich@mvista.com>,
>     James Bruce <bruce@andrew.cmu.edu>, kus Kusche Klaus <kus@keba.com>,
>     Nick Piggin <nickpiggin@yahoo.com.au>, Esben Nielsen <simlo@phys.au.dk>,
>     "Bill Huey (hui)" <bhuey@lnxw.com>
> Subject: Re: RT patch acceptance
> 
> On Tue, May 31, 2005 at 12:29:35PM -0400, Steven Rostedt wrote:
>> I would assume that the distros would ship without PREEMPT enabled
>> because it was (and probably still is) considered unstable.
>
> In addition to that it is slow too due to much increased locking
> overhead.
>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
