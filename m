Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTKZB7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 20:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTKZB7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 20:59:39 -0500
Received: from palrel10.hp.com ([156.153.255.245]:15790 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263885AbTKZB7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 20:59:37 -0500
Date: Tue, 25 Nov 2003 17:59:36 -0800
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031126015936.GB14745@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.58.0311241845200.1599@home.osdl.org> <Pine.LNX.4.44.0311241906500.1986-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311241906500.1986-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 07:08:26PM -0800, Davide Libenzi wrote:
> On Mon, 24 Nov 2003, Linus Torvalds wrote:
> 
> > 
> > On Mon, 24 Nov 2003, Jean Tourrilhes wrote:
> > >
> > > 	Currently, I managed to narrow down to :
> > > -------------------------------------------------
> > > PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
> > 
> > Can you do a "dump_pirq"? (Found on http://www.kernelnewbies.org/scripts/
> > among other places, maybe there are newer versions, David would know).
> 
> I didn't want to post this because I was ashamed of the fix, but w/out 
> this my orinoco cardbus gets an interrupt one every ten boots. This is 
> against 2.4.20 ...
> 
> 
> 
> - Davide

	I believe your issue is unrelated to mine. You seem to have a
problem with interrupt sharing. You may want to try the Pcmcia mailing
list or talk to David.
	Note that the usual Orinoco is 16 bits, so not CardBus ;-)

	Good luck !

	Jean
