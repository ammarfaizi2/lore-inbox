Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130224AbRB1PfM>; Wed, 28 Feb 2001 10:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbRB1PfD>; Wed, 28 Feb 2001 10:35:03 -0500
Received: from windsormachine.com ([206.48.122.28]:51722 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S130224AbRB1Peu>; Wed, 28 Feb 2001 10:34:50 -0500
Message-ID: <3A9D1A95.51CE4AEC@windsormachine.com>
Date: Wed, 28 Feb 2001 10:34:45 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
CC: Khalid Aziz <khalid@fc.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BC8ED.698DCA2C@fc.hp.com> <54vgpvq4y1.fsf@intech19.enhanced.com> <3A9BEF68.72EEF0E8@fc.hp.com> <54g0gyhlwk.fsf@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a problem with tar and taper, with blocking, so what i do is backup a 128k file of emptiness, to guarantee that the last
block of the real backup fit.

> Restoring a tape typically then says 'gunzip: unexpected end of
> file'.  My guess was that the last fractional block of 32k wasn't
> flushed to the drive.  Of course, if I'm having media troubles
> indicated by the first error above, then something else could be
> happening, I suppose.  But does erroneous block flushing in the driver
> sound like a possibility?

Mike Dresser

