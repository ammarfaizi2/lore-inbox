Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbUCENWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 08:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbUCENWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 08:22:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50413 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262594AbUCENWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 08:22:23 -0500
Date: Fri, 5 Mar 2004 14:22:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Colin Leroy <colin@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040305132215.GT10923@suse.de>
References: <20040304152840.GL2708@suse.de> <20040305130803.0c01ee83@jack.colino.net> <20040305122151.GL10923@suse.de> <299601c402b3$e4f4da70$3cc8a8c0@epro.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299601c402b3$e4f4da70$3cc8a8c0@epro.dom>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05 2004, Colin Leroy wrote:
> Hi,
> 
> > > Works (on ppc, ibook G4 here). It's indeed faster. But, it breaks
> direct
> > > output to dsp (as in `cdparanoia 1 /dev/dsp`).
> >
> > How do you know it works, then? cdparanoia should receive identical
> > data, otherwise it sounds like it doesn't work.
> 
> Well, using 'mplayer cdda.wav' works.
> 
> > Dump a track without the patch, repeat with the patch, and compare the
> > images.
> 
> With or without the patch, that's the exact same file resulting. Maybe the
> fact that it doesn't work anymore with /dev/dsp isn't due to your patch
> but to something else (I hadn't tried that since a while). I'll report
> again as soon as i'll be in front of my laptop.

Ok great, then it must be something else. Thanks for the report.

-- 
Jens Axboe

