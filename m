Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUKRTUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUKRTUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbUKRTS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:18:56 -0500
Received: from mail.suse.de ([195.135.220.2]:43678 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262929AbUKRTSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:18:18 -0500
Date: Thu, 18 Nov 2004 19:49:04 +0100
From: Andi Kleen <ak@suse.de>
To: kernel-stuff@comcast.net
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, acurrid@nvidia.com
Subject: Re: X86_64: Many Lost ticks
Message-ID: <20041118184904.GN17532@wotan.suse.de>
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 05:02:37PM +0000, kernel-stuff@comcast.net wrote:
> I tried all the newer kernels including -ac. All have the same problem.
> 
> Andi -  On a side note, your change  "NVidia ACPI timer override" present in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a unusual power management setup?") and DMA timeouts - happens regularly.

Hmm, I was told Timer overrides are always bogus on Nvidia and 
that it was the last remaining known apic bug.
But perhaps there are other APIC bugs in there.

Can you submit a full boot.msg of the problem? 

-Andi
