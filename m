Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbULPCma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbULPCma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbULPCm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:42:29 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:32188 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261914AbULPCmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 21:42:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: realtime preempt 2.6.10-rc3-mm1-V0.33-0
Date: Wed, 15 Dec 2004 21:42:23 -0500
User-Agent: KMail/1.7
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
References: <200412141123.02293.gene.heskett@verizon.net> <200412151212.17243.gene.heskett@verizon.net> <41C07352.1040703@nortelnetworks.com>
In-Reply-To: <41C07352.1040703@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412152142.23837.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 20:42:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 12:24, Chris Friesen wrote:
>Gene Heskett wrote:
>> Thats a debian/morphix based release, does anyone know the inittab
>> setting for a non x boot with full facilities?, I'm confused, too
>> many years of redhat experience :(
>
>I think that would be level 3.
>
>Chris

Thanks.  But I was just fooling with it again just now, trying to get
the networking to work (and failing miserably, ping losses are circa
70%) by resetting the MTU to 1492 like the rest of my system is
forced into by the DSL overhead.  I've changed the *only* 1500 that
was 'grep'able in the whole /etc tree, which is in
/etc/sysconfig/networking-scripts/ifcfg-eth0 to a MTU=1492 and have
restarted the networking several times without effecting the change.
ISTR I added that MTU statement to that file earlier, but at 1492,
how it got reset to 1500, damnifIknow.

It got my attention that even though the default inittab setting is
for runlevel 2, it is not even attempting to start the Xserver now,
giving me a root login right on the terminal, and a startx fails
because it cannot A find a screen now, and B find a usb mouse I just
plugged in because the ps2 mouse was such a dawg.  The mouse works
just fine when that same machine is booted to FC3RC3.  And the
networking doesn't work there either, same symptoms.  The yellow led
on the interface jack is blinking rapidly.  NDI what that means.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

