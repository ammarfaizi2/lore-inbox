Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUCWFZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 00:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCWFZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 00:25:51 -0500
Received: from [202.125.86.130] ([202.125.86.130]:40937 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262035AbUCWFZq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 00:25:46 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Interrupts problem in 2.4.18-3smp kernel.
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Tue, 23 Mar 2004 10:51:01 +0530
Message-ID: <1118873EE1755348B4812EA29C55A972176A2C@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Interrupts problem in 2.4.18-3smp kernel.
thread-index: AcQQlqFX1FwFscaHRza1g4orfT///g==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We developed a device driver for 7x20 FM card under Linux 2.4.18-3 non
SMP kernel. It was working fine under that kernel version. We have both
SMP and non SMP kernels in one single CPU system. When we boot from non
SMP kernel, the driver was working fine without any error messages. When
we insert SD memory card into it, it is showing all the invoked function
names. When we remove SD memory card then also it is showing all the
functions names that are invoked. 

But when we boot through 2.4.18-3smp kernel then there was no interrupts
at all. Interrupts are not generating at all. What is the mistake in the
code? Where we have to change the code? Why interrupts are not
generating when we boot from 2.4.18-3smp kernel. Please anybody help in
this regard. And interrupt signal is always glowing only. But when we
boot from 2.4.18-3 non SMP kernel it was not showing any thing - not
glowing continuously.

Thanks in advance.

Srinivas G

