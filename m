Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318344AbSGRUdg>; Thu, 18 Jul 2002 16:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSGRUdg>; Thu, 18 Jul 2002 16:33:36 -0400
Received: from [207.251.72.21] ([207.251.72.21]:46861 "EHLO
	s-ny-exchconn01.island.com") by vger.kernel.org with ESMTP
	id <S318344AbSGRUdf>; Thu, 18 Jul 2002 16:33:35 -0400
Message-ID: <628900C9F8A7D51188E000A0C9F3FDFA024FF09D@S-NY-EXCH01>
From: Robert Sinko <RSinko@island.com>
To: "'Hubbard, Dwight'" <DHubbard@midamerican.com>, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: RE: Wrong CPU count
Date: Thu, 18 Jul 2002 16:35:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's interesting.  Can it be disabled?

-----Original Message-----
From: Hubbard, Dwight [mailto:DHubbard@midamerican.com]
Sent: Thursday, July 18, 2002 4:30 PM
To: Matt_Domsch@Dell.com; RSinko@island.com;
linux-kernel@vger.kernel.org
Subject: RE: Wrong CPU count


And doubles the cost of licensing software that uses per cpu licensing while
giving marginally better performance.

-----Original Message-----
From: Matt_Domsch@Dell.com [mailto:Matt_Domsch@Dell.com]
Sent: Thursday, July 18, 2002 3:01 PM
To: RSinko@island.com; linux-kernel@vger.kernel.org
Subject: RE: Wrong CPU count


> After upgrading  from kernel 2.4.7-10smp to 2.4.9-34smp using 
> the Red Hat
> RPM downloaded from RH Network, the CPU count on the machine 
> reported by
> dmesg and listed in /proc/cpuinfo was 4 rather than the actual 2.
> 
> This has occured on all 4 Dell 2650's that I've installed 
> this patch on.  I
> don't have any other mult-processor machines available to 
> test this with.

Congratulations, you purchased a fine PowerEdge 2650 with processors which
contain HyperThreading technology.  Each physical processor appears as two
logical processors.  This behaviour is expected, and correct. :-)

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


DISCLAIMER: The information contained herein is confidential and is intended
solely for the addressee(s). It shall not be construed as a recommendation
to buy or sell any security. Any unauthorized access, use, reproduction,
disclosure or dissemination is prohibited. Neither ISLAND nor any of its
subsidiaries or affiliates shall assume any legal liability or
responsibility for any incorrect, misleading or altered information
contained herein. Thank you.


