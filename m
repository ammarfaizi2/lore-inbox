Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTKSAiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 19:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbTKSAiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 19:38:50 -0500
Received: from nevyn.them.org ([66.93.172.17]:64411 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263772AbTKSAit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 19:38:49 -0500
Date: Tue, 18 Nov 2003 19:38:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: Larry McVoy <lm@bitmover.com>, Ben Collins <bcollins@debian.org>,
       Sven Dowideit <svenud@ozemail.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031119003840.GA29668@nevyn.them.org>
Mail-Followup-To: Andrew Walrond <andrew@walrond.org>,
	Larry McVoy <lm@bitmover.com>, Ben Collins <bcollins@debian.org>,
	Sven Dowideit <svenud@ozemail.com.au>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <20031118183058.GS476@phunnypharm.org> <20031118184200.GA13966@work.bitmover.com> <200311190024.51548.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311190024.51548.andrew@walrond.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 12:24:51AM +0000, Andrew Walrond wrote:
> I'm likely to get a slap for this one, but....
> 
> On Tuesday 18 Nov 2003 6:42 pm, Larry McVoy wrote:
> >
> > I'm curious as to why you would think this is better than the CVS gateway.
> > The CVS gateway is actually a really nice thing.  The whiners think we
> > have somehow hamstrung the data in the gateway but that's only because
> > they haven't looked at the data, if they had done a careful comparison
> > then they'd know it's all in there.
> 
> Since you've already done all the work for bk2cvs, why not add the 
> functionality to bkd which would allow a simple client to do
> 
> 	lobobk cvsclone
> and
> 	lobobk cvspull
> 
> Ie be able to clone and update a local cvs repo from bkd? This would have the 
> added advantage that users (kernel testers) could get any tagged versions 
> from their local repo using cvs, rather than requiring diff trasmission from 
> bkd to convert to another version. The client would be very simple too.

Presumably because he's said several times that the bk2cvs gateway
software is based on (and requires) the commercial version of bk.  Not
to mention that the way it generates repositories isn't really
compatible with this model.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
