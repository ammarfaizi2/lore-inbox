Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbQLEIdG>; Tue, 5 Dec 2000 03:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbQLEIcz>; Tue, 5 Dec 2000 03:32:55 -0500
Received: from mgw-x3.nokia.com ([131.228.20.26]:35782 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S130159AbQLEIco> convert rfc822-to-8bit;
	Tue, 5 Dec 2000 03:32:44 -0500
Message-ID: <9524EA4E18D6D2119FEA0008C7C5A006BE4A78@lneis01nok>
From: Peter.Ronnquist@nokia.com
To: peter@cadcamlab.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: shared memory, mmap not recommended?
Date: Tue, 5 Dec 2000 10:02:13 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   [Linus]
> > > (otherwise I'll just end up disabling shared mmap - I 
> doubt anybody
> > > really uses it anyway, but it would be more polite to just support
> > > it).
> 
> [Peter Rönnquist]
> > I was thinking about using mmap for shared mememory in my program,
> > but now I am reconsidering.  Is the System V or Posix mechanism for
> > shared memory a better(it will be supported in 2.4) choice?
> 
> [Peter Samuelson]
> Linus was talking about shared mmap on a file in an smbfs filesystem.
> Rather different from what you are talking about.  For regular shared
> memory, shared mmap should be OK if you actually need backing store
> (i.e. the state you are sharing is persistent).  Often this is not the
> case, in which case POSIX shm might be best.
> 

I see, thanks a lot for the clarification.

BR
Peter Rönnquist
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
