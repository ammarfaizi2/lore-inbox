Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWAYQ6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWAYQ6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWAYQ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:58:29 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:12742 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750972AbWAYQ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:58:29 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 17:57:36 +0100
To: jengelh@linux01.gwdg.de, axboe@suse.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: 
 Rationale for RLIMIT_MEMLOCK?)
Message-ID: <43D7AE00.nailDFJ61L10Z@burner>
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
In-Reply-To: <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>
> >> And if you check the amount of completely unneeded code Linux currently has 
> >> just to implement e.g. SG_IO in /dev/hd*, it could even _save_ space in the 
> >> kernel when converting to a clean SCSI based design.
> >
> >Please point me at that huge amount of code. Hint: there is none.
>
> I'm getting a grin:
>
> 15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0 grep SG_IO
> (no results)
>
> Looks like it's already non-redundant :)

everything in drivers/block/scsi_ioctl.c  is duplicate code and I am sure I 
would find more if I take some time....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
