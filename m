Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262474AbTCIIYq>; Sun, 9 Mar 2003 03:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262476AbTCIIYq>; Sun, 9 Mar 2003 03:24:46 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:28420
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262474AbTCIIYp>; Sun, 9 Mar 2003 03:24:45 -0500
Date: Sun, 9 Mar 2003 00:17:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andries Brouwer <aebr@win.tue.nl>, Bill Davidsen <davidsen@tmr.com>,
       Harald.Schaefer@gls-germany.com, Thomas.Mieslinger@gls-germany.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, aeb@cwi.nl
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
In-Reply-To: <1047173438.26884.60.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10303090012290.14535-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unless it is native and legacy addressed on the mainboard via the system
bios, Linux can not query the proper geometry.

I have always argued to defautl to LBA when beyond 8.4GB, but people want
to use the orphan sectors, why ... ??  Best guess is not wanting to leave
used sectors.  The was a holy war some time back and I gave up on the
issue.  CHS is dead, but it lives as a Zombie until there are only drives
which support 48-bit feature sets in existance.  Then the problem goes
away.


On 9 Mar 2003, Alan Cox wrote:

> On Sat, 2003-03-08 at 23:23, Andries Brouwer wrote:
> > Really strange values, as if someone wanted to force a H=255.
> > Must read current 2.4 source some time. What does hdparm say
> > under 2.2.22?
> 
> What I'm trying to work out is why its not honouring PTBL
> values in his case apparently. I don't care too much what shape
> the disk is but I do care that if the partition table says
> its this interpretation we use it
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

