Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSJVCKC>; Mon, 21 Oct 2002 22:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSJVCKC>; Mon, 21 Oct 2002 22:10:02 -0400
Received: from franka.aracnet.com ([216.99.193.44]:6370 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262040AbSJVCKB>; Mon, 21 Oct 2002 22:10:01 -0400
Date: Mon, 21 Oct 2002 19:13:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>, landley@trommello.org
cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
Message-ID: <2616143285.1035227635@[10.10.2.3]>
In-Reply-To: <3DB4B1B9.4070303@pobox.com>
References: <3DB4B1B9.4070303@pobox.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 5) VM large page support  (Many people) (in -mm tree)
>> http://lse.sourceforge.net/
> 
> Rob - this URL doesn't seen to have anything directly to do with large page support.
> 
> Others-
> Is this not already in the kernel?  I still want to actually see someone from Oracle actually say "I will use this" or "we find this useful".
> 
> [I cynically propose a sys_oracle and be done with it <g>]

Oracle are not the only users of this, nor the only database in
the world (though they often think they are) ;-)

There is *something* in the kernel ... whether it's useful or not
is a matter of opinion - what we see as remaining to do is to 
provide hooks for generic interfaces (eg shmem, mmap, sbrk).
 
>> 6) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm tree)
>> http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
>> (A newer version of which seems to be at:)
>> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html
> 
> IMO 2.7.x item...

Would be if it wasn't needed to alleviate all the overhead incurred
by rmap. As it is, the extra ZONE_NORMAL load kills large boxes dead ;-( 
Will provide speedups for the fork+exec cycle for the low end too.

M.

