Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUHGSWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUHGSWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUHGSWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 14:22:51 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:49102 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S264098AbUHGSWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 14:22:46 -0400
Date: Sat, 07 Aug 2004 14:22:44 -0400
From: consolebandit@netscape.net (Maurice)
To: linux-kernel@vger.kernel.org
Subject: 2.6.xSMP and IPv4 issues
MIME-Version: 1.0
Message-ID: <07C92DE0.0827324A.345005B1@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 216.227.167.63
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I've posted this to the linux-smp list, also... Forgive the newbie in me.


I'm unable to get IPv4 running correctly when using a 2.6.xSMP kernel,
but the "same" 2.6.x non-SMP kernel will allown IPv4 to function.

I have tried a short list of the basics and searched google for help, I
also posted to my local LUG and tried a few additional things.

The hardware this is happening on is;

motherboard: ECS (elitegroup) D6VAA
NIC: netgear FA311
DHCP server: Coyote Linux, has run for about two years.



Below is the posting, two parts, to my local LUG, seeking help with the issue;


Part I

I have a box at home that's ran RH9 for about two years (or when ever 
RH9 first came out plus a month) and I've done regular RHN updates as 
time went by.

About a week ago I used some very good online directions to take my RH9 
box to Fedora C1 (using some basic RPM's and YUM) and eventhing went 
fairly well, just had to make a few adjustments...

Then a week after the now FC1 box proved to be stable and correctly 
operational I used the directions from the same site to update the FC1 
to FC2, and that seemed to go well -- better than the RH9 to FC1, or so 
it seemed.

I re-booted to see what, if anything, would fail on start-up.

I did have a failure, the FA311 NIC card could no longer get an address 
from the DHCP server???
Seems that the NIC now only "runs" IPv6, and the info I've gathered from
 the Net isn't helping me correct this -- I must be searching the wrong 
phrase(s).

Has anyone else followed this upgrade path and had the same problem?
Has anyone else moved to the 2.6 kernel and had IPv4 problems?

I've poked around and added line to certain system files and even gave 
the card a static IPv4 number -- but nothing has corrected this problem.

--------
-Maurice


"Linux -- it not just for breakfast anymore..."
-Moe





Part II

After a lot of off-list help from Phillip, the SMP kernel still wouldn't
 allow IPv4 activity...
Thanks for all your help Phillip.

I then did a fresh install of FC2, just to see, and guess what -- nope 
-- the SMP kernel still wouldn't allow IPv4 traffic, but the non-SMP 
kernel worked fine.
So then I installed SuSE 9.1 PRO, same deal, the SMP kernel would not 
allow IPv4 traffic.

I then tested several LiveCD's;
Knoppix 3.3 ,        Kernel 2.4.24-xfs #1 smp  (NO)
LindowsOS 4.5.212,   Kernel 2.4.24             (YES)
Morphix KDE 0.4.1,   Kernel 2.4.21-xfs #13 smp (NO)
SLAX 4.0.4,          Kernel 2.4.25             (YES)

The past kernel's used on the SMP box were;
RH 9,          Kernel 2.4.20-31.9           (YES)
RH 9,          Kernel 2.4.20-31.9smp        (YES)
FC1,           Kernel 2.4.22-1.2197.nptl    (YES)
FC1,           Kernel 2.4.22-1.2197.nptlsmp (YES)
FC2,           Kernel 2.6.6-1.435.2.3smp    (NO)
FC2,           Kernel 2.6.6-1.4352.2.3      (YES)
SuSE 9.1 PRO,  Kernel 2.6.4-52-smp          (NO)



So there seems to be some issue with the 2.6 kernel and SMP, maybe based
 on my motherboard and/or NIC combination???



--------
-Maurice

"Linux -- it not just for breakfast anymore..."
-Moe


__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp
