Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTK3UN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTK3UN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 15:13:56 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26087 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263008AbTK3UNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 15:13:54 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Santiago Garcia Mantinan <lkml@manty.net>
Subject: Re: IDE DMA setting not available on 2.4.23 as a module
Date: Sun, 30 Nov 2003 21:15:07 +0100
User-Agent: KMail/1.5.4
References: <20031130195815.GA2409@man.beta.es>
In-Reply-To: <20031130195815.GA2409@man.beta.es>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311302115.07898.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you have piix.o module loaded or PIIX support compiled-in?

--bart

On Sunday 30 of November 2003 20:58, Santiago Garcia Mantinan wrote:
> Hi!
>
> Yesterday I started to upgrade my systems to 2.4.23, some of them were
> already running pre or rc versions, but when I tried my Pentium MMX wich
> boots out of SCSI and on which I like to have IDE driver as a module, I
> found that the DMA setting was not working, hdparm was saying:
>
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>
> So I changed the driver option to set DMA by default to ON, but nothing
> changed, still the same problem, then I tried to compile the IDE driver
> into the kernel instead of having it as a module and then the dma support
> started to work, either having the driver enable it by default or by
> setting it with hdparm.
>
> The motherboard uses a 430TX chipset, thus with a PIIX4 IDE controller.
>
> Is this a bug or is this a known and accepted limitation of having the IDE
> driver as a module?
>
> If you want me to test any patch to see if we can fix this, or need any
> more info, don't hesitate to contact me.
>
> Regards...

