Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUECHZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUECHZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 03:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUECHZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 03:25:48 -0400
Received: from [202.125.86.130] ([202.125.86.130]:2771 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261897AbUECHZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 03:25:47 -0400
Subject: Problem with spinlocks in SMP kernel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Mon, 3 May 2004 12:57:12 +0530
Content-class: urn:content-classes:message
Message-ID: <1118873EE1755348B4812EA29C55A9721D703E@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with spinlocks in SMP kernel
Thread-Index: AcQw4A0HV3BynUMHS2Wk6nE6Jg4htQ==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
 
We developed a driver for PCI card. It was compiled and working fine under non-smp kernel. But when we port it into SMP kernel it is not working. System is going to hang permanently. What problem peter got at the following site, the same problem we got here. When we don't use spinlocks it is working fine under SMP kernel also. But when we use spinlocks it is not working under SMP kernel. The link peter posted the error I am sending here. 
 
http://www.linuxtv.org/mailinglists/linux-dvb/2002/06-2002/msg00178.html
 
I tried with spin_lock_irqsave(&xxx,flags) and spin_unlock_irqrestore(&xxx,flags). Then also system halts.
 
Why system is permanently hanging? What was the problem? Is their any OS problem?
 
We are using following configuration:
 
P4 HT Processor, RealTech 8139 Network card, Redhat 9.0 Kernel version 2.4.20-8smp.
 
Thanks in advance for any help you can come up with.
 
Regards,
 
Srinivas G
 

