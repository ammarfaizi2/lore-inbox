Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbUKSQDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbUKSQDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUKSP7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:59:03 -0500
Received: from fsmlabs.com ([168.103.115.128]:64958 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261446AbUKSP5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:57:49 -0500
Date: Fri, 19 Nov 2004 08:57:24 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: kernel-stuff <kernel-stuff@comcast.net>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, acurrid@nvidia.com
Subject: Re: X86_64: Many Lost ticks
In-Reply-To: <200411182056.03184.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.61.0411190856121.7201@musoma.fsmlabs.com>
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
 <20041118184904.GN17532@wotan.suse.de> <200411182056.03184.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, kernel-stuff wrote:

> Ignore my earlier mail about the DMA timeouts and NMI errors after applying 
> the ACPI timer override patch.  My bad.  I forgot to recompile the modules 
> after I applied your patch - and I believe thats what caused those errors. 
> I recompiled and reinstalled the modules this time and no errors [well, apart 
> from those lost ticks, which anyway is a separate issue]  with the ACPI Timer 
> override for NVIDIA chipset. 
> 
> Alan - Needless to say you should keep Andi's NVIDIA ACPI Timer override patch 
> in -ac. It works.
> 
> Sorry for the confusion!

Thanks for confirming that Parry, so your system definitely is using the 
IOAPIC now (/proc/interrupts output should suffice)?

	Zwane
