Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUKRU34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUKRU34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUKRTm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:42:29 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:63918 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261152AbUKRTaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:30:12 -0500
From: kernel-stuff@comcast.net
To: Andi Kleen <ak@suse.de>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, acurrid@nvidia.com
Subject: Re: X86_64: Many Lost ticks
Date: Thu, 18 Nov 2004 19:30:08 +0000
Message-Id: <111820041930.14059.419CF840000D9C0D000036EB220076370400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 11 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi, Zwane

I will send in the following by evening -

1) dmidecode output
2) normal dmesg output (No Timer override, with ACPI with thermal stuff) - This gives me many lost ticks 
3) dmesg output with NV Timer override with apic - This gives me NMI errors and IDE DMA timeouts 
4) dmesg output with NV Timer override with noapic - Not tried yet
5) lspci output

Let me know if anything else is needed.

Thanks!

Parry


> On Thu, Nov 18, 2004 at 05:02:37PM +0000, kernel-stuff@comcast.net wrote:
> > I tried all the newer kernels including -ac. All have the same problem.
> > 
> > Andi -  On a side note, your change  "NVidia ACPI timer override" present in 
> 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a unusual 
> power management setup?") and DMA timeouts - happens regularly.
> 
> Hmm, I was told Timer overrides are always bogus on Nvidia and 
> that it was the last remaining known apic bug.
> But perhaps there are other APIC bugs in there.
> 
> Can you submit a full boot.msg of the problem? 
> 
> -Andi
