Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUHMLsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUHMLsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUHMLsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:48:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263761AbUHMLrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:47:52 -0400
Date: Fri, 13 Aug 2004 13:47:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Clayton <chris@theclaytons.giointernet.co.uk>
Cc: Alan Jenkins <sourcejedi@phonecoop.coop>, linux-kernel@vger.kernel.org
Subject: Re: CDMRW in 2.6
Message-ID: <20040813114711.GM2663@suse.de>
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk> <411C73FE.9020107@phonecoop.coop> <20040813080122.GB2663@suse.de> <200408131247.58289.chris@theclaytons.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408131247.58289.chris@theclaytons.giointernet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13 2004, Chris Clayton wrote:
> On Friday 13 Aug 2004 08:01, Jens Axboe wrote:
> > (don't trim cc lists...)
> >
> > On Fri, Aug 13 2004, Alan Jenkins wrote:
> > > Jens Axboe wrote:
> > > >On Mon, Aug 09 2004, Chris Clayton wrote:
> > > >>cdrom: hdc: mrw address space DMA selected
> > > >>cdrom open: mrw_status 'mrw complete'
> > > >>hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> > > >>hdc: command error: error=0x54
> > > >>end_request: I/O error, dev hdc, sector 1048576
> > > >
> > > >Command was aborted, probably the media isn't writable after all.  Can
> > > >you try and force a full format with cdrwtool?
> > >
> > > I don't like to sound critical or "me too"-ish, but I have had the same
> > > problem with my LiteOn Combo SOHC-5232K. The error and status codeswere
> > > the same. I contacted Jens Axboe, but he wasn't able to help me and
> > > suggested it was a firmware problem. I'll try the suggestion. I hope
> > > this isn't a problem with a ll LiteOn drives.
> >
> > It is suspicious, since Chris is using a LiteOn as well. I have no clues
> > what is wrong so far, I can just see that it's aborting the write
> > command.
> 
> Actually, it's even more suspicious than that. As I said in the first
> message in this thread, this is my second Lite-on drive - I replaced
> the original (with a model that mt-rainier.org/ shows as being
> validated) in an attempt to get Mt Rainier working. Furthermore, my
> attempts to find a solution on LKML unearted a posting by Doug
> Holland, who was also reporting problems with a Lite-on drive
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=107955822109371&w=2).

I have a few drives here, it works fine for me. The implementation is
constructed after the first pre-drafts of mt rainier. I'd like to get it
working on the Lite-on, without a drive (or acces to one) it's going to
be time consuming.

-- 
Jens Axboe

