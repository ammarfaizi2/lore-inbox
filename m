Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTKYDib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTKYDib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:38:31 -0500
Received: from palrel13.hp.com ([156.153.255.238]:64983 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261931AbTKYDia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:38:30 -0500
Date: Mon, 24 Nov 2003 19:38:29 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031125033829.GB4483@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031124235727.GA2467@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241759470.1599@home.osdl.org> <Pine.LNX.4.58.0311241819030.1599@home.osdl.org> <20031125025605.GA4059@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241901320.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311241901320.1599@home.osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 07:03:04PM -0800, Linus Torvalds wrote:
> 
> 
> 
> On Mon, 24 Nov 2003, Jean Tourrilhes wrote:
> >
> > 	Don't get me wrong, PCI-CardBus add-on cards seem to always be a
> > pain, whereas laptop seems to always have the right magic. I already
> > tried unsuccessfully to add a TI PCI-Pcmcia on another box, and this was
> > similar, whereas my laptops are always working out of the box.
> 
> Hmm.. So this is literally a PCI card you've added?

	Yep. I'm replaing my old ISA->Pcmcia with something that can
support the latest wireless Cardbus cards.

> Try putting it into another slot, if so. It literally looked from your
> debug output like it was just that slot that didn't have an irq route for
> it.

	I already did that, because it's in Dave's howto. In the
middle slot (swap with HP100VG Ethernet), it was using pirq 60, which
is the same that is used by aic7xxx. Now, it's back to pirq 61.

> 		Linus

	Jean
