Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269026AbUHMIC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269026AbUHMIC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269027AbUHMIC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:02:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17805 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269023AbUHMICI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:02:08 -0400
Date: Fri, 13 Aug 2004 10:01:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Jenkins <sourcejedi@phonecoop.coop>
Cc: linux-kernel@vger.kernel.org, chris@theclaytons.giointernet.co.uk
Subject: Re: CDMRW in 2.6
Message-ID: <20040813080122.GB2663@suse.de>
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk> <20040813071537.GE2321@suse.de> <411C73FE.9020107@phonecoop.coop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411C73FE.9020107@phonecoop.coop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't trim cc lists...)

On Fri, Aug 13 2004, Alan Jenkins wrote:
> Jens Axboe wrote:
> 
> >On Mon, Aug 09 2004, Chris Clayton wrote:
> > 
> >
> >>cdrom: hdc: mrw address space DMA selected
> >>cdrom open: mrw_status 'mrw complete'
> >>hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> >>hdc: command error: error=0x54
> >>end_request: I/O error, dev hdc, sector 1048576
> >>   
> >>
> >
> >Command was aborted, probably the media isn't writable after all.  Can
> >you try and force a full format with cdrwtool?
> >
> > 
> >
> I don't like to sound critical or "me too"-ish, but I have had the same 
> problem with my LiteOn Combo SOHC-5232K. The error and status codeswere 
> the same. I contacted Jens Axboe, but he wasn't able to help me and 
> suggested it was a firmware problem. I'll try the suggestion. I hope 
> this isn't a problem with a ll LiteOn drives.

It is suspicious, since Chris is using a LiteOn as well. I have no clues
what is wrong so far, I can just see that it's aborting the write
command.

-- 
Jens Axboe

