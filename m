Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSIWTcJ>; Mon, 23 Sep 2002 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSIWTap>; Mon, 23 Sep 2002 15:30:45 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261310AbSIWSlh>;
	Mon, 23 Sep 2002 14:41:37 -0400
Date: Mon, 23 Sep 2002 12:28:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid
 SCB 0
In-Reply-To: <1184680000.1032536231@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0209231227330.922-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Sep 2002, Justin T. Gibbs wrote:

> > Celeron 1.3GHz, Intel i815 chipset, 512MB ram.
> >
> > AIC-2640 PCI card with uw and narrow connectors. A Seagate scsi disk
> > (rootfs) attached to uw, and a HP tape drive attached to narrow. Tape
> > drive never used.
> >
> > I only ran 2.4.20pre7 (no other patches) for a night and it crashed:
> >
> > -------------------------------------------------------------------
> > Kernel panic: HOST_MSG_LOOP with invalid SCB 0
> >
> > In interrupt handler, not syncing
>
> I need all of the messages leading up to the panic in order to
> diagnose this.  You may need to use a serial console to get
> them all.

Justin,

I guess is the second or third report of problems with the new aic7xxx :(

