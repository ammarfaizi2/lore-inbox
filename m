Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbUKRTIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbUKRTIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbUKRTGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:06:44 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:14064 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262894AbUKRTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:03:23 -0500
From: kernel-stuff@comcast.net
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: X86_64: Many Lost ticks
Date: Thu, 18 Nov 2004 19:03:06 +0000
Message-Id: <111820041903.1235.419CF1EA000B12B3000004D3220588601400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 11 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tried Andi's patch with noapic yet.  Will do that to see if it fixes the NMI and DMA timeouts.

And I have the latest available BIOS update applied. 

May be related - once in 10 reboots (approx.) I get the K8 Errata #93 missing warning even with the updated BIOS - it's not consistent. 


> On Thu, 18 Nov 2004, Alan Cox wrote:
> 
> > On Iau, 2004-11-18 at 17:02, kernel-stuff@comcast.net wrote:
> > > I tried all the newer kernels including -ac. All have the same 
> > > problem.
> > > 
> > > Andi - On a side note, your change "NVidia ACPI timer override" 
> > > present in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do 
> > > you have a unusual power management setup?") and DMA timeouts - 
> > > happens regularly.
> > 
> > Ok ACPI timer override probably goes back into the broken bucket and out
> > of -ac in -ac11 then.
> 
> I think it's more a broken system, booting with noapic (as is what 
> happened before) should get things back to normal. Parry, have you updated 
> the BIOS on your laptop?
> 
> Thanks,
> 	Zwane
> 
