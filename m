Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRB0TlK>; Tue, 27 Feb 2001 14:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbRB0TlB>; Tue, 27 Feb 2001 14:41:01 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:4092 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129283AbRB0Tkq>; Tue, 27 Feb 2001 14:40:46 -0500
To: Andre Hedrick <andre@linux-ide.org>
Cc: Mike Dresser <mdresser@windsormachine.com>, Khalid Aziz <khalid@fc.hp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <Pine.LNX.4.10.10102271103360.32662-100000@master.linux-ide.org>
From: Camm Maguire <camm@enhanced.com>
Date: 27 Feb 2001 14:40:10 -0500
In-Reply-To: Andre Hedrick's message of "Tue, 27 Feb 2001 11:05:52 -0800 (PST)"
Message-ID: <54lmqrsyn9.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre, and thanks for this note (and of course, your work on
ide!).  

1) I assume you are referring to the HP colorado 14G, and not the
   Conner (Seagate) TR-4 8G mentioned in my original note.
2) If so, what could be wrong with the Conner?
3) Where can I find what is supported and what not?  The Conner is a
   standard TR-4, and I thought that was supported.
4) Can one signal the driver to try qic157 emulation?
5) Separately, Since the Colorado 14G seems so popular, is there any
   chance of getting what it is that works currently into the new ide
   stuff? After all, it *does* work at present with stock 2.2.x.

Thanks again for all your hard work!

Andre Hedrick <andre@linux-ide.org> writes:

> Maybe you should check to find out which devices are supported and which
> are not.  HP messed up a good device class by doing something like a
> modified TR-4 or TR-5; however, it may be a QIC157 that is better
> supported under emulation.
> 
> On Tue, 27 Feb 2001, Mike Dresser wrote:
> 
> > Camm Maguire wrote:
> > 
> > > Greetings!  You are certainly right here, at least in part.  The ide
> > > patches for 2.2 definitely impair tape operation on these boxes.
> > > There was a crude workaround suggested on this list to use the
> > > ide-scsi driver -- this basically worked, but gave *many* error
> > > messages in the kernel log, and was significantly less reliable than
> > > stock 2.2.18.  I'm still using ide-scsi out of inertia, but I suspect
> > > that ide-tape might be just fine with stock 2.2.18 too.  And when I
> > > saw some support for the ALI chipset, the decision was clear to drop
> > > the latest ide stuff.
> > >
> > > This has been the situation for some time.  Is this going to be
> > > resolved soon?
> > 
> > Wish i knew, I'm praying that 2.2.19 hasn't/doesn't implement the ide patches like 2.4.x did.  If so, and a major problem is found in
> > 2.2.18, then I have to maintain another machine running 2.2.18 to restore tapes.  Also means i'd have to stop using taper or dump,
> > and stick to tar only, as both want to read the tape back in at some point.
> > 
> > Mike
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com
> 
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
