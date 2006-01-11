Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWAKXt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWAKXt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWAKXt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:49:28 -0500
Received: from hera.kernel.org ([140.211.167.34]:17804 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750721AbWAKXt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:49:27 -0500
Date: Wed, 11 Jan 2006 14:56:24 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "G.W. Haywood" <ged@jubileegroup.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ne2k PCI/ISA documentation: improved cross-reference.
Message-ID: <20060111165624.GB5352@dmt.cnet>
References: <Pine.LNX.4.58.0512291301420.2118@mail3.jubileegroup.co.uk> <9a8748490512290553g448d1e28w65dad834cd08e1a7@mail.gmail.com> <Pine.LNX.4.58.0512291520250.6219@mail3.jubileegroup.co.uk> <200512292149.55237.jesper.juhl@gmail.com> <Pine.LNX.4.58.0601071459440.8957@mail3.jubileegroup.co.uk> <20060109130655.GA4687@dmt.cnet> <20060110124235.GG3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110124235.GG3911@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 01:42:35PM +0100, Adrian Bunk wrote:
> On Mon, Jan 09, 2006 at 11:06:55AM -0200, Marcelo Tosatti wrote:
> > On Sat, Jan 07, 2006 at 03:11:40PM +0000, G.W. Haywood wrote:
> > > From: Ged Haywood <ged@jubileegroup.co.uk>
> > > 
> > > Improved reference to PCI ne2k support in ISA ne2k documentation.
> > > 
> > > Signed-off-by: Ged Haywood <ged@jubileegroup.co.uk>
> > > ---
> > >  Configure.help |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > --- linux-2.4.32/Documentation/Configure.help.original  2006-01-07 14:48:23.000000000 +0000
> > > +++ linux-2.4.32/Documentation/Configure.help   2006-01-07 14:56:32.000000000 +0000
> > > @@ -12778,7 +12778,8 @@
> > >    without a specific driver are compatible with NE2000.
> > > 
> > >    If you have a PCI NE2000 card however, say N here and Y to "PCI
> > > -  NE2000 support", above. If you have a NE2000 card and are running on
> > > +  NE2000 and clones support" under "EISA, VLB, PCI and on board
> > > +  controllers" below.  If you have a NE2000 card and are running on
> > >    an MCA system (a bus system used on some IBM PS/2 computers and
> > >    laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
> > >    below.
> > 
> > Hi Ged,
> > 
> > Appreciate your efforts but the v2.4 tree is under deep maintenance mode
> > with an acceptance criteria for critical bugfixes only.
> 
> Wouldn't it make sense to make an exception from this rule for 
> documentation updates?
> 
> Documentation updates can't do much harm.

Hi Adrian,

That would open precedence on "exceptions" - one could argue that
different classes of updates can't do much harm either.

The maintenance process should concentrate on problems which can affect
installations running legacy v2.4.

Another point in favour of restricting updates on the v2.4 tree are
external patches. There are a bunch of them being cultivated by the
community. For them, the less changes in mainline, the better.
