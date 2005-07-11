Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVGKUWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVGKUWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVGKUSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:18:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:17088 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262559AbVGKUQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:16:33 -0400
Date: Mon, 11 Jul 2005 16:16:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507112202.16876@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507111611470.6399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Michel Bouissou wrote:

> Le Lundi 11 Juillet 2005 21:43, Alan Stern a écrit :
> > >
> > > Enable USB mouse support: YES	(Well, I have one ;-)
> >
> > That's what I was talking about.  BIOS support for keyboard and mouse is
> > called "Legacy" support, because it emulates plain old non-USB AT-type
> > devices.  I bet if you turned off the "Enable USB mouse support" option
> > then everything would work.
> 
> Aha. And what would be your advice ? Rather leave the BIOS mouse option ON and 
> use "usb-handoff", or remove both ?

Well, some people don't have a choice.  They need to leave BIOS USB 
keyboard/mouse support turned on in order to use their USB keyboard/mouse 
before the Linux kernel has loaded (within Grub, for instance).

If you don't care about that, then it's cleaner to turn off the BIOS 
support.  Of course, you may find that you still need to use 
"usb-handoff" anyway!

In the end it doesn't make much difference.  Do whatever works best for 
you.

Alan Stern

