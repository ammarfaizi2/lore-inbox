Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTKYDEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTKYDEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:04:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:21964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261953AbTKYDEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:04:10 -0500
Date: Mon, 24 Nov 2003 19:03:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: jt@hpl.hp.com
cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <20031125025605.GA4059@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0311241901320.1599@home.osdl.org>
References: <20031124235727.GA2467@bougret.hpl.hp.com>
 <Pine.LNX.4.58.0311241759470.1599@home.osdl.org> <Pine.LNX.4.58.0311241819030.1599@home.osdl.org>
 <20031125025605.GA4059@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 24 Nov 2003, Jean Tourrilhes wrote:
>
> 	Don't get me wrong, PCI-CardBus add-on cards seem to always be a
> pain, whereas laptop seems to always have the right magic. I already
> tried unsuccessfully to add a TI PCI-Pcmcia on another box, and this was
> similar, whereas my laptops are always working out of the box.

Hmm.. So this is literally a PCI card you've added?

Try putting it into another slot, if so. It literally looked from your
debug output like it was just that slot that didn't have an irq route for
it.

		Linus
