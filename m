Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270823AbTGVVYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270824AbTGVVYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:24:23 -0400
Received: from codepoet.org ([166.70.99.138]:1674 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270823AbTGVVYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:24:21 -0400
Date: Tue, 22 Jul 2003 15:39:26 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030722213926.GA4295@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org> <20030722205629.GA27179@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722205629.GA27179@gtf.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jul 22, 2003 at 04:56:29PM -0400, Jeff Garzik wrote:
> > I was reading over your libata driver yesterday.  Certainly a lot
> > cleaner than the cam stuff IMHO.  Given the info made available
> > via the Promise driver, I expect that I could get an initial
> > libata host adaptor driver hacked together in short order.  After
> > all, the Intel one is just 400 lines.  So unless you (or anyone
> > else) have already started or would prefer to do the honors,
> > I'll try to hack something together this evening,
> 
> Shoot, that would be great ;-)

K, I'll give it a try.

> On a legal note, I would prefer that completely new drivers (i.e. no
> copied code from other sources) be licensing in the same way as
> libata.c.  Maintainer's preference in the end, of course, but I would
> like to strongly encourage following libata.c's example ;-)

By that I assume you mean osl-1.1 like libata.c, rather than GPL
like ata_piix.c....  I expect I may be copying bits and pieces
from the Promise driver though.  Certainly I'd like to use as
much of their header files as seems practical.  So it may very
well need to stay GPL'd.  But I'll see what I can do.

> I have a TX2 board, too, so I can test your stuff as well.

Cool.  I have a TX2 as well.  Hope I don't fry it... :)

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
