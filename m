Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbUDZQH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUDZQH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUDZQH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:07:26 -0400
Received: from relay2.paracel.com ([192.187.140.37]:27792 "EHLO
	relay2.paracel.com") by vger.kernel.org with ESMTP id S262953AbUDZQG0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:06:26 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: PROBLEM: Second processor not responding in 2.4.21 and later
Date: Mon, 26 Apr 2004 09:00:43 -0700
Message-ID: <9D8C1A43309BAD4A9B46071DAF911D9E4C8AA4@exch01.paracel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Second processor not responding in 2.4.21 and later
Thread-Index: AcQp1iQ+qqysD8laRsO+Dw2MeViwjQBzxvfg
From: "Marc Rieffel" <marc@paracel.com>
To: "Len Brown" <len.brown@intel.com>
Cc: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.4.18-27.7.xsmp                0       3314    0.0000
> > 2.4.18                  5       4206    0.0012
> > 2.4.19                  12      25786   0.0005
> > 2.4.20-pre4                     2       586     0.0034
> > 2.4.20-pre5                     2       49      0.0392
> > 2.4.20-pre6                     12      745     0.0159
> > 2.4.20                  55      3128    0.0173
> > 2.4.20-20.7smp          483     15427   0.0304
> > 2.4.21-4.0.1.ELsmp      155     7278    0.0209
> 
> While a difference between 2.4.20-pre4 and -pre5 may be a clue,
> it isn't the root cause, because they're both broken.
> Looks like only 2.4.18-27.7.xsmp (whatever that is) got 0 failures.

True, I haven't seen any failures with that kernel (which comes with Rocks 2.3.2, which is based on RH 7.3).  On the other hand, I haven't rebooted it nearly as often as the others, so I can't be confident the error doesn't occur there.

> Any chance you can run a test with, say, 2.6.5?
> It might also be interesting to know what compiler built each kernel..

I did try 2.4.26 and it has the same problem.  

I'm afraid I've already spent as much time (and as much hardware) as I can afford on this problem.  I wrote a script to reboot if processors are missing.  That should suffice for my needs for now.

If anyone else encounters this problem, or someone who knows the smp boot code or the Intel motherboards is interested in helping, please let me know and I'll see what else I can do.
