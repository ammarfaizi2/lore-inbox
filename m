Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTKXEYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 23:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTKXEYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 23:24:54 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:142 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263578AbTKXEYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 23:24:53 -0500
Date: Sun, 23 Nov 2003 23:19:13 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Rob Landley <rob@landley.net>
Cc: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
Subject: Re: The plug and play menu is ISA only?
Message-ID: <20031123231913.GH30835@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Rob Landley <rob@landley.net>, M?ns Rullg?rd <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <200311212041.22604.rob@landley.net> <yw1xhe0xcba0.fsf@kth.se> <200311230104.02083.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311230104.02083.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 01:04:01AM -0600, Rob Landley wrote:
> On Friday 21 November 2003 21:49, M?ns Rullg?rd wrote:
> > Rob Landley <rob@landley.net> writes:
> > > Is the "plug and play" menu just ISA plug and play only?  (It has nothing
> > > to do with hotplug or anything else, right?  PCI devices are "plug and
> > > play", but that's an actual part of the PCI spec.  USB is hotplug and
> > > play, etc.)

It also contains PnP BIOS support.  Basically it has protocols for legacy
isapnp cards and some onboard devices such as opl3sa2 and serial ports.

> > >
> > > Or is this also used for on-motherboard devices in modern systems?  (Is
> > > it ever likely to be needed on a laptop made in the last five years, for
> > > eample?)
> >
> > The only time you ever need to select ISA plug and play, is if you
> > have an old PnP ISA card.  You'd know if you did.  Modern systems
> > don't even have ISA slots.
>
> Shouldn't it be removed the "devices" menu and stuck under bus options->isa
> then?  (Yeah, not a critical fix.  But is this sort of thing a 2.6.1
> candidate or a 2.7 candidate?)
>
> Rob

Yes, I'm planning on doing so in 2.7, along with some additional restructuring.
Perhaps the entire "plug and play" menu could be moved in 2.6.1 to bus options.

Thanks,
Adam
