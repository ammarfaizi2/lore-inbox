Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283603AbRK3LBE>; Fri, 30 Nov 2001 06:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283601AbRK3LAy>; Fri, 30 Nov 2001 06:00:54 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:53633 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283610AbRK3LAj>; Fri, 30 Nov 2001 06:00:39 -0500
Date: Fri, 30 Nov 2001 13:05:33 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: XT-PIC vs IO-APIC and PCI devices
Message-ID: <Pine.LNX.4.33.0111301241410.4564-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I'm trying to get a PCI device (network) to work on one of my
boxes, and thus far i've only managed to get it to work with "noapic".
Without that kernel option the card stops processing interrupts (as can be
observed in /proc/interrupts) after about ~100 on each CPU. Are there any
things i should look out for when trying to track down the problem?
I've tried swapping the card around in different slots just in case it
was an IRQ routing problem (as suggested by various folks) to no avail.
The box is an IBM Netfinity 3500M20 SMP rig.

Any suggestions would be greatly appreciated,

Regards,
	Zwane Mwaikambo


