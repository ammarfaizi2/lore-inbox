Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267120AbUBMRST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267123AbUBMRST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:18:19 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36745 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267120AbUBMRSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:18:07 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Date: Fri, 13 Feb 2004 18:23:53 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200402122106.41947.bzolnier@elka.pw.edu.pl> <20040213083718.GA11914@alpha.home.local>
In-Reply-To: <20040213083718.GA11914@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402131823.53939.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 of February 2004 09:37, Willy Tarreau wrote:
> Hi Bart,
>
> On Thu, Feb 12, 2004 at 09:06:41PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Willy, it seems you are hitting some other problem.
> > Have you already tried booting with "ide0=ata66"?
>
> Sorry, I think I mangled it like "hda=ata66" or "ide0=udma66" instead when
> I tried. I just rechecked with "ide0=ata66", and I confirm that it works

Great, but I wonder why cable bits are set incorrectly.
Probably it's a BIOS bug, maybe BIOS update will help?

> (it uses UDMA100). BTW, wouldn't it be more appropriate to use something
> such as "udma4" or "80pin" or something else which would be more intuitive
> than "ata66" ?

It is "ata66" because of compatibility :/.

Cheers,
--bart

