Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTCCKCJ>; Mon, 3 Mar 2003 05:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTCCKCJ>; Mon, 3 Mar 2003 05:02:09 -0500
Received: from rzserv1.gsi.de ([140.181.96.11]:26105 "EHLO rzserv1.gsi.de")
	by vger.kernel.org with ESMTP id <S262492AbTCCKCI>;
	Mon, 3 Mar 2003 05:02:08 -0500
Message-ID: <3E632A82.3090304@GSI.de>
Date: Mon, 03 Mar 2003 11:12:18 +0100
From: ChristopherHuhn <c.huhn@gsi.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de-de, en-us, fr-fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Zwane Mwaikambo <zwane@linuxpower.ca>, Walter Schoen <w.schoen@GSI.de>
Subject: Re: Kernel Bug at spinlock.h ?!
References: <3E630E3D.8060405@GSI.de> <Pine.LNX.4.50.0303030348130.25240-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>Sounds like possible memory corruption (can you vouch for the reliability 
>of your RAM?) 
>
The similar problem occurs on many of our machines, so I would exclude 
memory corruption.

>Might be worthwhile posting the oops in it's entirety. Is 
>EIP normally in __run_timers? Do you run a heavy networking load?
>
The numbers crunched by these machines are loaded from and writtem to 
the net, so I would assume that.

We had these machines running potato with 2.2.21 since last summer and 
the kernel never oopsed.

Due to this fact I expect this to be a bug in the SMP code of 2.4.20 or 
a kernel misconfiguration by us.

I'll send the next oops as soon as it occurs.

Kind regards,

Christopher


