Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319342AbSIFTBg>; Fri, 6 Sep 2002 15:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319341AbSIFTBg>; Fri, 6 Sep 2002 15:01:36 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:8161 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319340AbSIFTBb>;
	Fri, 6 Sep 2002 15:01:31 -0400
To: "David S. Miller" <davem@redhat.com>
cc: Martin.Bligh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
In-reply-to: Your message of Fri, 06 Sep 2002 11:48:15 PDT.
             <20020906.114815.127906065.davem@redhat.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13768.1031339127.1@us.ibm.com>
Date: Fri, 06 Sep 2002 12:05:27 -0700
Message-Id: <E17nOQ8-0003a8-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020906.114815.127906065.davem@redhat.com>, > : "David S. Miller" 
writes:
>    From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
>    Date: Fri, 06 Sep 2002 11:51:29 -0700
>    
>    I see no reason why turning on NAPI should make the Apache setup
>    we have perform worse ... quite the opposite. Yes, we could use
>    Tux, yes we'd get better results. But that's not the point ;-)
> 
> Of course.
> 
> I just don't want propaganda being spread that using Tux means you
> lose any sort of web server functionality whatsoever.

Ah sorry - I never meant to imply that Tux was detrimental, other
than one case where it seemed to have no benefit and the performance
numbers while tuning for TPC-W *seemed* worse but were never analyzed
completely.  That was the actual event that I meant when I said:

	We also had some bad starts with using Tux in terms of performance
	and scalability on 4-CPU and 8-CPU machines, especially when
	combining with things like squid or other cacheing products from
	various third parties.

Those results were never quantified but for various reasons we had a
team that decided to take Tux out of the picture.  I think the problem
was more likely lack of knowledge and lack of time to do analysis on
the particular problems.  Another combination of solutions was used.

So, any comments I made which might have implied that Tux/Tux2 made things
worse have no substantiated data to prove that and it is quite possible
that there is no such problem.  Also, this was run nearly a year ago and
the state of Tux/Tux2 might have been a bit different at the time.

gerrit
