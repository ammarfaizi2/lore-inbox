Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264550AbRFSSBB>; Tue, 19 Jun 2001 14:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264556AbRFSSAv>; Tue, 19 Jun 2001 14:00:51 -0400
Received: from mx6.port.ru ([194.67.23.42]:62735 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S264550AbRFSSAe>;
	Tue, 19 Jun 2001 14:00:34 -0400
X-Copyright: sent (c) Th.Glaser. Forwarding with permission only!
Date: Tue, 19 Jun 2001 17:59:50 +0000 (UTC)
From: mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>
Reply-To: <mirabilos@ePOST.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Simone Piunno <simonep@wseurope.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: compiling with gcc 3.0
In-Reply-To: <E15CN5t-00066F-00@the-village.bc.nu>
Message-ID: <Pine.BSO.4.33.0106191758290.8843-100000@ecce.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was posted by Alan Cox where I now add my 0.02 EUR...

> > I was trying to compile 2.4.5 with gcc 3.0 but there is a problem
> > (conflicting type) between kernel/timer.c and include/linux/sched.h
> > Apparently the problem solves with this oneline workarond:
>
> Yep. Its fixed in the pre-patches I believe now. There are also a pile of
> warning fixes that need to be merging.  I would still be very wary of relying
> on a gcc 3.0.0 built kernel though

Since the rwsem had been fixed my 2.4.3-ac7 (with Andrea's generic
rwsem) has been rock solid, and it has been built with a binary snapshot
of april 2001. We don't have any problems using it yet.
I can send the .config if you want.

-mirabilos
-- 
C:\>debug
-e100 EA F0 FF 00 F0
-g
--->Enjoy!

