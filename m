Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRDMNFS>; Fri, 13 Apr 2001 09:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbRDMNFJ>; Fri, 13 Apr 2001 09:05:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62475 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130768AbRDMNEt>; Fri, 13 Apr 2001 09:04:49 -0400
Subject: Re: Data-corruption bug in VIA chipsets
To: db@zigo.dhs.org (Dennis Bjorklund)
Date: Fri, 13 Apr 2001 14:06:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0104130953160.20273-100000@merlin.zigo.dhs.org> from "Dennis Bjorklund" at Apr 13, 2001 10:00:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o3HM-0002pm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here might be one of the resons for the trouble with VIA chipsets:
> 
> http://www.theregister.co.uk/content/3/18267.html
> 
> Some DMA error corrupting data, sounds like a really nasty bug. The
> information is minimal on that page.

What annoys me is that we've known about the problem for _ages_. If you look
the 2.4 kernel has experimental workarounds for this problem. VIA never once
even returned an email to say 'we are looking into this'. Instead people sat
there flashing multiple BIOS images and seeing what made the difference.

> I just bought one of these babies and I should probably return it
> directly. I have seven days to return it and get my money back. I have not
> even opened the box yet.

Disabling pci master read caching is likely to reduce the performance of the 
board.

> They seems to think they can correct it by some bios updates, but who
> knows what that fix might be. Maybe they turn of DMA alltogether
> (hopefully not).

The -ac kernel does this on the KT7 series boards which seemed the worst
affected. 

Hopefully now someone in VIA will have the decency to tell the community 
how to detect setups that need a BIOS upgrade so we can warn them before the
chipset bug turns there file systems into sludge.

Alan

