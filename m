Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264529AbRFOVim>; Fri, 15 Jun 2001 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264536AbRFOVia>; Fri, 15 Jun 2001 17:38:30 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:56569 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264529AbRFOViW>; Fri, 15 Jun 2001 17:38:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106152137.f5FLbOim016557@webber.adilger.int>
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <E15B0vv-000780-00@the-village.bc.nu> "from Alan Cox at Jun 15,
 2001 10:15:11 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 15 Jun 2001 15:37:23 -0600 (MDT)
CC: Thiago Vinhas de Moraes <tvlists@networx.com.br>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan writes:
> > Why the 2.4.5-ac series doesn't have merges from Linus 2.4.6-pre anymore?
> 
> Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
> enough to merge. I'm letting someone else be the sucide squad.. so far it
> looks like it is indeed fine but I want to wait and see more yet

It has been working relatively well for me in benchmarks (I'm actually
using 2.4 ext3 for my real filesystems, with backups of course ;-).
Performance of the page-cache directories up for directory operations,
but strangely file read performance is down.  Anyone else noticed this?

I saw this repeatedly using the reiserfs mongo benchmark.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
