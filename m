Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261355AbSJUM5D>; Mon, 21 Oct 2002 08:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJUM5D>; Mon, 21 Oct 2002 08:57:03 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:10932 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261355AbSJUM5C>; Mon, 21 Oct 2002 08:57:02 -0400
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1034957619.5401.8.camel@dell_ss3.pdx.osdl.net>
References: <1034915132.1681.144.camel@cog> 
	<20021018111442.GH16501@dualathlon.random> 
	<1034957619.5401.8.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 14:18:22 +0100
Message-Id: <1035206302.28189.95.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 17:13, Stephen Hemminger wrote:
> It would be great to rework the whole TSC time of day stuff to work with
> per cpu data and allow unsychronized TSC's like NUMA. The problem is
> that for fast user level access, there would need to be some way to find

The timer isnt even necessarily constant rate. The tsc is a nice tool
for debugging. Using it as a clock was not in the long run brilliant.
Don't try and continue it further, we have ACPI and HPET and other
better solutions in upcoming PC hardware.


