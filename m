Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbTLKPQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbTLKPQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:16:57 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:10458 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265115AbTLKPQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:16:44 -0500
Message-ID: <3FD88A56.80303@cyberone.com.au>
Date: Fri, 12 Dec 2003 02:16:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rhino <rhino9@terra.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       wli@holomorphy.com
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au>	<20031208155904.GF19412@krispykreme>	<3FD50456.3050003@cyberone.com.au>	<20031209001412.GG19412@krispykreme>	<3FD7F1B9.5080100@cyberone.com.au>	<3FD81BA4.8070602@cyberone.com.au>	<20031211060120.4769a0e8.rhino9@terra.com.br>	<3FD82775.3050303@cyberone.com.au> <20031211124912.1c7e97e8.rhino9@terra.com.br>
In-Reply-To: <20031211124912.1c7e97e8.rhino9@terra.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rhino wrote:

>On Thu, 11 Dec 2003 19:14:45 +1100
>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
>>You won't be able to merge mine with Ingo's. Which one put the box on
>>steroids? :)
>>
>
>sorry if i wasn't clearly enough, but i merged each one of them separately on top of a wli-2. 
>that comment was for the wli changes. :)
>
>
>>Wonder whats going on here? Is this my patch vs Ingo's with nothing else 
>>applied?
>>How does plain 2.6.0-test11 go?
>>
>>Thanks for testing.
>>
>
>
>ok, this time on a plain test11.
>

I mean, what results does test11 get when running the benchmarks.

>
>hackbench:
>
>		w26						sched-SMT-C1
>
>	 50	 5.026				 50	 5.182
>	100	10.062				100	10.602
>	150	15.906				150	16.214
>
>
>time tar -xvjpf linux-2.6.0-test11.tar.bz2:
>
>		w26						sched-SMT-C1
>		
>	real	0m21.835s			real	0m21.827s
>	user	0m20.274s			user	0m20.412s
>	sys	0m4.178s				sys	0m4.260s
>
                  ^^^^^^^^
OK I guess the real 43s in your last set of results was a typo.


