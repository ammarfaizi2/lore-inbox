Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTFJODL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTFJODK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:03:10 -0400
Received: from [148.126.91.37] ([148.126.91.37]:12303 "EHLO SRPSRV10.srp.gov")
	by vger.kernel.org with ESMTP id S262820AbTFJOCY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:02:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: PROBLEM:
Date: Tue, 10 Jun 2003 07:15:54 -0700
Message-ID: <02442142D964E44985AC25906AF5751ADDFCE9@srpexc1.srp.gov>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM:
Thread-Index: AcMvWs3cyPTAnbO2SA+mPIyvZGQZyg==
From: "BOVARD JAY D" <jdbovard@srpnet.com>
To: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 10 Jun 2003 14:15:55.0288 (UTC)
 FILETIME=[CE665180:01C32F5A]
X-WSS-ID: 12FB37911792832-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed SuSe v8.2. The process went smoothly and I had a beautiful working system, that one time. Every single reboot results in the following halt:

kernel BUG at ide-scsi c:512!
invalid operand: 0000 2.4.20-4GB #1 Mon Mar 17 17:54:44 UTC 2003
CPU:    0
EIP:    0010:[<c18b89f1>]    Not tainted
EFLAGS: 00010282
eax: c01f01b0    ebx: c03ac684  ecx: 00000172   edx: 0000172
esi: c1b61c60    edi: c7724c80  ebp: c03ac684   esp: c031beb4
ds: 0018   es: 0018    ss: 0018
Process swapper (pid: 0, stackpage=c031b000)
Stack: 00000000 c03ac684 00000000 c13c5520 c01f7b94 c03ac684 c1b61c60 00000000
       00000000 c7724c80 c03ac684 00000000 c13c54a0 c13c5520 c03ac480 c03ac684
       c03ac684 c01f7ed5 c03ac684 c13c5520 c77f6360 ffffffff c7786360 00000000
Call Trace:    [<c01f7b94>] [<c01f7ed5>] [<c01f818e>] [<c01f80e0>] [<c0126606>]
  [<c0122db2>] [<c0122cb9>] [<c0122aaf>] [<c010a34c>] [<c0106f90>] {<c010c5f8>]
  [<c0106f90>] [<c0106fb4>] [<c0107012>] [<c0105000>]
Modules: [(ide-scsi:<c18b8060>:<c18ba450>)]
Code: 0f 0b 00 02 2d a0 8b c1 8b 56 38 a1 f8 90 35 c0 89 d1 29 c1
 <0>Kernel panic: Aiee, killing interrupt handler!
Interrupt handler - not syncing

Thanks,
Jay Bovard
x6638


