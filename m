Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTKYAh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKYAh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:37:59 -0500
Received: from palrel11.hp.com ([156.153.255.246]:53644 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261754AbTKYAhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:37:47 -0500
Date: Mon, 24 Nov 2003 16:37:46 -0800
To: glee@gnupilgrims.org
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031125003746.GA2861@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031124235727.GA2467@bougret.hpl.hp.com> <20031125001609.GA10153@gandalf.chinesecodefoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125001609.GA10153@gandalf.chinesecodefoo.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 08:16:09AM +0800, glee@gnupilgrims.org wrote:
> On Mon, Nov 24, 2003 at 03:57:27PM -0800, Jean Tourrilhes wrote:
> > 	Hi,
> > 
> > 	I have a new Ricoh PCI-Carbus bridge and the kernel
> > 2.6.0-test9 doesn't seem to configure it properly (see below).
> > 	With the old Pcmcia package, the i82365 module had a bunch of
> > module options to change various irq stuff (see Pcmcia Howto 5.2). A
> > quick look in yenta_socket failed to show any module options, which
> > seems odd.
> > 	What is the correct way to workaround this stuff ?
> > 
> 
> 
> I have one of these cards.  In 2.4.x I used pci=biosirq to get around
> it. (BTW, this will oops with a 2.2 kernel, just for the record).
> 
> 	- g.

	That's a trick I didn't know about. I tried it, but it doesn't
work (same problem). That doesn't surprise me because the BIOS doesn't
know about this add-on card.

> geoff.

	Jean
