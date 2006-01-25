Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWAYUQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWAYUQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWAYUQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:16:46 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9447 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751194AbWAYUQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:16:46 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
	Rationale for RLIMIT_MEMLOCK?)
From: Lee Revell <rlrevell@joe-job.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, axboe@suse.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <43D7AE00.nailDFJ61L10Z@burner>
References: <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
	 <1138039993.2977.62.camel@laptopd505.fenrus.org>
	 <20060123185549.GA15985@merlin.emma.line.org>
	 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
	 <20060123212119.GI1820@merlin.emma.line.org>
	 <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
	 <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de>
	 <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr>
	 <43D7AE00.nailDFJ61L10Z@burner>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 15:16:43 -0500
Message-Id: <1138220203.3087.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 17:57 +0100, Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> >
> > >> And if you check the amount of completely unneeded code Linux currently has 
> > >> just to implement e.g. SG_IO in /dev/hd*, it could even _save_ space in the 
> > >> kernel when converting to a clean SCSI based design.
> > >
> > >Please point me at that huge amount of code. Hint: there is none.
> >
> > I'm getting a grin:
> >
> > 15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0 grep SG_IO
> > (no results)
> >
> > Looks like it's already non-redundant :)
> 
> everything in drivers/block/scsi_ioctl.c  is duplicate code and I am sure I 
> would find more if I take some time....

PLEASE don't cc: me on this asinine thread anymore.

Argh, I KNEW this would end with the same exact flame war.

Lee

