Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269126AbTBZWy4>; Wed, 26 Feb 2003 17:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269134AbTBZWy4>; Wed, 26 Feb 2003 17:54:56 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64485 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269126AbTBZWyz>; Wed, 26 Feb 2003 17:54:55 -0500
Date: Wed, 26 Feb 2003 15:05:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mark Haverkamp <markh@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.62-mjb3 (scalability / NUMA patchset)
Message-ID: <4790000.1046300707@[10.10.2.4]>
In-Reply-To: <1046300601.3375.13.camel@markh1.pdx.osdl.net>
References: <6490000.1045713212@[10.10.2.4]>
 <16170000.1046110132@[10.10.2.4]>
 <1046273777.1913.6.camel@markh1.pdx.osdl.net>
 <3090000.1046274931@[10.10.2.4]>
 <1046299742.3375.3.camel@markh1.pdx.osdl.net>
 <4140000.1046300025@[10.10.2.4]>
 <1046300601.3375.13.camel@markh1.pdx.osdl.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I turned on NMI watchdogs and when the system hung, I saw no output.
>> > My serial console is through a terminal server that isn't set up to
>> > pass along the sysrq, so I need to get this fixed.  In any case I
>> > backed out the patch that you suggested and I have had no system hangs
>> > since.
>> 
>> OK, I'll back out that patch for now, but it seems to indicate underlying
>> crud. What parameter did you set for NMI watchdog?
> 
> I set it to 1. In Documentation/nmi_watchdog.txt this looked like the
> only option.  Now that I look at apic.h, I see that I could set it to 2
> also. If you like I can try this also.

2 is what we used sucessfully last time, but I can't remember the
difference off the top of my head ... if you could try that, would be most
useful.

M.

