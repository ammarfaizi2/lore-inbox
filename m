Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTLMCPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTLMCPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:15:39 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:43721 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262965AbTLMCPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:15:38 -0500
Message-ID: <3FDA5842.9090109@cyberone.com.au>
Date: Sat, 13 Dec 2003 11:07:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [PATCH] improve rwsem scalability (was Re: [CFT][RFC] HT scheduler)
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au> <3FD91F5D.30005@cyberone.com.au> <Pine.LNX.4.58.0312120440400.14103@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.58.0312120440400.14103@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>On Fri, 12 Dec 2003, Nick Piggin wrote:
>
>
>>getting contended. The following graph is a best of 3 runs average.
>>http://www.kerneltrap.org/~npiggin/rwsem.png
>>
>
>the graphs are too noise to be conclusive.
>
>
>>The part to look at is the tail. I need to do some more testing to see
>>if its significant.
>>
>
>yes, could you go from 150 to 300?
>

The benchmark dies at 160 rooms unfortunately. Probably something in the 
JVM.

I'll do a larger number of runs around the 130-150 mark.


