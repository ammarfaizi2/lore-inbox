Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTDRJfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 05:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTDRJfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 05:35:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29429 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262985AbTDRJfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 05:35:03 -0400
Date: Fri, 18 Apr 2003 11:46:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <Pine.LNX.4.10.10304171935301.11686-100000@master.linux-ide.org>
Message-ID: <Pine.SOL.4.30.0304181145110.17729-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Apr 2003, Andre Hedrick wrote:

> ide_diag_taskfile

???

> Do not do that it will break paths!

What paths?

> On Fri, 18 Apr 2003, Bartlomiej Zolnierkiewicz wrote:
>
> >
> > Hey,
> >
> > This time 5 incremental patches:
> >
> > 1       - Fix PIO handlers for Taskfile ioctls.
> > 2a + 2b - Taskfile and flagged Taskfile PIO handlers unification.
> > 3       - Map HDIO_DRIVE_CMD ioctl onto taskfile.
> > 4       - Remove dead ide_diag_taskfile() code.
> >
> > [ More comments inside patches. ]
> >
> > Special care is needed for patch 3 as it is a bit experimental,
> > but at least hdparm -I /dev/hdx still works :-).
> > I have also made version using direct IO to user pages,
> > it works okay too but needs some more work to be elegant...
> >
> > You can also get them at:
> > http://home.elka.pw.edu.pl/~bzolnier/patches/2.5.67-ac1/
> >
> > --
> > bzolnier
> >
>
> Andre Hedrick
> LAD Storage Consulting Group

