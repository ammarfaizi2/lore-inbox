Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129731AbRBAO7z>; Thu, 1 Feb 2001 09:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130104AbRBAO7q>; Thu, 1 Feb 2001 09:59:46 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:33033 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129731AbRBAO7j>; Thu, 1 Feb 2001 09:59:39 -0500
Message-ID: <3A797AD0.D5956248@dawa.demon.co.uk>
Date: Thu, 01 Feb 2001 15:03:44 +0000
From: Paul Flinders <paul@dawa.demon.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <3A784412.28B455A1@ftel.co.uk> <Pine.LNX.4.10.10101310947170.14252-100000@master.linux-ide.org> <20010201151531.C5706@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

> On Wed, 31 Jan 2001, Andre Hedrick wrote:
>
> > On Wed, 31 Jan 2001, Paul Flinders wrote:
> >
> > > Talking of the Promise are there any plans to support re-enabling
> > > of the 2nd channel for boards which have an on-board FastTrak?
> >
> > FastTrak == Ultra - Fake-RAID
>
> But Fake-RAID is CHEAP to get two additional UDMA-5 capable channels :-)
> Just jumper for normal ATA/100 mode.

The MSI 6321 motherboard *doesn't* *have* an option to run the chipset in
"normal" ATA/100 mode, that's the problem.

Andre didn't really answer my question so, to re-phrase - can the 20265
on these boards be set up as a "normal" 2-port ATA/100 controller in software.
The BIOS only enables one port - the second port's "enable bit" is showing
that it is disabled. There is _no_ BIOS option to run it in non-RAID mode
and no jumpers on the board to do so either.

If it can, then I'll happily write the code myself and maintain a local patch
if needs be but I need to know what bits to poke out of what port and in what
order. If it can't be done at least I'll _know_ that it can't be done.

I've already tried the MSI support mail address and been met with stunning
silence.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
