Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTLEU4Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTLEU4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:56:24 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:18952 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S264400AbTLEU4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:56:23 -0500
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Jesse Allen'" <the3dfxdude@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Catching NForce2 lockup with NMI watchdog
Date: Fri, 5 Dec 2003 12:56:20 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jesse Allen [mailto:the3dfxdude@hotmail.com] 
> Sent: Friday, December 05, 2003 12:36 PM
>
> Do you know whether the nforce2's with apic support the timer 
> (IRQ 0) in 
> IO-APIC mode?  To me, it seems like a bug:
> "Dec  4 20:13:11 tesore kernel: ..MP-BIOS bug: 8254 timer not 
> connected to 
> IO-APIC"
> (This message originates in arch/i386/kernel/io_apic.c)
> 

Yes, Win 9x/2k/XP use the system timer on irq0 and have no problem.  I
haven't looked at this yet.

-Allen
