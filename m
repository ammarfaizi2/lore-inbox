Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbUKRS0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUKRS0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbUKRS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:26:37 -0500
Received: from fsmlabs.com ([168.103.115.128]:64228 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262841AbUKRSYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:24:55 -0500
Date: Thu, 18 Nov 2004 11:24:38 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: kernel-stuff@comcast.net, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: X86_64: Many Lost ticks
In-Reply-To: <1100797816.6019.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0411181122480.4034@musoma.fsmlabs.com>
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
 <1100797816.6019.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Alan Cox wrote:

> On Iau, 2004-11-18 at 17:02, kernel-stuff@comcast.net wrote:
> > I tried all the newer kernels including -ac. All have the same 
> > problem.
> > 
> > Andi - On a side note, your change "NVidia ACPI timer override" 
> > present in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do 
> > you have a unusual power management setup?") and DMA timeouts - 
> > happens regularly.
> 
> Ok ACPI timer override probably goes back into the broken bucket and out
> of -ac in -ac11 then.

I think it's more a broken system, booting with noapic (as is what 
happened before) should get things back to normal. Parry, have you updated 
the BIOS on your laptop?

Thanks,
	Zwane

