Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUGVMvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUGVMvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 08:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUGVMvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 08:51:41 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:39414 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S264595AbUGVMtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 08:49:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: fedora-list@redhat.com
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
Date: Thu, 22 Jul 2004 08:49:10 -0400
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org> <40FF4A15.7040100@charter.net> <200407220652.39575.gene.heskett@verizon.net>
In-Reply-To: <200407220652.39575.gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407220849.10594.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.11.138] at Thu, 22 Jul 2004 07:49:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 July 2004 06:52, Gene Heskett wrote:
[...]
>>Let me know, I'm still Curious.
>>
>>Joebewan

[...]

Update, X-Posted to lkml too, I followed the US link from the
TW site, and it had different versions of these files. I stuck
the 2 newest ones from the US site on a floppy and it all worked.

Now I have from "lspci -vvv|grep -A10 Ethernet" which I think is
the same as the previous listing:

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
        Subsystem: Biostar Microtech Int'l Corp: Unknown device 2301
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dc005000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at c400 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

However, this, nor the xconfig helps, still don't indicate which
driver I should be using, or where to get it if its not in the
kernel's tree yet a/o 2.6.8-rc2.  So thats the next piece of data I need.

And I haven't attempted to dismantle it to see the MAC address yet.
At nearly 70, sitting tailor fashion on the floor for extended periods
isn't nearly as comfortable as it once was :-)  Which is what that
dismantle will require, the tower its in is trapped under a homemade
desk by some steel bracing I put in when I made it 15 years ago...
But, one could probably rebuild a nearly half ton mopar 392 hemi-head
on it too :-)

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
