Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbTCOIFN>; Sat, 15 Mar 2003 03:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbTCOIFN>; Sat, 15 Mar 2003 03:05:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2434 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261320AbTCOIFK>;
	Sat, 15 Mar 2003 03:05:10 -0500
Date: Sat, 15 Mar 2003 09:15:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
Message-ID: <20030315081558.GK791@suse.de>
References: <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org> <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org> <20030314104219.GA791@suse.de> <1047637870.1147.27.camel@ixodes.goop.org> <20030314113732.GC791@suse.de> <1047664774.25536.47.camel@ixodes.goop.org> <20030314180716.GZ791@suse.de> <1047680345.1508.2.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047680345.1508.2.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Jeremy Fitzhardinge wrote:
> On Fri, 2003-03-14 at 10:07, Jens Axboe wrote:
> > > Ejecting and reinserting the disc seems to restore things:
> > 
> > Really weird, I can't reproduce here at all. My drive gives the correct
> > result no matter if it's empty or loaded. Results are repeatable, too.
> > DMA or PIO, didn't matter.
> > 
> > > Notice the "version" and "response format" fields have changed.
> > 
> > Yeah, something is really screwed. Hmmm, let spend a bit of time with
> > this problem...
> 
> I just double-checked, and everything behaves as expected with ide-scsi.

I can reliably crash the box with SG_IO -> ide-cd here, so I'm hoping
there's a connection. Need to move it to a box where nmi watchdog
actually works...

-- 
Jens Axboe

