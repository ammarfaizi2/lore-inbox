Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbTJSUsR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTJSUsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:48:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64715 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262187AbTJSUsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:48:11 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>, Svetoslav Slavtchev <svetljo@gmx.de>,
       axboe@suse.de
Subject: Re: HighPoint 374
Date: Sun, 19 Oct 2003 22:51:46 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10310191329150.15306-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10310191329150.15306-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310192251.46159.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andre, thanks for helpful hint.
Svetoslav, the right person to whine about TCQ stuff is Jens Axboe 8-).

--bartlomiej

On Sunday 19 of October 2003 22:30, Andre Hedrick wrote:
> You do not enable TCQ on highpoint without using the hosted polling timer.
> Oh and I have not added it, and so hit Bartlomiej up for the additions.
>
> Andre Hedrick
> LAD Storage Consulting Group
>
> On Sun, 19 Oct 2003, Svetoslav Slavtchev wrote:
> > i have the same problems with epox 8k9a3+,
> > and may be even strange ones
> > (like fs coruption when soft raid & / or lvm is used)
> >
> > and i never had the problems with 8k5a3+,
> > the drives were actually taken from the 8k5a3+
> > when it died (me silly tried to update to XP2700)
> >
> > really strange, isn't it
> >
> > both boards should be the same, except
> > 8k5a3+ uses kt333
> > 8k9a3+ uses kt400
> >
> > only mainboard change -> hell of a lot unresolved problems
> >
> >
> > svetljo
> > kernels used 2.4.21-2.4.23-pre3 2.6.0-test3-test7bk8
> >
> > and a nice log when i try to enable TCQ
> >
> > all Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>]
> > [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> > Badness in as_remove_dispatched_request at
> > drivers/block/as-iosched.c:1022 Call Trace: [<c0235ee3>]  [<c022e834>] 
> > [<c025b0ef>]  [<c026e0ed>] [<c025c7e2>]  [<c026e080>]  [<c010df03>] 
> > [<c010e233>]  [<c010c7d8>] Badness in as_remove_dispatched_request at
> > drivers/block/as-iosched.c:1022 Call Trace: [<c0235ee3>]  [<c022e834>] 
> > [<c025b0ef>]  [<c026e0ed>] [<c025c7e2>]  [<c026e080>]  [<c010df03>] 
> > [<c010e233>]  [<c010c7d8>] Badness in as_remove_dispatched_request at
> > drivers/block/as-iosched.c:1022 Call Trace: [<c0235ee3>]  [<c022e834>] 
> > [<c025b0ef>]  [<c026e0ed>] [<c025c7e2>]  [<c026e080>]  [<c010df03>] 
> > [<c010e233>]  [<c010c7d8>]

