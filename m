Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbRDFSHp>; Fri, 6 Apr 2001 14:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDFSHd>; Fri, 6 Apr 2001 14:07:33 -0400
Received: from [63.68.113.130] ([63.68.113.130]:21132 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S131724AbRDFSHP>;
	Fri, 6 Apr 2001 14:07:15 -0400
Date: Fri, 6 Apr 2001 11:06:03 -0700
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
Message-ID: <20010406110603.A1599@osdlab.org>
In-Reply-To: <20010404151632.A2144@kochanski> <18230000.986424894@hellman> <20010405153841.A2452@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010405153841.A2452@osdlab.org>; from wookie@osdlab.org on Thu, Apr 05, 2001 at 03:38:41PM -0700
From: "Timothy D. Witham" <wookie@osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy D. Witham wrote :
[...]
> I propose that we work on setting up a straight forward test harness   
> that allows developers to quickly test a kernel patch against 
> various performance yardsticks.

[...
(proposed large server testbeds)
...]


  OK, so I have received some feedback on my proposal to provide a 
reference set of machines so that any kernel modifications could be 
checked across a range of machines and a range of tests.  It was 
pointed out that there are lots of smaller servers out there and 
they should be part of any test plan.  There was also some concern 
that a 4 way server didn't add any value in a test lineup. But I 
have to think that with the number of 4 ways out there they should 
be included.

  One additional piece of feedback was that any comprehensive 
characterization plan should include desktops, tablet devices and 
older machines and the performance tests that address those 
configurations usage models and I agree that it is something that 
needs to be done. But as for providing hardware for that effort the
OSDL is not the group to do that.  Hopefully somebody with an 
interest in these configurations will step forward to do that 
portion of the job.

So the server hardware configurations have evolved to look like 
the following.

	1 way, 512 MB,   2 IDE
	2 way,   1 GB,  10 SCSI (1 SCSI channel)
	4 way,   4 GB,  20 SCSI (2 channels) 
	8 way,   8 GB,  40 SCSI (4 channels) maybe Fibre Channel (FC)
       16 way,  16 GB,  80 FC   (8 channels)

The types of server applications that I have heard people express concern are:

   Web infrastructure: 
	Apache                        (SPECWEB99???)
	TUX                           (SPECWEB99???)
	Jabber                        (have their own)

   Corporate infrastructure: 
	NFS                           (SPECSFS2.0???)
	raw TCP/IP performance
	Samba                         (Have their own)
	email                         (SPECMAIL2001???)

   Database performance: 
	 Raw storage I/O performance  (various)
	 OLTP workload                (something like TPC-C???)
	 OLAP workload

   General usage: 
	compile speed (usually measured by kernel compile)

  
Further comments?  I will start contacting folks who have expressed
interest.
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2455     (fax)

