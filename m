Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTFPTyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTFPTyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:54:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56032 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263915AbTFPTyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:54:37 -0400
Date: Mon, 16 Jun 2003 22:08:07 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Hadmut Danisch <hadmut@danisch.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA VT8366 and IDE/DMA?
In-Reply-To: <20030616194924.GA15602@danisch.de>
Message-ID: <Pine.SOL.4.30.0306162204060.6968-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jun 2003, Hadmut Danisch wrote:

> Hi,
>
> I have a K7 mainboard with VT8366 chipset, but I can't

VT8366 (KT266) is a north bridge and has nothing to do with IDE.

> turn IDE DMA on:
>
> atlantis# hdparm -d1 /dev/hda
>
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)

Compile kernel with VIA IDE support:

CONFIG_BLK_DEV_VIA82CXXX=y

> Writing to /proc/ide/ide0/hda/settings has no effect.
>
>
> Can anyone give me a hint how to turn DMA on?
>
> regards
> Hadmut

Regards,
--
Bartlomiej

