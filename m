Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRDJLlP>; Tue, 10 Apr 2001 07:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDJLlF>; Tue, 10 Apr 2001 07:41:05 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:56197 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S131269AbRDJLk5> convert rfc822-to-8bit; Tue, 10 Apr 2001 07:40:57 -0400
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: ak@suse.de (Andi Kleen), mbs@mc.com (Mark Salisbury),
        jdike@karaya.com (Jeff Dike), linux-kernel@vger.kernel.org
Message-ID: <C1256A2A.003FF1BD.00@d12mta07.de.ibm.com>
Date: Tue, 10 Apr 2001 13:38:43 +0200
Subject: Re: No 100 HZ timer !
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Just how would you do kernel/user CPU time accounting then ?  It's
currently done
>> on every timer tick, and doing it less often would make it useless.
>
>On the contrary doing it less often but at the right time massively
improves
>its accuracy. You do it on reschedule. An rdtsc instruction is cheap and
all
>of a sudden you have nearly cycle accurate accounting
If you do the accounting on reschedule, how do you find out how much time
has been spent in user versus kernel mode? Or do the Intel chips have two
counters, one for user space execution and one for the kernel?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


