Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317543AbSGTVzl>; Sat, 20 Jul 2002 17:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSGTVzl>; Sat, 20 Jul 2002 17:55:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46574 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317543AbSGTVzk>; Sat, 20 Jul 2002 17:55:40 -0400
Date: Sat, 20 Jul 2002 23:58:25 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Impressions of IDE 98?
In-Reply-To: <87k7nqctsf.fsf@arm.t19.ds.pwr.wroc.pl>
Message-ID: <Pine.SOL.4.30.0207202356080.22207-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Jul 2002, Arkadiusz Miskiewicz wrote:

> Thunder from the hill <thunder@ngforever.de> writes:
>
> > Hi,
> >
> > I don't have any IDE machines handy, and since these problems that IDE had
> > in the last days, I wonder what's become of it. Has anyone been so brave
> > as to try out 2.5.26 w/the included IDE (IDE 98)? How is it?
> On my Duron system where LG CD-RW GCE-8320B is connected as hda to
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
> and three IDE discs (hde: IBM-DTLA-307030 [30GB], hdg: ST380021A [80GB],
> hdh: ST360021A [60GB]) connected to:
> 00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
> 2.5.26+xfs patch boots, detects VIA IDE controller, finds my cdrw
> and stops - no oops just booting stops, HDD LED (connected to promise
> controller) is on. Nothing more happens.
>
> On 2.4.18 + Hedrick patches there is no problem.

And on some recent 2.4.19-rc ar -ac?

2.5.27 have my forward port of Hank's fixes for Promise controllers.
It may help... (or not).

Regards
--
Bartlomiej

>
> > 							Thunder
>
> --
> Arkadiusz Mi¶kiewicz   IPv6 ready PLD Linux at http://www.pld.org.pl
> misiek(at)pld.org.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PWr

