Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTK2BXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 20:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTK2BXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 20:23:31 -0500
Received: from glockenspiel.complete.org ([69.10.152.57]:49611 "EHLO
	glockenspiel.complete.org") by vger.kernel.org with ESMTP
	id S263593AbTK2BX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 20:23:29 -0500
Date: Fri, 28 Nov 2003 19:23:19 -0600
From: John Goerzen <jgoerzen@complete.org>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise IDE controller crashes 2.4.22
Message-ID: <20031129012319.GD2069@complete.org>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <3FC7A3D9.3070500@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC7A3D9.3070500@sbcglobal.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 01:36:57PM -0600, Wes Janzen wrote:
> I'd suspect some sort of PCI problem, especially since you're running a 

Do you happen to have a URL where I can read up on PCI problems with
K6s?  Are the problems unique to Linux?  Note that it's a K6-3, so it's
not really first generation PCI.

> K6.  What chipset is your motherboard based on?

I haven't looked at the motherboard in quite awhile...  it's got a lot
of VIA hardware: the PCI bridge is a VT82C598/694x (Apollo MVP3/Pro133x
AGP).  I also see VT82C596 and VT82C586 in the lspci output.  The box
was used as a server for a couple of years with no obvious hardware
problems.

The motherboard was, if memory serves, manufactured by Epox.  But it's
been ages since I've looked at that, so my memory may be failing.  If it
would help with the diagnosis, though, I could go open it up and find
out.

> have a 92048D8 that doesn't like UDMA-2 writes, but that won't hang the 

Can you translate UDMA-2 into something like UDMA/133?  I'm having
trouble mapping the two in my head (I'm not terribly familiar with IDE
internals)

> Anyway, since the kernel seems to handle a DMA write gone bad, that 
> leads me to believe that this issue is caused by the increased data 
> flowing over the PCI bus when using DMA vs using PIO.  I'm not an expert 
> though, maybe someone else has an opinion on this?

The other thing is that the drives hooked to the on-board IDE channels
work fine.  I don't know if that is important; but I figured I'd mention
it.

> You might try putting the card in another slot too.  My cards are 

Hmm, I could give that a try.

Thanks,
John


