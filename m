Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132866AbRDPGrG>; Mon, 16 Apr 2001 02:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132867AbRDPGq4>; Mon, 16 Apr 2001 02:46:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3422 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132866AbRDPGqk>; Mon, 16 Apr 2001 02:46:40 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: db@zigo.dhs.org (Dennis Bjorklund), linux-kernel@vger.kernel.org
Subject: Re: Data-corruption bug in VIA chipsets
In-Reply-To: <E14o3HM-0002pm-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Apr 2001 00:45:12 -0600
In-Reply-To: Alan Cox's message of "Fri, 13 Apr 2001 14:06:22 +0100 (BST)"
Message-ID: <m1ae5htkav.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Here might be one of the resons for the trouble with VIA chipsets:
> > 
> > http://www.theregister.co.uk/content/3/18267.html
> > 
> > Some DMA error corrupting data, sounds like a really nasty bug. The
> > information is minimal on that page.
> 
> What annoys me is that we've known about the problem for _ages_. If you look
> the 2.4 kernel has experimental workarounds for this problem. VIA never once
> even returned an email to say 'we are looking into this'. Instead people sat
> there flashing multiple BIOS images and seeing what made the difference.
> 
> > I just bought one of these babies and I should probably return it
> > directly. I have seven days to return it and get my money back. I have not
> > even opened the box yet.
> 
> Disabling pci master read caching is likely to reduce the performance of the 
> board.
> 
> > They seems to think they can correct it by some bios updates, but who
> > knows what that fix might be. Maybe they turn of DMA alltogether
> > (hopefully not).
> 
> The -ac kernel does this on the KT7 series boards which seemed the worst
> affected. 
> 
> Hopefully now someone in VIA will have the decency to tell the community 
> how to detect setups that need a BIOS upgrade so we can warn them before the
> chipset bug turns there file systems into sludge.

I wonder if someone at VIA even knows what is going on.  In working
with linuxBIOS Ron Minnich was worked with VIA to get it up on some of
their chipsets. He ran into a few cases where his code wouldn't work,
he'd show it to the engineers at VIA and they also wouldn't have a
clue why his code was failing.  And that it looked like only Award
knew how the chipset really worked.  This is northbridge code not
southbridge code so it may be an entirely different ball game but...

Anyway Alan you might want to bounce off Ron.  He might have a clue
how to help you get get VIA's attention...

Eric
