Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSLCOo4>; Tue, 3 Dec 2002 09:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSLCOo4>; Tue, 3 Dec 2002 09:44:56 -0500
Received: from ns2.aiinformatics.com ([193.155.169.6]:40072 "EHLO
	ns2.aiinformatics.com") by vger.kernel.org with ESMTP
	id <S261492AbSLCOoz>; Tue, 3 Dec 2002 09:44:55 -0500
Message-ID: <5AFB2DCDC21E40499BC790DD5F8957C6B12EC7@PFO-EX001.aii.aiinformatics.com>
From: Schneider Armin AII/Pforzheim <Armin.Schneider@aiinformatics.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: time loop
Date: Tue, 3 Dec 2002 15:52:14 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry for posting this message to your list ....
But I think it's a kernel issue:

We run SuSE SLES with SAP certified Kernel 2.4.18-64GB-SMP on a 2-way Intel
P3 server (Hewlett Packard).

We had the following problem:

The systems runs without any problems for a period of time (2 to 7 days).
But then the sytem date gets stucked in a loop.
=> After 3 seconds the time starts to loop.

For example:
Tue Dec 3 15:20:12 CET 2002 
Tue Dec 3 15:20:13 CET 2002 
Tue Dec 3 15:20:14 CET 2002 
Tue Dec 3 15:20:12 CET 2002 
.......

the hwclock is still running.
If you set the time via "date" to the actual time
it loops in the acutal time (in between of 3 seconds)

Tue Dec 3 15:30:44 CET 2002 
Tue Dec 3 15:30:45 CET 2002 
Tue Dec 3 15:30:46 CET 2002 
Tue Dec 3 15:30:44 CET 2002 
...

Using NTP/XNTP doesn't help ....

Please notify me personaly via CC for answers/comments/questions because I'm
no regular contributor of your list ...

Many thanks


> Armin Schneider
