Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbUKRRDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbUKRRDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbUKRRDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:03:19 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:47242 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262780AbUKRRCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:02:51 -0500
From: kernel-stuff@comcast.net
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64: Many Lost ticks
Date: Thu, 18 Nov 2004 17:02:37 +0000
Message-Id: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 11 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried all the newer kernels including -ac. All have the same problem.

Andi -  On a side note, your change  "NVidia ACPI timer override" present in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a unusual power management setup?") and DMA timeouts - happens regularly.

Parry.


> On Thu, 18 Nov 2004, Andi Kleen wrote:
> 
> > On Thu, Nov 18, 2004 at 04:02:55AM +0000, kernel-stuff@comcast.net wrote:
> > > I have a X86_64 laptop (Compaq Presario R3240) with all BIOS updates in 
> place. I routinely get the "Warning : many lost ticks" message in dmesg. 
> > 
> > Known problem.  ACPI uses a broken way to access the EC register,
> > and VIA chipsets take extremly long for this operation.  This
> > happens regularly to read the system temperature.
> > A fix is currently being discussed. 
> 
> It's an nforce3, do those also have a similar issue? I have similar 
> hardware and rarely see it, could you test a newer kernel?
