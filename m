Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSGIOiK>; Tue, 9 Jul 2002 10:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSGIOiJ>; Tue, 9 Jul 2002 10:38:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20985 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315437AbSGIOiH>; Tue, 9 Jul 2002 10:38:07 -0400
Date: Tue, 9 Jul 2002 16:40:28 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] using 2.5.25 with IDE
In-Reply-To: <200207091624.23388.roy@karlsbakk.net>
Message-ID: <Pine.SOL.4.30.0207091634550.16892-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Roy Sigurd Karlsbakk wrote:

> > Contrary to the popular belief 2.5.25 has only Martin's IDE-93
> > and has broken locking...
> >
> > If you want to run IDE on 2.5.25 get and apply:
> >
> > IDE-94 by Martin
> > IDE-95/96/97/98-pre by me
> >
> > from:
> > http://home.elka.pw.edu.pl/~bzolnier/ata/
>
> ...or run it with 2.4 IDE core as previously announced by Jens Axboe :-)

2.4 IDE + 2.5 block layer = PIO still broken :-)
(broken error recovery and data integrity on error)

Mostly you dont care unless CRC or sector error bites you
and you are screwed ;-)

But do not worry, I'm near to fixing it for 2.5.

Greets
--
Bartlomiej

> roy
>
> --
> Roy Sigurd Karlsbakk, Datavaktmester
>
> Computers are like air conditioners.
> They stop working when you open Windows.


