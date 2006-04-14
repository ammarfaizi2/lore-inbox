Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWDNOyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWDNOyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWDNOyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:54:17 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:12046 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964888AbWDNOyQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:54:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <MDEHLPKNGKAHNMBLJOLKAEFLLFAB.davids@webmaster.com>
x-originalarrivaltime: 14 Apr 2006 14:54:13.0564 (UTC) FILETIME=[4B79A7C0:01C65FD3]
Content-class: urn:content-classes:message
Subject: RE: GPL issues
Date: Fri, 14 Apr 2006 10:54:08 -0400
Message-ID: <Pine.LNX.4.61.0604141044130.11126@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GPL issues
Thread-Index: AcZf00uAFdfUeTzjTPilIzrrZSYy3A==
References: <MDEHLPKNGKAHNMBLJOLKAEFLLFAB.davids@webmaster.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Schwartz" <davids@webmaster.com>
Cc: "Ramakanth Gunuganti" <rgunugan@yahoo.com>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2006, David Schwartz wrote:

>
>> One thing that is clear in the GPL: If you link the kernel with something
>> else to an executable, the resulting blob (and therefore the
>> sources to the
>> proprietary part) must be GPL.
>
> 	Actually, that is *far* from clear.
>
> 	First, the GPL cannot set its own scope. The GPL could say that if you
> stored a program in the same room as a GPL program, the program must be GPL.
> So *nothing* the GPL says will answer this question -- the question is, can
> the GPL attach by linking?
>
> 	The contrary argument would be that linking two programs together is an
> automated process. There is no creative input in the linking process. So it
> does not legally produce a single work, but a mechanical combination of the
> two original works.
>
> 	The proof that the executable is not a work for copyright purposes is this
> simple -- could a person who took two object files out of the box and linked
> them together claim copyright in the new derivative work he just produced? I
> think the answer would be obvious -- the executable is not a new work, it's
> just the two original works combined.
>
> 	Note that this does not mean that *designing* a program specifically to
> link to another program can't make it a derivative work of the work you
> designed it to go with. Just that the linking itself cannot always do so
> automatically.
>
> 	In any event, to give my answer to the original question -- if a kernel
> module and a userspace program are developed together, and are not both
> derived from an API that is independent of the Linux kernel, then they are
> probably going to be considered a single work.
>
> 	On the flip side, you should be okay if you develop an API for a kernel to
> communicate with user space and then develop a user space program that could
> work on any kernel (Linux or not, theoretically) that supported that API.
> This should ensure that the user space program is derivative only from the
> API and not from the Linux kernel.
>
> 	Note that you will not be okay if the API looks like what just happen to be
> Linux kernel internals. The API itself must be independent of the Linux
> kernel internals.
>
> 	DS
>


Unfortunately copyright law is all about books, papers,
and publishing. It has been adapted to software while,
in fact, it is not relevant to software. That's the
problem.

When attempting to adapt copyright law to software one
needs to "interpret" irrelevant law. This means, that
it means, what a certain judge thinks it means, on a
particular day after hearing some boring arguments.

But there are some things about licensing that are
perfectly clear because they are not about copyright
law at all. Let's say that because I hate Microsoft,
I decide to provide a license to some software that
reads: "This software can be used by anybody, except
Microsoft, for any purpose whatsoever."

Microsoft could use this software because the
license contains an illegal exclusion that
represents "restraint of trade." As much as
you think that excluding a particular company
from using your software is correct and proper,
it is, in fact, illegal in the United states.

It is illegal because the owner of some property
(software) cannot exclude one company from using
that property unless it excludes all companies
from using it.

This is not just about companies. If K-MART was
selling or even giving away some particular item,
they couldn't refuse to give or sell to you the
same item, no matter how badly they hated you.

So, let's say that you wrote a module that allowed
a user-mode program to perform some useful thing
that had never been done before. You are certainly
not going to publish that program or you will
lose your intellectual property and be out of
business.

Some kernel-creeper decides that they will prevent
you from installing your module unless you release
all your source-code under GPL. If you were to take
this to court, you would have two problems:

(1) Who do you sue?
(2) How do you recover damages.

Instead, you make a work-around. You patch the kernel
so your module will work and you ignore the kernel-
creeper. The kernel-creeper is powerless, even in a
suit, because he tried to use illegal restraint of
trade to prevent you from using intellectual property
that belonged to you.

But, the kernel-creeper has lots of money and invective.
He hires the best lawyers in the world, keeps postponing
discovery, gets a temporary restraining order preventing
you from using you own property, then forces you into
bankruptcy.

You lost, even though you were perfectly morally, and
legally correct!

There is a work-around for this, too. Use BSD software.
Many business decisions are all about trade offs. One
of the reasons why Linux has been slow in being accepted
by industry is because some kernel-creeper can cause
a company a lot of damage. This is something to remember
as Linux developers continue to remove essential symbols
from the kernel and continue to re-write build procedures
so that industry-standard methods will no longer work
for building modules.

BSD software might not be so "great", but it works and
we can all use it.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
