Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSHVRxW>; Thu, 22 Aug 2002 13:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHVRxV>; Thu, 22 Aug 2002 13:53:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54515 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315278AbSHVRxV>; Thu, 22 Aug 2002 13:53:21 -0400
Subject: Re: ServerWorks OSB4 in impossible state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Gonzalo Servat <gonzalo@unixpac.com.au>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1030017756.9866.74.camel@biker.pdb.fsc.net>
References: <Pine.LNX.4.10.10208220143440.11626-100000@master.linux-ide.org> 
	<1030017756.9866.74.camel@biker.pdb.fsc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 18:58:07 +0100
Message-Id: <1030039087.3161.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 13:02, Martin Wilck wrote:
> 1) The "4 byte shift" issue does not affect the CSB5 series.

True (not a rule the -ac tree knows about right now) but one that the
next tree will subject to time constraints.

> 2) The tested condition inb(dma_base+0x02)&1 is valid if the
>    device doing the DMA reported an error status. Only if the
>    device reports success is there an indication of the "4 byte shift".

True

> 3) The "4 byte shift" problem matters not for read-only devices like
>    CD-ROMS; at least it is no reason to stall the computer if it occurs
>    because data corruption is not an issue.

True (-ac knows about this)


