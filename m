Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283628AbRK3Lo5>; Fri, 30 Nov 2001 06:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283625AbRK3Loh>; Fri, 30 Nov 2001 06:44:37 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:59658 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S283624AbRK3Lo3>; Fri, 30 Nov 2001 06:44:29 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: XT-PIC vs IO-APIC and PCI devices
Date: Fri, 30 Nov 2001 11:44:28 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9u7res$3iq$2@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.33.0111301241410.4564-100000@netfinity.realnet.co.sz>
X-Trace: ncc1701.cistron.net 1007120668 3674 195.64.65.67 (30 Nov 2001 11:44:28 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0111301241410.4564-100000@netfinity.realnet.co.sz>,
Zwane Mwaikambo  <zwane@linux.realnet.co.sz> wrote:
>	I'm trying to get a PCI device (network) to work on one of my
>boxes, and thus far i've only managed to get it to work with "noapic".
>Without that kernel option the card stops processing interrupts (as can be
>observed in /proc/interrupts) after about ~100 on each CPU. Are there any
>things i should look out for when trying to track down the problem?
>I've tried swapping the card around in different slots just in case it
>was an IRQ routing problem (as suggested by various folks) to no avail.
>The box is an IBM Netfinity 3500M20 SMP rig.

What does cat /proc/interrupts say in APIC mode? Perhaps it thinks the
device uses edge-triggered interrupts instead of level-triggered ?

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

