Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTKXPE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTKXPE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:04:26 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47853 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263734AbTKXPEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:04:25 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ulrich Wiederhold <wubuwei@gmx.net>
Subject: Re: DMA and 2.6.0-test10 with nForce chipset
Date: Mon, 24 Nov 2003 16:05:28 +0100
User-Agent: KMail/1.5.4
References: <20031124143945.GB1007@sky.net>
In-Reply-To: <20031124143945.GB1007@sky.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311241605.28340.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You should compile driver for your IDE chipset
(CONFIG_BLK_DEV_AMD74XX=y).

--bart

On Monday 24 of November 2003 15:39, Ulrich Wiederhold wrote:
> Hello,
> I am using 2.6.0-test10 on a Gigabyte GA-7N400-L1 motherboard with the
> nForce Ultra 400 chipset and I can't enable DMA for my ide-disk.
> root@home:/home# hdparm -d 1 /dev/hda
>
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)

...

> # CONFIG_BLK_DEV_AMD74XX is not set

