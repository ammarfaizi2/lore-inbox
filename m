Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUIDDb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUIDDb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270028AbUIDDb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:31:56 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:56018 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S266271AbUIDDbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:31:53 -0400
Date: Fri, 03 Sep 2004 21:25:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc
 input/output-operations
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <006201c4922e$dc4b9bb0$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.lcmvbgi.1m1iepk@ifi.uio.no> <fa.fc3clr3.71gar9@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that at least with relatively current motherboards it makes sense to 
at least try the APIC support. Speaking of "works in Windows", I think APIC 
mode has a greater chance of working these days on UP motherboards because 
Microsoft is pushing motherboard/system manufacturers to support IOAPIC in 
all new designs:

http://www.microsoft.com/whdc/system/sysperf/IO-APIC.mspx


----- Original Message ----- 
From: "Daniel Egger" <degger@fhm.edu>
Newsgroups: fa.linux.kernel
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Hendrik Fehr" <s4248297@rcs.urz.tu-dresden.de>; "Linux Kernel Mailing 
List" <linux-kernel@vger.kernel.org>
Sent: Friday, September 03, 2004 11:14 AM
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc 
input/output-operations

On 03.09.2004, at 16:07, Alan Cox wrote:

> For uniprocessor machines you should avoid building with APIC support
> in
> general anyway. A lot of systems simply don't work with APIC
> uniprocessor because nobody used to use the APIC in such a
> configuration.

This statement I don't understand. Wouldn't it be pretty stupid
not to use the APIC of modern systems if available to get all
the benefits, like additional interrupts? At least my Asus A7V600
refuses to (net-)boot at all without a somewhat recent kernel *and*
APIC enabled in BIOS and kernel because the interrupt routing is
completely messed up. I'd rather let all users who have APIC
problems report on the list and wait until someone fixes the
issue instead of having them shut up and use less advanced
techniques instead unless you want to get those "but it works in
Windows" discussions going...

Servus,
       Daniel

