Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283642AbRK3MpL>; Fri, 30 Nov 2001 07:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283643AbRK3MpC>; Fri, 30 Nov 2001 07:45:02 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:16569 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283642AbRK3Mot>; Fri, 30 Nov 2001 07:44:49 -0500
Date: Fri, 30 Nov 2001 14:49:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: <miquels@cistron-office.nl>
Subject: Re: XT-PIC vs IO-APIC and PCI devices
In-Reply-To: <Pine.LNX.4.33.0111301241410.4564-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0111301443190.23494-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It shows up as level-triggered.

	CPU0       CPU1
0:    4498447          0  local-APIC-edge  timer
1:        465       6921    IO-APIC-edge  keyboard
2:          0          0          XT-PIC  cascade
8:          0          1    IO-APIC-edge  rtc
14:          2          3    IO-APIC-edge  ide0
16:      59755      52687   IO-APIC-level  dpti0
18:     386054     576702   IO-APIC-level  eth0
22:          0          0   IO-APIC-level  pentanet0 <==
27:      25743      20344   IO-APIC-level  eth1
NMI:          0          0
LOC:    4498376    4498509

Thanks,
	Zwane Mwaikambo


