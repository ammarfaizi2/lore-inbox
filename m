Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbTIMAd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTIMAd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:33:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7602 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261975AbTIMAdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:33:55 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Steffl <steffl@bigfoot.com>
Subject: Re: intel D865PERL and DMA for disks (IDE)?
Date: Sat, 13 Sep 2003 02:36:14 +0200
User-Agent: KMail/1.5
References: <3F62628B.5060805@bigfoot.com>
In-Reply-To: <3F62628B.5060805@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309130236.14814.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 of September 2003 02:19, Erik Steffl wrote:
>    I am trying to set the DMA for ide disks but get the following error:
>
>    jojda:/home/erik# hdparm -d 1 /dev/hda
>
> /dev/hda:
>   setting using_dma to 1 (on)
>   HDIO_SET_DMA failed: Operation not permitted
>   using_dma    =  0 (off)
>
>    is it because it's not supported on given chipset or is there
> something I can do?
>
>    debian unstable
>    2.4.21-ac4 (+ libata5 patches from Jeff Garzik)
>    Intel D865PERL motherboard
>
>    there are only two kernel options that I can see are relevant to
> chipset I use:
>
> CONFIG_BLK_DEV_PIIX=m
> CONFIG_SCSI_ATA_PIIX=y

You should use CONFIG_BLK_DEV_PIIX=y
or load piix module (may not be reliable).

>    TIA
>
> 	erik

