Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131600AbRC0V05>; Tue, 27 Mar 2001 16:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131604AbRC0V0s>; Tue, 27 Mar 2001 16:26:48 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13585
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131600AbRC0V0a>; Tue, 27 Mar 2001 16:26:30 -0500
Date: Tue, 27 Mar 2001 13:25:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Uncle George <gatgul@voicenet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: slow latencies on IDE disk drives( controller? )
In-Reply-To: <3AC102EF.A86D484E@voicenet.com>
Message-ID: <Pine.LNX.4.10.10103271322260.17821-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Uncle George wrote:

> The fix is a lot simpler. It has to be placed in release notes that the
> generic ide can cause the sound device to distort the sound stream. 
> Would that be a fair statement ?

GAT,

Not sure how to comment, but did enabling the chipset code make it work?
Second your case is one where the generic code can not find DMA space,
therefore you are forced into PIO, and that will place the system under an
extra load to potential produce your problem.

So the question back is does the chipset code work?
If so then a generic blurb about sound would be valid in at least two
cases and that make a good case for inclusion.

> Andre Hedrick wrote:
> > 
> >
> > 
> > This is your fix....
> > 
> > Andre Hedrick
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

