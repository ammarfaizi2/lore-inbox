Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270401AbRHMS6P>; Mon, 13 Aug 2001 14:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270432AbRHMS6F>; Mon, 13 Aug 2001 14:58:05 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:48256 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S270408AbRHMS5q>; Mon, 13 Aug 2001 14:57:46 -0400
Message-ID: <3B7821F4.5C4B4A67@randomlogic.com>
Date: Mon, 13 Aug 2001 11:52:36 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
Subject: Re: IDE UDMA/ATA Suckage, or something else?
In-Reply-To: <E15WHdy-0007P0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Currently, I am running a 2.4.7-ac10 SMP debug kernel on my K7 Thunder
> > and I was hoping things would be better, and if not then at least I
> > could see something in the logs if it did crash/lock. I also compiled
> > NVidia driver with debugging enabled. Things are no better as the system
> > still locks up frequently while playing Quake 3, and I can't even start
> > Unreal Tournament without it locking and requiring a reset (SysRq,
> > logging in remotely, etc. does not work). The logs tell me nothing.
> 
> Once you've touched the 3D stuff I dont actually care about bug reports that
> boot even after 3d unloaded. I'm simply sick of fielding Nvidia's bug
> reports.
> 
> > What I have found is that if I disable DMA on my IBM ATA100 drive, the
> > system is quite stable (though it is slow as snot - running at a
> > ridiculous 4.5MB/sec. as compared to 35MB/sec. with UDMA33/66 enabled).
> 
> You must disable IDE prefetch on the current versions of the AMD MP
> chipset, you may also need to enable "noapic".

Unless I can do it with the kernel, I have no choice. The BIOS has no
prefetch setting (which, BTW, I had disabled on all my A7V133 boards).
So what about problems with non MP boards?

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
