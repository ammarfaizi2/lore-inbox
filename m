Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRB0RdW>; Tue, 27 Feb 2001 12:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRB0RdC>; Tue, 27 Feb 2001 12:33:02 -0500
Received: from windsormachine.com ([206.48.122.28]:45841 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129667AbRB0Rcz>; Tue, 27 Feb 2001 12:32:55 -0500
Message-ID: <3A9BE4C1.1868F020@windsormachine.com>
Date: Tue, 27 Feb 2001 12:32:49 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
CC: Khalid Aziz <khalid@fc.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ASC/ASCQ of 0x20/0x00 means "Invalid command operation code". So the
> > drive is rejecting a command sent to it by the driver. If the other
> > drive that is working is identical to seemingly non-working one, maybe
> > this drive is going bad.
> >
>
> Thanks for the error identification.  The other drive is of a
> *different* model.  This drive showed this behavior from the day I
> bought it.  The drive could be going bad, but I doubt it.  Is it
> possible that this manufacturer (Conner) has some peculiar
> implementation of the spec?  I recall reading on this list sometime
> back of similar workarounds to unusual drives.

When you go to 2.4.x, you'll likely run into the problem of your HP 14Gb not able to restore anymore.  Same as if you apply the
linux-ide patches to 2.2.x

Mike Dresser
sysadmin
Windsor Machine & Stamping

