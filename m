Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTKKR0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTKKR0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:26:42 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38051 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263466AbTKKR0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:26:41 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Subject: Re: PATCH: CMD640 IDE chipset
Date: Tue, 11 Nov 2003 18:26:21 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031110130021.35782.qmail@web20604.mail.yahoo.com> <200311111750.25292.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311111750.25292.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311111826.21390.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Uhh.. mail was sent too early thanks to KMail's "feature". ]

On Tuesday 11 of November 2003 17:50, Bartlomiej Zolnierkiewicz wrote:
> > > >   The code that handles PIO settings was rearanged in a new function:
> > > > cmd640_tuneproc().
> > >
> > > Is this really necessary, it is even harder to read it now...
> >
> >   It is necessary, unless the purpose of this piece of code is
> > readability.

No, but I want to know WHY it is necessary.

> > > Stefan, please rework your patch.  Thanks.
> >
> >   If you say that the only way I will get this driver fixed is to keep it
> >   ugly then I will send you a lame patch that does just that.
>
> Minimize changes, then next time when you need to fix this driver (say in
> 2.7) you will spend much less time on tracking changes 2.0.x->2.7.x.

I've get report that fixing outb->outl issue is sufficient to get working driver.
Still dunno about second channel support.

Waiting for a lame patch... :)
--bartlomiej

