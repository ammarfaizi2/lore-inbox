Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264802AbSJVRZs>; Tue, 22 Oct 2002 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264783AbSJVRZs>; Tue, 22 Oct 2002 13:25:48 -0400
Received: from main.gmane.org ([80.91.224.249]:48019 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S264802AbSJVRZq>;
	Tue, 22 Oct 2002 13:25:46 -0400
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Son of crunch time: the list v1.2.
Date: Tue, 22 Oct 2002 13:32:49 -0400
Message-ID: <ap420c$m3v$1@main.gmane.org>
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com> <200210211642.10435.landley@trommello.org> <3DB4BD8F.1010707@pobox.com>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1035307852 22655 130.127.121.177 (22 Oct 2002 17:30:52 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Tue, 22 Oct 2002 17:30:52 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>>>>10) EVMS (Enterprise Volume Management System) (EVMS team)
>>>>http://sourceforge.net/projects/evms
>>>
>>>Sounds like 2.7.x material, viro pointed out several problems ...
>> 
>> 
>> This one's a problem.  LVM1 is dead, so either LVM2 or EVMS are needed to
>> avoid a major functional regression vs 2.4...
> 
> A political regression only...  if EVMS is not good enough for inclusion
> in mainline, vendors can merge it and/or LVM2 to avoid problems.  _We_
> have higher standards for quality :)  If no LVM is ready for 2.6.x, we
> have no LVM.  It's that simple...  If no one has stepped up to clean up
> LVM1, and LVM2 and EVMS are not ready for inclusion, there's not much we
> can do about it.  That's _not_ a reason to merge crap...
> 

As was stated by Dave Jones[1], this is something that will probably should 
go in after the freeze.  I'm afraid that having seperate patches is just 
unacceptable.  There are many of us out there who use LVM, and I don't 
think it is appropriate to release a kernel without it.  Obviously you 
haven't been paying attention because Joe Thornber has been actively honing 
the device mapper interface over the last couple of weeks.  AFAICT, he has 
addressed all of the issues which were discussed in the critique of his 
code.  Alan's had it in his tree for awhile now, which shows that it is at 
least partially suitable.  When it's ready to go in, I'm sure it'll meet 
your standards.  As for EVMS, I'd consider that a whole different beast.  
Can you mount LVM partitions with using EVMS tools?  We should probably 
keep the two seperate if this is not the case.

Cheers,
Nicholas

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=103520598902877&w=2


