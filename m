Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTBFSDY>; Thu, 6 Feb 2003 13:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTBFSDY>; Thu, 6 Feb 2003 13:03:24 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:16775 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267473AbTBFSDX>;
	Thu, 6 Feb 2003 13:03:23 -0500
Date: Thu, 6 Feb 2003 19:12:41 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: AU <au@surfer.sbm.temple.edu>
cc: Hans-Peter Jansen <hp@lisa-gmbh.de>, Shawn Evans <shawnwe@hotmail.com>,
       linux-raid@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Promise FastTrak TX4 losing interrupts (with apic mode)
In-Reply-To: <Pine.SGI.4.32.0302060924010.93623-100000@surfer.sbm.temple.edu>
Message-ID: <Pine.LNX.4.53.0302061907550.17629@ddx.a2000.nu>
References: <Pine.SGI.4.32.0302060924010.93623-100000@surfer.sbm.temple.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, AU wrote:

> Try to boot with apic=no or acpi=oldboot
like i do now with append noapic, it works ok

did some more tests today :
plugged the fasttrak tx4 into 3 different machines
all smp (dual p3/dual p2/dual xeon)
with all i get lost interrupts

if i boot with noapic problem is solved

(tried updating the bios for the promise, but doesn't help)

looks like there is really something wrong with the (bios?) tx4

i have 3 of these cards here
putting 2 together in an mainbord also doesn't work (then the tx4 bios is
complaining about no assigned irq)

and if i use 1 card in a system, i always have to press 'esc' to continu
after the bios tells me there is no array

i really think i should have bought the highpoint 4 port cards :(
