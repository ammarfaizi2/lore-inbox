Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750706AbWFEWLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWFEWLW (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWFEWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:11:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:8863 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750706AbWFEWLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:11:21 -0400
Message-ID: <4484ABF9.50503@vilain.net>
Date: Tue, 06 Jun 2006 10:11:05 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, sekharan@us.ibm.com,
        Andrew Morton <akpm@osdl.org>, Srivatsa <vatsa@in.ibm.com>,
        ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Con Kolivas <kernel@kolivas.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kingsley Cheung <kingsley@aurema.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>		<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>		<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>		<44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>		<447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>		<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra> <447FD2E1.7060605@bigpond.net.au> <447FECFD.8000602@openvz.org>
In-Reply-To: <447FECFD.8000602@openvz.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>>"nice" seems to be doing quite nicely :-)
>>    
>>
>I'm sorry, but nice never looked "nice" to me.
>Have you ever tried to "nice" apache server which spawns 500 
>processes/threads on a loaded machine?
>With nice you _can't_ impose limits or priority on the whole "apache".
>The more apaches you have the more useless their priorites and nices are...
>  
>

Yes but interactive admin processes will still get a large bonus
relative to the apache processes so you can still log in and kill the
apache storm off even with very large loads.

Sam.
