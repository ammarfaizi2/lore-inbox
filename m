Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbTGVUl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbTGVUl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:41:26 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:15529
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S269106AbTGVUlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:41:24 -0400
Date: Tue, 22 Jul 2003 16:56:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030722205629.GA27179@gtf.org>
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722190705.GA2500@codepoet.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 01:07:05PM -0600, Erik Andersen wrote:
> On Tue Jul 22, 2003 at 02:54:43PM -0400, Jeff Garzik wrote:
> > Bart, Alan, and I have been looking at this.  It uses the ancient CAM
> > model, that we don't really want to merge directly in the kernel.  It's
> > very close to the libata model, from the user perspective, so life is 
> > good.
> 
> I was reading over your libata driver yesterday.  Certainly a lot
> cleaner than the cam stuff IMHO.  Given the info made available
> via the Promise driver, I expect that I could get an initial
> libata host adaptor driver hacked together in short order.  After
> all, the Intel one is just 400 lines.  So unless you (or anyone
> else) have already started or would prefer to do the honors,
> I'll try to hack something together this evening,

Shoot, that would be great ;-)

For the future, libata will need a tad bit more queueing than is
currently supported.  But there is enough support in libata right now to
handle basic Promise support.

On a legal note, I would prefer that completely new drivers (i.e. no
copied code from other sources) be licensing in the same way as
libata.c.  Maintainer's preference in the end, of course, but I would
like to strongly encourage following libata.c's example ;-)

I have a TX2 board, too, so I can test your stuff as well.

	Jeff


