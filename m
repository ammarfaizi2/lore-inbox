Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbUKRRVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUKRRVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUKRRUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:20:55 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:33927 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262799AbUKRRTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:19:34 -0500
From: kernel-stuff@comcast.net
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: Many Lost ticks
Date: Thu, 18 Nov 2004 17:19:32 +0000
Message-Id: <111820041719.26527.419CD9A40001750D0000679F220073544600009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 11 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will send it shorltly - Till then another update - I disabled ACPI Thermal stuff and the Lost ticks due to acpi_ec_read got cured. (This was without Andi's NVIDIA Timer override patch.)

Parry.


> On Thu, 18 Nov 2004 kernel-stuff@comcast.net wrote:
> 
> > I tried all the newer kernels including -ac. All have the same problem.
> > 
> > Andi - On a side note, your change "NVidia ACPI timer override" present 
> > in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a 
> > unusual power management setup?") and DMA timeouts - happens regularly.
> 
> Interesting, could you send your dmesg, from booting with the 'debug' 
> kernel parameter. Also the output from dmidecode and lspci would be nice.
> 
> Thanks,
> 	Zwane
> 
