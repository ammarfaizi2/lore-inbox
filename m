Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311627AbSCNOez>; Thu, 14 Mar 2002 09:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311628AbSCNOeq>; Thu, 14 Mar 2002 09:34:46 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:39337 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S311627AbSCNOeh>; Thu, 14 Mar 2002 09:34:37 -0500
Date: Thu, 14 Mar 2002 06:34:55 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>, oliend@us.ibm.com
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
Message-ID: <546494477.1016087693@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.33.0203141426200.1477-100000@biker.pdb.fsc.net>
In-Reply-To: <Pine.LNX.4.33.0203141426200.1477-100000@biker.pdb.fsc.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> let me know whether this fixes your problem,
> 
> The patch distributes the IRQs nicely between CPUs, but unfortunately does
> not fix our timer IRQ problem.
> 
> Btw is it correct that one could also use the APIC Task Priority Registers
> to implement "fair" IRQ routing? (If linux adjusted them, which it
> currently doesn't).

Yes, and Dave Olien has already done this. It's a good idea for P3,
and seems to me to be essential for P4. 

Dave, can you republish your patch?

M.

