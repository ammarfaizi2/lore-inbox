Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311709AbSCNSXH>; Thu, 14 Mar 2002 13:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311711AbSCNSW6>; Thu, 14 Mar 2002 13:22:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24973 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311709AbSCNSWy>; Thu, 14 Mar 2002 13:22:54 -0500
Date: Thu, 14 Mar 2002 10:22:34 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>, oliend@us.ibm.com
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
Message-ID: <41140000.1016130154@flay>
In-Reply-To: <546494477.1016087693@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.33.0203141426200.1477-100000@biker.pdb.fsc.net> <546494477.1016087693@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Btw is it correct that one could also use the APIC Task Priority Registers
>> to implement "fair" IRQ routing? (If linux adjusted them, which it
>> currently doesn't).
> 
> Yes, and Dave Olien has already done this. It's a good idea for P3,
> and seems to me to be essential for P4. 
> 
> Dave, can you republish your patch?

Apparently he's out for a few days. I poked around, and here's the latest
version of his stuff I can find:

http://sourceforge.net/project/showfiles.php?group_id=8875

Look under "APIC routing". Read the notes carefully - you have to
activate it from the command line.


M.

