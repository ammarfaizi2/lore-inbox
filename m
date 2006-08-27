Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWH0SQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWH0SQd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWH0SQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:16:33 -0400
Received: from compunauta.com ([69.36.170.169]:54227 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S932227AbWH0SQd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:16:33 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't enable DMA over ATA on Intel Chipset 2.6.16
Date: Sun, 27 Aug 2006 13:16:21 -0500
User-Agent: KMail/1.9.1
References: <200608271239.32507.gustavo@compunauta.com> <44F1DD09.6030300@garzik.org>
In-Reply-To: <44F1DD09.6030300@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608271316.22992.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Domingo, 27 de Agosto de 2006 12:57, escribió:
> Gustavo Guillermo Pérez wrote:
> > Hello list, I can't enable DMA on this chipset, even forcing with the
> > options provided in kconfig.
>
> Google around for combined mode, and/or set your BIOS to something other
> than legacy IDE mode.
already tryed with BIOS legacy
/dev/hdc:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 69 (UltraDMA mode5)
 using_dma    =  0 (off)
root@rp-1 /home/gus # hdparm -d1 -X udma1 /dev/hdc

/dev/hdc:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 65 (UltraDMA mode1)
 using_dma    =  0 (off)
root@rp-1 /home/gus # hdparm -d1 -X udma2 /dev/hdc

/dev/hdc:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 66 (UltraDMA mode2)
 using_dma    =  0 (off)
root@rp-1 /home/gus # hdparm -d1 -X udma3 /dev/hdc

/dev/hdc:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 67 (UltraDMA mode3)
 using_dma    =  0 (off)
root@rp-1 /home/gus # hdparm -d1 -X udma4 /dev/hdc

/dev/hdc:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 68 (UltraDMA mode4)
 using_dma    =  0 (off)
root@rp-1 /home/gus # hdparm -d1 -X udma5 /dev/hdc

/dev/hdc:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 69 (UltraDMA mode5)
 using_dma    =  0 (off)


-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
