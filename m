Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTA1Gqr>; Tue, 28 Jan 2003 01:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbTA1Gqr>; Tue, 28 Jan 2003 01:46:47 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22283
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264877AbTA1Gqq>; Tue, 28 Jan 2003 01:46:46 -0500
Date: Mon, 27 Jan 2003 22:37:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update PnP IDE (2/6)
In-Reply-To: <Pine.LNX.3.96.1030127170934.27928I-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.10.10301272224420.9272-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill,

Can you reproduce or validate my paranoia of the ever increasing channel
index?



On Mon, 27 Jan 2003, Bill Davidsen wrote:

> On Sat, 25 Jan 2003, Andre Hedrick wrote:
> 
> > 
> > 
> > "ide_unregister" is only called if you are physically removing the
> > controller.  If PNP is going to permit physical removal when the OS is
> > HOT, it may be justified.  This can make a "hole" in the rest of the
> > driver an generate an OOPS.  IDE-CS has alway insured the ordering was
> > last.
> > 
> > I need to thinks some more about it first.
> 
> When I have multiple PCMCIA cards with CompactFlash cards mounted, could
> this result in a hole if I umount and remove them in the wrong order? I
> haven't gotten it working with 2.5, but I do mount several with 2.4, and
> presumably will with 2.5 when I figure it out.
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 

Andre Hedrick
LAD Storage Consulting Group

