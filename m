Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTH0DB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 23:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTH0DB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 23:01:57 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:61488 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id S263050AbTH0DBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 23:01:55 -0400
Message-ID: <3F4C1F09.846A83EF@vtc.edu.hk>
Date: Wed, 27 Aug 2003 11:01:29 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-20.9dbgpentax i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
References: <20030722184532.GA2321@codepoet.org>
	 <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org>
	 <20030722205629.GA27179@gtf.org> <20030722213926.GA4295@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Junkmail-Whitelist: YES (by domain whitelist at pandora.vtc.edu.hk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Erik and Jeff,

Did you make any progress here or were you discouraged by the resulting
flamewar?

Does this work in 2.4.x?  I have a Tyan Trinity i875P S5101 which I want to
use the parallel IDE ports on.  They are connected to a PDC20378.  Any
patches that you think would be reliable?  Or should I take the opportunity
to return this to the vendor and buy an Intel S845WD1-E instead?

Erik Andersen wrote:

> On Tue Jul 22, 2003 at 04:56:29PM -0400, Jeff Garzik wrote:
> > > I was reading over your libata driver yesterday.  Certainly a lot
> > > cleaner than the cam stuff IMHO.  Given the info made available
> > > via the Promise driver, I expect that I could get an initial
> > > libata host adaptor driver hacked together in short order.  After
> > > all, the Intel one is just 400 lines.  So unless you (or anyone
> > > else) have already started or would prefer to do the honors,
> > > I'll try to hack something together this evening,
> >
> > Shoot, that would be great ;-)
>
> K, I'll give it a try.
>
> > On a legal note, I would prefer that completely new drivers (i.e. no
> > copied code from other sources) be licensing in the same way as
> > libata.c.  Maintainer's preference in the end, of course, but I would
> > like to strongly encourage following libata.c's example ;-)
>
> By that I assume you mean osl-1.1 like libata.c, rather than GPL
> like ata_piix.c....  I expect I may be copying bits and pieces
> from the Promise driver though.  Certainly I'd like to use as
> much of their header files as seems practical.  So it may very
> well need to stay GPL'd.  But I'll see what I can do.
>
> > I have a TX2 board, too, so I can test your stuff as well.
>
> Cool.  I have a TX2 as well.  Hope I don't fry it... :)

--
Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



