Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSHWDIZ>; Thu, 22 Aug 2002 23:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSHWDIY>; Thu, 22 Aug 2002 23:08:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33288
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318139AbSHWDIY>; Thu, 22 Aug 2002 23:08:24 -0400
Date: Thu, 22 Aug 2002 20:11:12 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ulf-Andre Gramstad <j1@gramstad.org>
cc: linux-kernel@vger.kernel.org
Subject: RE: hpt374 / BUG();
In-Reply-To: <IOELJIHGBNLBJNBMHABBOEACCDAA.j1@gramstad.org>
Message-ID: <Pine.LNX.4.10.10208222009540.13077-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just got a reply from HighPoint and they claim they do not have support
for a 66MHz base PLL for hpt374/hpt372.

So that make is more interesting.

On Thu, 22 Aug 2002, Ulf-Andre Gramstad wrote:

> > You have a system where it actually have the PLL already set and in
> > 66-clock base?  You are the first person to ever hit this BUG().
> > I will need to work with HighPoint to finish the timing table.
> >
> > If you would have several device of various max transfer rate limits you
> > could attach without the driver being built it, it would give me a few
> > data point to verify if the table I have started is even close.
> 
> My HPT374 controller works with the new 2.4.20-pre2-ac6 patch, running at
> ATA-66.
> /proc/ide/hpt366 shows only primary and secondary channel, so I guess thats
> why the hard drives on channel 3 and 4 is not working?
> 
> 
> -
> UAG
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

