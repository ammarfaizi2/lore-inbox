Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSHVSyQ>; Thu, 22 Aug 2002 14:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSHVSyQ>; Thu, 22 Aug 2002 14:54:16 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:46733 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S315491AbSHVSyP>; Thu, 22 Aug 2002 14:54:15 -0400
Subject: Re: ServerWorks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Gonzalo Servat <gonzalo@unixpac.com.au>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1030039087.3161.27.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10208220143440.11626-100000@master.linux-ide.org> 
	<1030017756.9866.74.camel@biker.pdb.fsc.net> 
	<1030039087.3161.27.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Aug 2002 20:58:08 +0200
Message-Id: <1030042689.9867.120.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-08-22 um 19.58 schrieb Alan Cox:

> > 2) The tested condition inb(dma_base+0x02)&1 is valid if the
> >    device doing the DMA reported an error status. Only if the
> >    device reports success is there an indication of the "4 byte shift".
> 
> True

This condition is easy to test, right? My patch tested for
   OK_STAT (GET_STAT(), DRIVE_READY, BAD_STAT)
Why not put that in the code?

Martin
-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





