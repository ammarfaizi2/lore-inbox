Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSGRU1x>; Thu, 18 Jul 2002 16:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSGRU1w>; Thu, 18 Jul 2002 16:27:52 -0400
Received: from castle2.midamerican.com ([204.124.192.1]:11925 "HELO
	castle2.midamerican.com") by vger.kernel.org with SMTP
	id <S318285AbSGRU1w> convert rfc822-to-8bit; Thu, 18 Jul 2002 16:27:52 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Wrong CPU count
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Thu, 18 Jul 2002 15:29:48 -0500
Message-ID: <FE7D223FAA62A7429CFEF2669FDF17BC0CF397@DMEVS02.mec.i.midamerican.com>
Thread-Topic: Wrong CPU count
Thread-Index: AcIullCCQUzyl2RAT4maqhUibQALkgAA1sKw
From: "Hubbard, Dwight" <DHubbard@midamerican.com>
To: <Matt_Domsch@Dell.com>, <RSinko@island.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Jul 2002 20:29:48.0295 (UTC) FILETIME=[DC6F4970:01C22E99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And doubles the cost of licensing software that uses per cpu licensing while giving marginally better performance.

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
