Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290648AbSAYLzh>; Fri, 25 Jan 2002 06:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290650AbSAYLz1>; Fri, 25 Jan 2002 06:55:27 -0500
Received: from web20101.mail.yahoo.com ([216.136.226.38]:26948 "HELO
	web20101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290648AbSAYLzI>; Fri, 25 Jan 2002 06:55:08 -0500
Message-ID: <20020125115507.91489.qmail@web20101.mail.yahoo.com>
Date: Fri, 25 Jan 2002 03:55:07 -0800 (PST)
From: john carmack <migrate_linux@yahoo.com>
Subject: Re:NETDEV WATCHDOG error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------------*-------------*--------------------
Regarding the NETDEV WATCHDOG error i too had a
similar problem the system after sometime killed all
the network connections.I was connected to the another
machine then i went to have some coffee came back
after 30 mins the connection was broken.

THen i went to that pc and pressed on the key board
and then the network was ready.After a couple of times
i found that it was not returning from the suspend
mode though i didn't enable apmd at that time.

That is actually apm -s should return after some time
but unfortunately it was not returning.But this pc has
the same kernel and linux version as that and it has
no problems.

So after a lot of times i did rpm -e apmd which erares
or removes the apmd deamon and it was working properly
after that .That is rm the apmd by rpm -e apmd command
and the network was not giving me any trouble after
that.You can try it out and tell the other guys if it
works.

****************
Caution: Removing apmd can cause a serious problem if
it is a laptop or the system functionality is
completely dependent on apmd can cause considerable
damage to the system .Try this when you don't have
anything important data or if you have backup.If it
solves then fine if not try and try for a solution.
****************


This is not the solution but this can be a help
towards  attaining the solution.You can identify the
other problem easily.

What i am doing is eliminating the symptom not the
problem.Hope that soon you guys will come out with a
solution .kernel version:2.4.7-10


__________________________________________________
Do You Yahoo!?
Great stuff seeking new owners in Yahoo! Auctions! 
http://auctions.yahoo.com
