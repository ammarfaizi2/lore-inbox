Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267128AbUBMR1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267131AbUBMR1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:27:15 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45962 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267128AbUBMR1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:27:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Date: Fri, 13 Feb 2004 18:33:03 +0100
User-Agent: KMail/1.5.3
References: <200402122106.41947.bzolnier@elka.pw.edu.pl> <c0goeh$hs4$1@news.cistron.nl>
In-Reply-To: <c0goeh$hs4$1@news.cistron.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402131833.03660.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 of February 2004 21:41, Miquel van Smoorenburg wrote:
> In article <200402122106.41947.bzolnier@elka.pw.edu.pl>,
>
> Bartlomiej Zolnierkiewicz  <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> >Hi,
> >
> >word93 of drive identify is:
> >
> >0x603b for IC35L120AVV207-0
> >0x3469 for QUANTUM FIREBALLlct20 30
> >
> >and eighty_ninty_three() checks for bit 0x4000, so...
> >
> >Willy, it seems you are hitting some other problem.
> >Have you already tried booting with "ide0=ata66"?
>
> That reminds me, there is currenly no way to boot with
> ide0=ata33, right ?

Right.

> I have a tyan motherboard with a serverworks chipset, and the
> (2.5" system-) disk is connected with a 40 pins cable. However
> the serverworks chipset doesn't detect this, and tries to run
> it in UDMA<lots> mode. That results in lots of nasty messages
> before it falls back to UDMA33 mode.

It sounds like driver or BIOS bug.  Can I get dmesg from this system?

> Could you put a way to force it into UDMA33 (UDMA2) mode on the
> wishlist, please ?

Yep.

