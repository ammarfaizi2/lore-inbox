Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRAURuR>; Sun, 21 Jan 2001 12:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131266AbRAURuH>; Sun, 21 Jan 2001 12:50:07 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:47469 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131138AbRAURtx>; Sun, 21 Jan 2001 12:49:53 -0500
Date: Sun, 21 Jan 2001 11:49:52 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101211749.LAA20104@tomcat.admin.navo.hpc.mil>
To: hahn@coffee.psychology.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn <hahn@coffee.psychology.mcmaster.ca>:
> 
> > >                            microseconds/yield
> > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > ------------   ---------         --------     ---------------
> > > 16               18.740            4.603         1.455
> > 
> > I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> 
> isn't the normal case (as in "The Right Case to optimize") 
> where there are close to zero runnable tasks?  what realistic/sane
> scenarios have very large numbers of spinning threads?  all server
> situations I can think of do not.  not volanomark -loopback, surely!

How about massively parallel compute jobs when synchronizing.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
