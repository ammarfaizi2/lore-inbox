Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313550AbSDLLfM>; Fri, 12 Apr 2002 07:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313551AbSDLLfL>; Fri, 12 Apr 2002 07:35:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51470 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313550AbSDLLfK>;
	Fri, 12 Apr 2002 07:35:10 -0400
Date: Fri, 12 Apr 2002 12:35:09 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using video memory as system memory
Message-ID: <20020412113509.GB16692@gallifrey>
In-Reply-To: <Pine.LNX.4.44.0204091816380.13516-100000@winds.org> <3CB6D965.27604.10B6CD3@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 12:29:40 up 6 days, 16:05,  6 users,  load average: 1.02, 1.08, 1.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pedro M. Rodrigues (pmanuel@myrealbox.com) wrote:
> 
>    How fast can one drive a pci card video memory?

I guess these days you get limited by PCI speed; which for 33MHz/32 bit
is 133MByte/s - on a good day with a wind behind it.  I guess AGP could
do a lot better.

Perhaps a more interesting question is what you can use the video cards
hardware for?  Most video cards can blit to and from main memory - so
how about things like zero clearing pages with little processor
overhead. My gut feeling is that with PCI its probably still faster to
do it on the processor, not sure about AGP though.  Be messy though!

> I once came up with the 
> idea to use the video memory of a pci video card as a block device and use it to 
> put the journal from ext3. Of course it wouldn't be solid state like the cards in the 
> market, at least without a battery and some circuitry changes, and i dismissed 
> the idea as the result of too much caffeine in my blood.

Yes, thats why you need to tie it up to the film camera.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
