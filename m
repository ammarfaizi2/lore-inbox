Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbSI2T4L>; Sun, 29 Sep 2002 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261777AbSI2T4L>; Sun, 29 Sep 2002 15:56:11 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:1527 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261776AbSI2T4K>; Sun, 29 Sep 2002 15:56:10 -0400
Subject: Re: DMA audio-CD extraction/writing and ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ignacy Gawedzki <ig@zenon.mine.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020929215150.A2049@zenon.ouaou.org>
References: <20020929215150.A2049@zenon.ouaou.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 21:07:59 +0100
Message-Id: <1033330079.14029.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 20:51, Ignacy Gawedzki wrote:
> I would like to know if there is a particular reason that forbids audio
> extraction/writing from/of CDs using UDMA (as opposed to PIO) when using
> the ide-scsi driver.

There isn't - other than adding the support for working fully in DMA
mode to the ide-scsi drivers themselves.


