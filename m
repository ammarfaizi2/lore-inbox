Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTHORGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269461AbTHORGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:06:01 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:26325 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S267724AbTHORFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:05:49 -0400
Date: Fri, 15 Aug 2003 21:06:01 +0200
From: Clock <clock@twibright.com>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Message-ID: <20030815210601.A5452@beton.cybernet.src>
References: <df962fdf9006.df9006df962f@us.army.mil> <20030815171521.A683@beton.cybernet.src> <200308151738.08965.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308151738.08965.alistair@devzero.co.uk>; from alistair@devzero.co.uk on Fri, Aug 15, 2003 at 05:38:08PM +0100
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:38:08PM +0100, Alistair J Strachan wrote:
> On Friday 15 August 2003 16:15, Clock wrote:
> > On Fri, Aug 15, 2003 at 09:12:17PM +0900, kenton.groombridge@us.army.mil 
> wrote:
> > > Hi,
> > >
> > > I found your post looking for a solution to my lockups.  I bet if you do
> > > a dmesg, you will find that your nforce2 chipset revision is 162.
> >
> > Yeah! Look:
> >
> > NFORCE2: chipset revision 162
> 
> [alistair] 05:37 PM [~] dmesg | grep "NFORCE2: chipset"
> NFORCE2: chipset revision 162
> 
> A quick google for "NFORCE2: chipset revision" reveals no chipset revision 
> dmesg except 162. It seems likely most manufactures are using the same 
> revision.
> 
> I use APIC and ACPI on my EPoX 8RDA+, and I've never had any IO problems. So 
> it seems unlikely that it is tied to a chipset revision.

I have had three boards with nforce2 replaced (all of them Soltek SL75FRN2-L)
and all three did the same. However it seemed the frequency of the crashes
varies with actual piece of board.

The crashes aren't in software - bare 'cat /dev/hda > /dev/null' is
often to lock up the machine to the point that poweroff fails.

Cl<
