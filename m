Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTJ3QEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTJ3QEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:04:31 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37583 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262608AbTJ3QEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:04:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, Shaheed <srhaque@iee.org>
Subject: Re: WG:  EIO DM-8401H ATA133 IDE Controller Card ( Silicon Image Chip ?!?)
Date: Thu, 30 Oct 2003 17:08:54 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, michael@labuschke.de
References: <200310301312.52793.srhaque@iee.org> <3FA11F00.9020000@pobox.com>
In-Reply-To: <3FA11F00.9020000@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310301708.54529.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 of October 2003 15:24, Jeff Garzik wrote:
> Shaheed wrote:
> > Interestingly, EXACTLY the same thing happened to me. I actually bought a
> > vanilla IDE controller for a spare disk, and in what showed up the
> > documentation claimed it was a DM-8401R, but lspci shows what you see:
> > and IT8212.
> >
> > The answer was to get the good stuff from here:
> >
> > http://www.iteusa.com/productInfo/Download.html#IT8212%20ATA133%20Control
> >ler
> >
> > The driver install was a doddle (well documented, and easy to apply
> > Mandrake 9.1 instructions to 9.2). For heavens sake: these guys even
> > provide the specs online. And the driver seems to work, though I am not
> > stressing it.
>
> Neat.  Even though it's a SCSI driver, it's very definitely a standard
> IDE controller, which should be easy for Bart or somebody to add to
> drivers/ide ...

I even have one such controller,
I just need to find some time and spare drives...

--bartlomiej

