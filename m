Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTDDWSc (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbTDDWSc (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:18:32 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:32179 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261369AbTDDWSa (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 17:18:30 -0500
Date: Sat, 5 Apr 2003 00:29:39 +0200 (MEST)
Message-Id: <200304042229.h34MTdTp008601@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: rddunlap@osdl.org
Subject: Re: [Bug 538] New: Rebooting of pentium-I during initial booting phase.
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, robins.t@kutumb.org.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003 13:25:47 +0000, Randy.Dunlap wrote:
>On Fri, 4 Apr 2003 22:52:35 +0200 (MEST) mikpe@csd.uu.se wrote:
>
>| On Thu, 3 Apr 2003 09:55:34 -0800, mbligh@aracnet.com wrote:
>| >http://bugme.osdl.org/show_bug.cgi?id=538
>| >
>| >           Summary: Rebooting of pentium-I during initial booting phase.
>| >    Kernel Version: 2.5.65 (probably most versions of 2.5.x)
>| >            Status: NEW
>| >          Severity: normal
>| >             Owner: mbligh@aracnet.com
>| >         Submitter: robins.t@kutumb.org.in
>| >
>| >
>| >Distribution: linus kernel 2.5.65 (probably 2.5.x)
>| >
>| >Hardware Environment: 
>| >Pentium - I (120 MHz) with FO-OF Bug
>| >Motherboard Via - With DMA Problem ("nodma" option required in 2.4.x kernels)
>| >16mb RAM (EDO)
>| >
>| >Software Environment:
>| >Linus kernel 2.5.65
>| >
>| >Problem Description:
>| >The new kernel 2.5.65 reboots while booting process (in the very initial phase) making even noting the progress very difficult.
>| >The system is running fine with 2.4.21-pre5, with the option "nodma".
>| 
>| Most probably a configuration error, viz. choosing a CPU type
>| higher than generic 586. My Socket7 ASUS T2P4 with a Pentium
>| Classic (pre-MMX) 133MHz boots 2.5.66 just fine.
>
>Yes, I agree with that suggestion, but I don't see a problem.
>Did you look at his .config file?  It's here:
>  http://bugme.osdl.org/attachment.cgi?id=261&action=view
>
>I'm comparing it to the .config on my Pentium-with-f00f-bug, which does
>boot 2.5.65 successfully, and I don't see CPU option differences.
>I see lots that don't matter and I see PIIX vs. VIA option differences.

I've re-tested with the exakt same .config and gcc (RH8 stock)
that Robins used, and I still can't reproduce the problem.
According to his 2.4.21-pre5 dmesg output, his CPU is even the
same stepping as mine (CPUID 52C).

/Mikael
