Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263122AbTC1Tuq>; Fri, 28 Mar 2003 14:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263123AbTC1Tuq>; Fri, 28 Mar 2003 14:50:46 -0500
Received: from fmr02.intel.com ([192.55.52.25]:49344 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263122AbTC1Tup>; Fri, 28 Mar 2003 14:50:45 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A239@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Mika Liljeberg <mika.liljeberg@welho.com>, linux-kernel@vger.kernel.org
Subject: RE: [2.5.66] Enormous interrupt load with ACPI
Date: Fri, 28 Mar 2003 12:01:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mika Liljeberg [mailto:mika.liljeberg@welho.com] 
> If I enable ACPI on my machine I seem to get more than 80 000 
> interrupts
> per second on IRQ9, sucking up roughly 30% of CPU time. Boot log
> appended.

> Mar 28 01:15:41 devil kernel: ACPI: INT_SRC_OVR (bus[0] 
> irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])

polarity 1 = active high
trigger 3 = level

Can you look at /proc/interrupts and tell me if irq 9 is shared with
anyone else, especially PCI devices?

Thanks -- Andy
