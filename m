Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRB0ScT>; Tue, 27 Feb 2001 13:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRB0ScJ>; Tue, 27 Feb 2001 13:32:09 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:7675 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129740AbRB0ScA>; Tue, 27 Feb 2001 13:32:00 -0500
To: Mike Dresser <mdresser@windsormachine.com>
Cc: Khalid Aziz <khalid@fc.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BE4C1.1868F020@windsormachine.com>
From: Camm Maguire <camm@enhanced.com>
Date: 27 Feb 2001 13:31:35 -0500
In-Reply-To: Mike Dresser's message of "Tue, 27 Feb 2001 12:32:49 -0500"
Message-ID: <54u25gvuyg.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!  You are certainly right here, at least in part.  The ide
patches for 2.2 definitely impair tape operation on these boxes.
There was a crude workaround suggested on this list to use the
ide-scsi driver -- this basically worked, but gave *many* error
messages in the kernel log, and was significantly less reliable than
stock 2.2.18.  I'm still using ide-scsi out of inertia, but I suspect
that ide-tape might be just fine with stock 2.2.18 too.  And when I
saw some support for the ALI chipset, the decision was clear to drop
the latest ide stuff.

This has been the situation for some time.  Is this going to be
resolved soon?

Mike Dresser <mdresser@windsormachine.com> writes:

> > > ASC/ASCQ of 0x20/0x00 means "Invalid command operation code". So the
> > > drive is rejecting a command sent to it by the driver. If the other
> > > drive that is working is identical to seemingly non-working one, maybe
> > > this drive is going bad.
> > >
> >
> > Thanks for the error identification.  The other drive is of a
> > *different* model.  This drive showed this behavior from the day I
> > bought it.  The drive could be going bad, but I doubt it.  Is it
> > possible that this manufacturer (Conner) has some peculiar
> > implementation of the spec?  I recall reading on this list sometime
> > back of similar workarounds to unusual drives.
> 
> When you go to 2.4.x, you'll likely run into the problem of your HP 14Gb not able to restore anymore.  Same as if you apply the
> linux-ide patches to 2.2.x
> 
> Mike Dresser
> sysadmin
> Windsor Machine & Stamping
> 
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
