Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129766AbRB0THG>; Tue, 27 Feb 2001 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRB0TG5>; Tue, 27 Feb 2001 14:06:57 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:54791
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129766AbRB0TGm>; Tue, 27 Feb 2001 14:06:42 -0500
Date: Tue, 27 Feb 2001 11:05:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Dresser <mdresser@windsormachine.com>
cc: Camm Maguire <camm@enhanced.com>, Khalid Aziz <khalid@fc.hp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <3A9BF340.B8DD9F56@windsormachine.com>
Message-ID: <Pine.LNX.4.10.10102271103360.32662-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Maybe you should check to find out which devices are supported and which
are not.  HP messed up a good device class by doing something like a
modified TR-4 or TR-5; however, it may be a QIC157 that is better
supported under emulation.

On Tue, 27 Feb 2001, Mike Dresser wrote:

> Camm Maguire wrote:
> 
> > Greetings!  You are certainly right here, at least in part.  The ide
> > patches for 2.2 definitely impair tape operation on these boxes.
> > There was a crude workaround suggested on this list to use the
> > ide-scsi driver -- this basically worked, but gave *many* error
> > messages in the kernel log, and was significantly less reliable than
> > stock 2.2.18.  I'm still using ide-scsi out of inertia, but I suspect
> > that ide-tape might be just fine with stock 2.2.18 too.  And when I
> > saw some support for the ALI chipset, the decision was clear to drop
> > the latest ide stuff.
> >
> > This has been the situation for some time.  Is this going to be
> > resolved soon?
> 
> Wish i knew, I'm praying that 2.2.19 hasn't/doesn't implement the ide patches like 2.4.x did.  If so, and a major problem is found in
> 2.2.18, then I have to maintain another machine running 2.2.18 to restore tapes.  Also means i'd have to stop using taper or dump,
> and stick to tar only, as both want to read the tape back in at some point.
> 
> Mike
> 
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

