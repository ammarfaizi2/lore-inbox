Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAPQBi>; Tue, 16 Jan 2001 11:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129977AbRAPQB2>; Tue, 16 Jan 2001 11:01:28 -0500
Received: from [207.176.248.246] ([207.176.248.246]:2056 "EHLO
	mail.searchaid.com") by vger.kernel.org with ESMTP
	id <S129632AbRAPQBP>; Tue, 16 Jan 2001 11:01:15 -0500
Message-ID: <3A646FE3.665878F3@sangoma.com>
Date: Tue, 16 Jan 2001 10:59:31 -0500
From: Nenad Corbic <ncorbic@sangoma.com>
Organization: Sangoma Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael D. Crawford" <crawford@goingware.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Doc bug?  Is Sangoma S514 PCI WAN card supported?
In-Reply-To: <3A63C013.38EF1542@goingware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Michael D. Crawford" wrote:

> Under 2.4.0-ac4 I find lots of mentions of the Sangoma S514 PCI Multiprotocol
> Wide Area Networking card in
>
> drivers/net/wan/sdla*
>
> But in Documentation/Configure.help under CONFIG_VENDOR_SANGOMA I only see
> mention of the S502E(A), S503 and S508.  These same cards are listed in
> documentation/networking/framerelay.txt but not S514.
>

Documentation in "Documentation/Configure.help" is out dated.  The latest driver
patches and documentation has been submitted into the kernel to Alan Cox and
Stephen Tweedie.

The documentation in framerelay.txt, is really outdated, and is not supported by
Sangoma any more.  These were the first drivers Sangoma released into the kernel.


>
> I can't find the 502 or 503 cards on http://www.sangoma.com so maybe they're
> obsolete and while the 508 looks like a pretty good card, it's an ISA card and
>  I'd much rather use the 514 which is PCI.  The PCI card is $579 and the ISA card
>
> is $529 so you don't have to pay much extra to get a card that's going to be
> better for your box's well-being.
>
> I'm moving to the first house I've ever owned in my life (so I'll get to drill
> holes in the walls) and the only affordable high-speed internet option there
> which allows the subscriber to run their own servers and have multiple static IP
> addresses is frame relay.
>
> (You can also do synchronous PPP, HDLC and X.25 with these cards).
>
> An advantage of using a WAN card over a dedicated router is:
>
> - it's cheaper
>
> - you get the source code
>
> - you can combine the function of the router with other things like webservers
> and firewalls (I was going to run a separate FRAD and firewall - $$$)  You can
> probably get dedicated routers with firewalls built in but you don't then have
> the option of source code or, likely, timely notification from your vendors
> about security holes.
>
> - the WAN router is running on a box with lots of memory, hard disk, XWindows,
> etc.  Routers often run some kind of Unix as their OS but have very limited
> resources for loading them up with fun diagnostic tools.
>
> - you get to learn lots of interesting acronyms and enthrall your friends and
> relatives with your knowledge of wide area networking protocols
>
> - cool diagnostics by indicating link status, send and receive by lighting up
> your keyboard LED's.
>
> These folks at Sangoma seem like they're some pretty cool froods to be providing
> specs and drivers for their cards which they appear to have kept supported over
> an extended period of time so we should support their efforts by letting Linux
> users know all the options for the hardware that helpful vendors such as these
> sell.
>
> My first thought, quite unfairly, was that Sangoma was only releasing the specs
> for the older ISA cards and keeping the PCI specs a secret.

>
> The following two passages from the WANPIPE user manual
> (ftp://ftp.sangoma.com/documents/wanpipe.pdf) have me pretty convinced this is a
> vendor worth looking into:
>
> > Make sure your "other end" is set up correctly.  Many third party routers
> > default to proprietary, non standard protocols, while WANPIPE adheres strictly
> > to Internet or IETF standards of encapsulation.
>
> well that's pretty reasonable and what I'd expect but check this out:
>
> > You will find these utilities will turn you into a WAN guru.
> > You will always know more about the WAN connection than either the
> > network provider or the third party at the other end.
>
> Reminds me of the days when I used to call up Sun support and talk their
> technicians through the process of giving me tech support.  Not to mention
> dealing with a typical ISP's tech support ("ifconfig? which version of Windows
> are you running, anyway?")
>
> Lotsa good linux WAN stuff at ftp://ftp.sangoma.com/linux
>
> Clueless about frame relay?  I was before this evening spent a-googling.  These
> two pages are helpful places to start:
>
> The Frame Relay Forum
> http://www.frforum.com
>
> They have an intro book you can read online as HTML or download as PDF.
>
> IBM Frame Relay Guide
> http://www.raleigh.ibm.com/cgi-bin/bookmgr/BOOKS/EZ305800/CCONTENTS
>
> Pretty dry but quite informative.
>
> the abovementioned wanpipe.pdf file has some pretty helpful introductory info it
> too.  There's also a document called WanpipeForLinux.pdf which is helpful.  It's
> available actually in both PDF and text format at
>
> ftp://ftp.sangoma.com/linux/current_wanpipe/doc/
>
> Now I just hope there's enough physical wires running into my house to _get_
> frame relay.  May have to send the telephone man on top of a pole to drop me a
> line.  How many wires into your building are required for frame relay to work?
> Can't seem to find _that_ anywhere, and this house isn't exactly in a place
> where the telco would have thought to plan for lots of extra capacity.
>
> Mike
> --
> Michael D. Crawford
> GoingWare Inc. - Expert Software Development and Consulting
> http://www.goingware.com/
> crawford@goingware.com
>
>    Tilting at Windmills for a Better Tomorrow.

Nenad Corbic
Senior Linux Developer
Sangoma.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
