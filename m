Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317890AbSGWBfV>; Mon, 22 Jul 2002 21:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317895AbSGWBfV>; Mon, 22 Jul 2002 21:35:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62941 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317890AbSGWBfU>; Mon, 22 Jul 2002 21:35:20 -0400
Date: Tue, 23 Jul 2002 03:38:12 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Brad Hards <bhards@bigpond.net.au>
cc: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.27 IDE: problems, again.
In-Reply-To: <200207231120.00126.bhards@bigpond.net.au>
Message-ID: <Pine.SOL.4.30.0207230328480.607-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Brad Hards wrote:

> On Tue, 23 Jul 2002 00:45, Stelian Pop wrote:
> > Disabling PIIX chipset support & dma makes the kernel survive for
> > some longer time (between 10 seconds and 2-3 minutes), but it will
> > eventually halt, this time CORRUPTING THE DATA!
> See Bart's comments in separate post.
>
> > Right now I'm trying to recover my disk partition...
>
> You are *out of your fscking mind*.

Yup, learn hints by heart ;-).

> Why are you running 2.5 on a machine that has anything worth
> recovering on it? IDE or SCSI, no matter.
>
> Standard 2.5 equipment includes a CD drive with the install disk(s)
> for $DISTRO ready to drop into the drive as soon as anything looks
> bad. Advanced 2.5 requires a duplicate hard disk on a removable drive
> caddy :)

I somehow managed to go through 2.5 without any recovering
(even doing ATA and block layer development), call me lucky ;-).

Few hints on running 2.5 on production machine:
- don't run every new kernel revision, wait for some time and read lkml
  (if there are any problems noticed)
- even better wait for next revision and read changelog,
  decide if you can apply now previous revision
- don't run default IDE, get 2.4 IDE patch
- be careful, double thinking mode on :-)

Regards
--
Bartlomiej


> Brad
>
> --
> http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.

