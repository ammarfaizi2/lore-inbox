Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131260AbRCNC1R>; Tue, 13 Mar 2001 21:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRCNC1I>; Tue, 13 Mar 2001 21:27:08 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:44164 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S131260AbRCNC06>;
	Tue, 13 Mar 2001 21:26:58 -0500
Date: Wed, 14 Mar 2001 03:25:25 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: avi-nospam@sputnik7.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't get driver to work: D-Link DFE-570TX (de4x5.o) on Linux
 2.4
In-Reply-To: <3AAED2F5.AA5E0701@sputnik7.com>
Message-ID: <Pine.LNX.4.21.0103140320560.8986-100000@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, Avi Green wrote:

> 
> Dear folks,
> 
> I apologize for bothering you, but if by any chance this is an easy
> question for you to answer (wishful thinking, huh?) I'd be very grateful
> if you would.*
> 
> I have some new Hawk PCs (Pentium-III) with D-Link DFE-570TX Fast
> Ethernet 4-port server adapters.  When I build the machines using Red
> Hat's standard 6.2 installer, it automatically finds the de4x5.o driver
> module, inserts it into the kernel (which is 2.2), and sets up four
> Ethernet interfaces using that driver.
> 
> Unfortunately, when I build the 2.4 kernel (which I must do because I
> need Netfilter), I can't get the card to work.
> 
> * I've tried inserting the old de4x5.o module that came with 2.2, but
> there are unmatched symbols.
> 
> * I've tried inserting the new de4x5.o module that came with 2.4 in
> drivers/net, but it either complains of no such device, I/O error, or
> "couldn't find the kernel version the module was compiled for".
> 
> * I've tried configuring the kernel with the 3c590/3c900, {DEPCA, DE10x,
> DE200, DE201, DE202, DE422}, Tulip (dc21x4x), Generic DECchip, and VIA
> Rhine chips, but it doesn't seem to help, whether they're included as
> modules or compiled into the kernel.  I've downloaded the latest Tulip
> driver but haven't tried it yet.
> 
> * I've spent many hours trying to get this to work, and my manager is
> getting desparate.
> 
> Do you have any ideas?

I'm using 2.4 with DFE-570TX cards in a bunch of routers and other
machines and I've never had any problems with the cards. I use the tulip
driver in 2.4 in some machines (not routers) and in the routers I use an
optimized version 
(ftp://robur.slu.se/pub/Linux/net-development/tulip-ss010111.tar.gz is the
latest stable version)

I havn't had the problem you describe. Everything works fine here.

/Martin

