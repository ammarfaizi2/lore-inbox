Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSG1MrU>; Sun, 28 Jul 2002 08:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSG1MrU>; Sun, 28 Jul 2002 08:47:20 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18611 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316043AbSG1MrU>; Sun, 28 Jul 2002 08:47:20 -0400
Date: Sun, 28 Jul 2002 14:50:29 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
In-Reply-To: <Pine.LNX.4.44.0207272131250.6125-100000@home.transmeta.com>
Message-ID: <Pine.SOL.4.30.0207281442050.17165-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Jul 2002, Linus Torvalds wrote:

> On Sat, 27 Jul 2002, Linus Torvalds wrote:
> >
> > I'm talking about people who don't even bother to do
> > bug-reports, but only trash-talk the maintenance.
>
> On that note, let me mention the machines I personally am using IDE, and
> apparently do not see problems: a dual PII with "Intel Corp. 82371AB PIIX4
> IDE", and a P4 with "SiS 5513 IDE (rev 208)".
>
> Both setups in DMA mode, both setups have one disk per channel (first
> channel is disk, second channel is CD-ROM).
>
> So what are the patterns for "working" vs "broken"?
>
> 		Linus

You have too standard systems to see problems :-).

Unusual combinations or more quirky chipsets -> real problems.

Plus there are PIO problems (esp. multisector), but some of them
(not all) are in 2.4 IDE forward port also.

Regards
--
Bartlomiej

