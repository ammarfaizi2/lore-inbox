Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTJSUyO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJSUyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:54:14 -0400
Received: from pop.gmx.net ([213.165.64.20]:55690 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262192AbTJSUyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:54:06 -0400
Date: Sun, 19 Oct 2003 22:54:02 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: andre@linux-ide.org, axboe@suse.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <200310192251.46159.bzolnier@elka.pw.edu.pl>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <14385.1066596842@www23.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Andre, thanks for helpful hint.
> Svetoslav, the right person to whine about TCQ stuff is Jens Axboe 8-).

j don't really care about TCQ that much anymore
(i bought the drives because they were marked as supported)

but the fs corruption when md/lvm is used,
and the dma timeouts ;( 

svetljo
 
> On Sunday 19 of October 2003 22:30, Andre Hedrick wrote:
> > You do not enable TCQ on highpoint without using the hosted polling
> timer.
> > Oh and I have not added it, and so hit Bartlomiej up for the additions.
> >
> > Andre Hedrick
> > LAD Storage Consulting Group
> >
> > On Sun, 19 Oct 2003, Svetoslav Slavtchev wrote:
> > > i have the same problems with epox 8k9a3+,
> > > and may be even strange ones
> > > (like fs coruption when soft raid & / or lvm is used)
> > >
> > > and i never had the problems with 8k5a3+,
> > > the drives were actually taken from the 8k5a3+
> > > when it died (me silly tried to update to XP2700)
> > >
> > > really strange, isn't it
> > >
> > > both boards should be the same, except
> > > 8k5a3+ uses kt333
> > > 8k9a3+ uses kt400
> > >
> > > only mainboard change -> hell of a lot unresolved problems
> > >
> > >
> > > svetljo
> > > kernels used 2.4.21-2.4.23-pre3 2.6.0-test3-test7bk8
> > >
> > > and a nice log when i try to enable TCQ
> > >
> > > all Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>]
> > > [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> > > Badness in as_remove_dispatched_request at
> > > drivers/block/as-iosched.c:1022 Call Trace: [<c0235ee3>]  [<c022e834>]
> 
> > > [<c025b0ef>]  [<c026e0ed>] [<c025c7e2>]  [<c026e080>]  [<c010df03>] 
> > > [<c010e233>]  [<c010c7d8>] Badness in as_remove_dispatched_request at
> > > drivers/block/as-iosched.c:1022 Call Trace: [<c0235ee3>]  [<c022e834>]
> 
> > > [<c025b0ef>]  [<c026e0ed>] [<c025c7e2>]  [<c026e080>]  [<c010df03>] 
> > > [<c010e233>]  [<c010c7d8>] Badness in as_remove_dispatched_request at
> > > drivers/block/as-iosched.c:1022 Call Trace: [<c0235ee3>]  [<c022e834>]
> 
> > > [<c025b0ef>]  [<c026e0ed>] [<c025c7e2>]  [<c026e080>]  [<c010df03>] 
> > > [<c010e233>]  [<c010c7d8>]
> 

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

