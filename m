Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbRGSMPQ>; Thu, 19 Jul 2001 08:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbRGSMO5>; Thu, 19 Jul 2001 08:14:57 -0400
Received: from [62.58.73.254] ([62.58.73.254]:13045 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S267544AbRGSMOq>; Thu, 19 Jul 2001 08:14:46 -0400
Date: Thu, 19 Jul 2001 14:05:51 +0200
From: Ryan Sweet <rsweet@atos-group.nl>
To: linux-kernel@vger.kernel.org
Subject: up kernel stable, but smp kernel randomly reboots - nfsroot - asus
 cur_dls
In-Reply-To: <20010719141707.M5559@mea-ext.zmailer.org>
Message-ID: <Pine.SGI.4.10.10107191340280.3370909-100000@iapp-0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


I posted previously about having problems with random reboots on nfsroot
nodes across kernels 2.2.18 - 2.4.6 (all kernels exhibit the same
problem - after X amount of time, where x is usually < 24 hours, the
system just reboots).  

When I run the systems with uniprocessor kernels, the problem does not
occur.

When the smp kernel is booted with noapic, the apic errors go away.  Other
posts I read about smp apic problems seemed to indicate that they received
hundreds of messages in a short period of time - I was getting maybe seven
or eight over the course of several hours.  

I can not locate any references on the net to others having trouble with
SMP in asus cur_dls boards or with the ServerWorks chipset. 

Is it possible that there is some interaction between smp and nfsroot and
cur_dls that is causing the problem (all of my other cur_dls boards are
using a local disk)?  I've tried wrapping my head around the the nfs code
to search for smp specific problems, and while I understand a lot more of
it now than I did before, it is still mostly beyond my immediate
comprehension.

Is it possible that this is a power/cpu voltage problem?  If so, would a
ups be a solution?  

Is is possible that the whole batch of 10 motherboards
is broken somehow (we have oodles of other asus cur_dls smp systems that
don't have problems, just this cluster)?

Are there any suggestions as to further troubleshooting options?

I am working on booting with a tftp downloaded ramdisk as the root, to
eliminate nfsroot from the equation, but I am skeptical as to whether this
will actually help anything.   

regards,
-ryan

-- 
Ryan Sweet <ryan.sweet@atosorigin.com>
Atos Origin Engineering Services
http://www.aoes.nl

