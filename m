Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUCSHhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 02:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUCSHhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 02:37:37 -0500
Received: from [202.125.86.130] ([202.125.86.130]:20686 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261610AbUCSHhd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 02:37:33 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: SMP Makefile errors
Content-Transfer-Encoding: 8BIT
Date: Fri, 19 Mar 2004 13:02:52 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A9721768D8@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMP Makefile errors
thread-index: AcQNgOhUAkn/5IjZTKKi42vqrCxHqwAAyKeA
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linuxsa@linuxsa.org.au>, <linux-list@ssc.com>,
       <linux-smp@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I compiled a Device Driver in uni-processor environment under Linux
kernel 2.4.18-3. It was working fine. The same driver code I compiled in
SMP environment under Linux kernel 2.4.18-3smp. Then, it has given the
following errors.



In file included from /usr/src/linux-2.4/include/linux/irq.h:69,
                 from /usr/src/linux-2.4/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.4/include/linux/interrupt.h:45,
                 from tiisr.c:13:
/usr/src/linux-2.4/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux-2.4/include/asm/hw_irq.h:202: `current' undeclared (first
use in this function)
/usr/src/linux-2.4/include/asm/hw_irq.h:202: (Each undeclared identifier
is reported only once
/usr/src/linux-2.4/include/asm/hw_irq.h:202: for each function it
appears in.)
make: *** [tiisr.o] Error 1




Help me in this regard. What can I do to the existing driver code OR
What modifications I have to do in the Makefile.

Thanks in advance.
---Srinivas 


