Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbRFJTnp>; Sun, 10 Jun 2001 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbRFJTnf>; Sun, 10 Jun 2001 15:43:35 -0400
Received: from temp20.astound.net ([24.219.123.215]:4356 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261645AbRFJTn2>; Sun, 10 Jun 2001 15:43:28 -0400
Date: Sun, 10 Jun 2001 12:43:44 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Stephen Mollett <molletts@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: No DMA with ATAPI devices on PDC20267
In-Reply-To: <01061020334400.00543@cantoris>
Message-ID: <Pine.LNX.4.10.10106101242560.3012-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Stephen Mollett wrote:

> Greetings,
> 
> When using ATAPI devices on a Promise Ultra100 (PDC20267), DMA is not 
> enabled. Is this a bug in the pdc202xx driver or a limitation of the chipset?
> 
> eg.
> With the drive attached to a VIA 82C686:
> hdb: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(25)
> 
> With the drive attached to an Ultra100:
> hde: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache
> 
> I have also tested this with a DVD-ROM and an LS-120 drive. Hard disks are 
> fine, however.
> 
> Regards,
> Stephen Mollett
> 

Stephen,

I can make it do DMA ATAPI, however I have to add the code that used the
second DMA engine space.

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

