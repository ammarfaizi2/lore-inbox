Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272355AbTHFWLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272381AbTHFWLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:11:45 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:31497 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272355AbTHFWLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:11:44 -0400
Message-ID: <3F318021.1010409@techsource.com>
Date: Wed, 06 Aug 2003 18:24:33 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com> <1060133030.3f3058a68e126@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> Quoting Timothy Miller <miller@techsource.com>:
> 

> 
> 
> Thank you for your commentary which I agree with. With respect to these 
> potential issues I have always worked on a fix for where I thought real world 
> applications might cause these rather than try and fix it for just that program.
> It was actually the opposite reason that my patch prevented thud from working; 
> it is idle tasks that become suddenly cpu hogs that in the real world are 
> potential starvers,  and I made a useful fix for that issue. Thud just happened 
> to simulate those conditions and I only tested for it after I heard of thud. So 
> just a (hopefully reassuring) reminder; I'm not making an xmms interactivity 
> estimator, nor an X estimator, nor a "fix this exploit" one and so on.
> 


I have always assumed that things like X and xmms were just examples of 
the various sorts of things people would run when testing your scheduler.

But it was a mistaken assumption on my part that thud was an artificial 
work load.  The author of thud, I believe it was, explained to me how 
thud is a simulation of a real workload, reverse-engineered from 
real-world experience.

My apologies.


