Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUAYUqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUAYUqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:46:35 -0500
Received: from intra.cyclades.com ([64.186.161.6]:19168 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265269AbUAYUqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:46:33 -0500
Date: Sun, 25 Jan 2004 18:36:15 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Joe Schmo <joe619017@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with IDE CF
In-Reply-To: <20040122185646.93559.qmail@web20723.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58L.0401251834410.1311@logos.cnet>
References: <20040122185646.93559.qmail@web20723.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jan 2004, Joe Schmo wrote:

> Hi,
> We recently encountered a problem very similar to an
> old post in majordomo forum. We boot up a linux image
> written on a RiData 128mb CF card on IDE interface
> (hda), the kernel dumps these error messages on the
> screen:
>
> hda: CF-ATA, ATA Disk drive
> ide: Assuming 33 MHz system bus speed for PIO modes,
> override with idebus=xx
> hda: set_drive_speed_status status=0x51 { DriveReady
> SeekComplete Error }
> hda: set_drive_speed_status error=0x04 { Drive Status
> Error }
> ...
> hda: dma_intr: status=0x51 { DriveReady SeekComplete
> Error }
> hda: dma_intr: error=0x04 { Drive Status Error }
> ...
> hda: DMA disabled
> ...
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt

Turn off DMA. SanDisk's SDCFB are known to have problems with DMA.
