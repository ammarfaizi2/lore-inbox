Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWC0XK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWC0XK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWC0XK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:10:56 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:35291 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750946AbWC0XKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:10:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=icUe8DkcnDrV/uwZZdj2/YDLr/eWNZX88TWbz6NvGJH4umXRrFTHyFrI3Mwqxs+Ly4I8kQN8AlHyF9lc39qPjv1mr9peF5bze7cLuYFDecUtYYGcIjPqd7FKNtbRl2OrHp/JFrLSH1grATepYVB+PuVgvjc+vmrW5gUCuey0obE=
Date: Tue, 28 Mar 2006 01:10:49 +0200
From: Friedrich =?iso-8859-1?Q?G=F6pel?= <shado23@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: hda-intel woes
Message-ID: <20060327231049.GA30641@localhost.in.y0ur.4ss>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This same message was sent to the alsa mailinglist 3 weeks ago,
but it still seems to be waiting on being moderated, so I'm resending
this here.



Hi,

I tried installing linux on my sister's new acer extensa 6700 laptop.
I tried Fedora FC4, FC5 test 3 and now Gentoo with various kernel and
alsa versions (specifically 1.0.10 and 1.0.11-rc3 and whatever is in
fedora before and after a full update).
Also I set up a friends vaio laptop also with an intel hd audio chip,
which is working peachy.
I also tried model=basic/hp/fujitsu just in case.

Just to preempt the question: I did unmute and raise the mixer levels.

Anyways the damn thing is not to be convinced to produce a single
sound.

In light of this I suppose Acer did something nasty to that chip.

I'm attatching here the relevant part of lspci -vv in hopes of somebody
being either able to point out a fix or tell me if it's going to be
supported sometime soon.

I could pose as a genuea pig if neccessary.
Also if there is any further information I should gather just tell me.

Otherwise it's back to windows for my sister I guess.

PS. I'm not subscribed to the list so please CC me.
Thanks.

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
        Subsystem: Acer Incorporated [ALI] Unknown device 008f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)
