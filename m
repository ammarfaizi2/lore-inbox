Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270194AbRHMNS0>; Mon, 13 Aug 2001 09:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270198AbRHMNSQ>; Mon, 13 Aug 2001 09:18:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270194AbRHMNSJ>; Mon, 13 Aug 2001 09:18:09 -0400
Subject: Re: IDE UDMA/ATA Suckage, or something else?
To: pgallen@randomlogic.com (Paul G. Allen)
Date: Mon, 13 Aug 2001 14:20:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel developer's mailing list),
        kplug-list@kernel-panic.org (kplug-list@kernel-panic.org)
In-Reply-To: <no.id> from "Paul G. Allen" at Aug 12, 2001 05:30:30 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WHdy-0007P0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently, I am running a 2.4.7-ac10 SMP debug kernel on my K7 Thunder
> and I was hoping things would be better, and if not then at least I
> could see something in the logs if it did crash/lock. I also compiled
> NVidia driver with debugging enabled. Things are no better as the system
> still locks up frequently while playing Quake 3, and I can't even start
> Unreal Tournament without it locking and requiring a reset (SysRq,
> logging in remotely, etc. does not work). The logs tell me nothing.

Once you've touched the 3D stuff I dont actually care about bug reports that
boot even after 3d unloaded. I'm simply sick of fielding Nvidia's bug
reports.

> What I have found is that if I disable DMA on my IBM ATA100 drive, the
> system is quite stable (though it is slow as snot - running at a
> ridiculous 4.5MB/sec. as compared to 35MB/sec. with UDMA33/66 enabled).

You must disable IDE prefetch on the current versions of the AMD MP 
chipset, you may also need to enable "noapic". 
