Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUEQQMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUEQQMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUEQQMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:12:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33982 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261786AbUEQQMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:12:38 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: mike@kordik.net
Subject: Re: HDIO_SET_DMA failed: with nforce2 board
Date: Mon, 17 May 2004 18:13:07 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <pan.2004.05.17.02.15.01.317598@kordik.net> <200405171434.24417.bzolnier@elka.pw.edu.pl> <22324.64.214.120.194.1076836710.squirrel@www.kordik.net>
In-Reply-To: <22324.64.214.120.194.1076836710.squirrel@www.kordik.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405171813.07359.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 of February 2004 10:18, mike@kordik.net wrote:
> > On Monday 17 of May 2004 13:39, Mike Kordik wrote:
> >> On Mon, 2004-05-17 at 07:13, Bartlomiej Zolnierkiewicz wrote:
> >> > On Monday 17 of May 2004 04:15, Mike wrote:
> >> > > I have an nforce2 based board and I cannot enable dma.
> >> >
> >> > 'dmesg' output, please
> >>
> >> I posted using PAN and I am trying to respond with PAM but todays posts
> >> and some of yesterdays are not showing up. I do not know what the
> >> problem is but I apologize for responding this way. Here is my dmesg
> >> output:
> >
> > OK, thanks.
> >
> >> Linux version 2.6.4-rc1-mm1 (root@cdimage) (gcc version 3.3.3 20040217
> >> (Gentoo Linux 3.3.3, propolice-3.3-7)) #3 Mon May 17 00:17:40 EDT 2004
> >
> > ...
> >
> >> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> >> ide: Assuming 33MHz system bus speed for PIO modes; override with
> >> idebus=xx
> >> pnp: the driver 'ide' has been registered
> >> hda: Maxtor 6Y120L0, ATA DISK drive
> >> hdb: WDC WD1600BB-00HTA0, ATA DISK drive
> >> hdc: MATSHITADVD-ROM SR-8582, ATAPI CD/DVD-ROM drive
> >> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> >> ide1 at 0x170-0x177,0x376 on irq 15
> >
> > AMD/nVidia IDE driver didn't recognize the controller
> > (or driver wasn't compiled in for some reason).
> >
> > I need full .config and 'lspci -vvv' output to know more.
> >
> > Bartlomiej
>
> Bartlomiej,
>      Thank you for your help!
>
> I double checked my boot partition to make sure I actually had copied over
> the latest kernel I had compiled and it has the right date and time stamp
> on it.
>
> The info you requessted.
>
> .config:

Weird, everything looks OK.  Can you retest with vanilla 2.6.4-rc1?

