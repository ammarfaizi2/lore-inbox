Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSGXNSp>; Wed, 24 Jul 2002 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSGXNSp>; Wed, 24 Jul 2002 09:18:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24023 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317101AbSGXNSo>; Wed, 24 Jul 2002 09:18:44 -0400
Date: Wed, 24 Jul 2002 15:21:35 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <martin@dalecki.de>
cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: please DON'T run 2.5.27 with IDE!
In-Reply-To: <3D3EA74F.4090706@evision.ag>
Message-ID: <Pine.SOL.4.30.0207241520060.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Marcin Dalecki wrote:

> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 24 Jul 2002, Marcin Dalecki wrote:
> >
> >
> >>[root@localhost block]# grep \>special *.c
> >>elevator.c:         !rq->waiting && !rq->special)
> >>^^^^^^ This one is supposed to have the required barrier effect.
> >
> >
> > Go reread, no barrier effect, requests can slip in before your
> > REQ_SPECIAL. They cannon only be merged with REQ_SPECIAL.
>
> Erm. Please note that I don't see any problem here. It's just
> a matter of completeness.

For now yes.

