Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVEMLgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVEMLgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVEMLgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:36:24 -0400
Received: from [202.125.86.130] ([202.125.86.130]:43421 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262241AbVEMLgF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:36:05 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Y2K-like bug to hit Linux computers! - Info of the day
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 13 May 2005 17:13:31 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Y2K-like bug to hit Linux computers! - Info of the day
Thread-Index: AcVXrqvMv5M6jJ2UT0qYJAQJSZHAAw==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday, January 19 2038. Time: 03:14:07 GMT. If Linux programmers get
nightmares, it's about this date and time. Immediately after that second
is crossed, current computer systems running on Linux will grind to a
halt or go into a loop. This will trip up a lot of databases. No, this
is not another hoax raised by some anti-Linux lobby. It is Linux's own
Y2K nightmare, says Businessworld. 

If you ask what this 2038 bug is, you will have to put up some technical
argot. The bug has its origins in the way the C language, which has been
used to write Linux, calculates time. C uses the 'time_t' data type to
represent dates and times. ('time_t' is an integer that counts the
number of seconds since 12.00 a.m. GMT,  January 1 1970.) 

This data is stored in 32 bits, or units of memory. The first of these
bits is for the positive or negative sign, and the remaining 31 are used
to store the number. The highest number that these 31 bits can store
works out to 2147483647. 

Calculated from the start of January 1 1970, this number would represent
the 2038 time and date given at the top. Problems would arise when the
system times of computers running on Linux reach this number. They can't
go any forward and their value actually would change to -- 2147483647,
which translated to December 13 1901! That will lead many programs to
return errors or crash altogether. 

It's more damaging than the Y2K bug. That's because Y2K mostly involved
higher-level applications such as credit card payment and inventory
management. The 2038 bug, on the other hand, affects the basic
time-keeping function. 

"I would guess the biggest issue would be in the embedded field, where
software isn't changed all that often, if at all. Process controllers,
routers, mobile phones, game consoles, telecom switches and the like
would be the biggest victims," says Raju Mathur, GNU and Linux
consultant and president of the Linux Delhi Users Group. 

He, however, adds that the rate at which we are changing technology,
most systems are unlikely to use 32-bit processing by the time we get to
2038. 

But what about the present? Many applications running on Linux could
soon be making calculations for dates 30 years away -- say, for mortgage
and insurance calculations -- and could start giving out error messages
well before D-day. The problem could be widespread because more and more
corporates today are migrating to Linux because of the better security
it offers. 

"The problem is not on the radar of most people, except the techies,"
says Charles Assissi, editor, Chip magazine. 

How can the problem be sorted? Modern Linux programs could use 64-bit or
longer time_t data storage to overcome the problem. As for the existing
systems, the way the C language stores time_t data could be changed and
then all the programs could be recompiled. All this is easier said than
done. 

"There must be millions, if not billions of lines of C code floating
around that use the time_t value. Locating them, changing them, managing
programs for which source isn't available, updating embedded systems,
redeploying, is, in my opinion, an impossible task," says Mathur. Will
that be another lucrative opportunity for India's army of coders?
