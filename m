Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVGHQvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVGHQvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVGHQvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:51:35 -0400
Received: from smtpgate.newisys.com ([208.190.191.186]:25247 "EHLO
	mail2.newisys.com") by vger.kernel.org with ESMTP id S262714AbVGHQv2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:51:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Instruction Tracing for Linux
Date: Fri, 8 Jul 2005 11:51:20 -0500
Message-ID: <DC392CA07E5A5746837A411B4CA2B713010D7790@sekhmet.ad.newisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Instruction Tracing for Linux
Thread-Index: AcWD3UQxtMJHqApvSBmZL0Ex6PFQLA==
From: "Adnan Khaleel" <Adnan.Khaleel@newisys.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm a hardware designer and I'm interested in collecting dynamic execution traces in Linux. I've looked at several trace toolkits available for Linux currently but none of them offer the level of detail that I need. Ideally I would like to be able to record the instructions being executed on an SMP system along with markers for system or user space in addition to process id. I need these traces in order to evaluate the data sharing, coherence traffic etc in larger SMP systems. I've tried several other approaches to collecting execution traces namely via machine emulators etc but so far I've been dogged with the problem of trying to get any OS up and running stably on a multiprocessor configuration.

Is there a Linux kernel patch that will let me do this? I have considered using User Mode Linux but I'm not sure if this is the correct approach either - if any of you think that this is the easier path, I'd be interested in exploring this more. Other things that have crossed my mind is to use a gdb or the kernel debugger interface in order to collect the instructions but I'm not sure if this would be the correct path. Also I do require the tool/patch to be  stable enough so that I can run commercial benchmarks on it reliably.

I understand that recording every executed instruction can considerably slow down the application and may be considerably different from the freely running application but nevertheless I think that some trace is better than no trace and this is where I am at the moment.

If any of you have had experiences in profiling the kernel etc by collecting actual kernel instructions executed, I'd be interested in seeing if that may be extended for my purpose.

Thanks

Adnan

PS: I'm not subscribed to this mailing list so I'd appreciated if you would cc me on the responses.


