Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271737AbRHQWGz>; Fri, 17 Aug 2001 18:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271733AbRHQWGP>; Fri, 17 Aug 2001 18:06:15 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:9832 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S271728AbRHQWGH>; Fri, 17 Aug 2001 18:06:07 -0400
Date: Fri, 17 Aug 2001 17:05:54 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200108172205.RAA28109@tomcat.admin.navo.hpc.mil>
To: adilger@turbolabs.com, "Mark H. Wood" <mwood@IUPUI.Edu>
Subject: Re: ext2 not NULLing deleted files?
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
> 
> On Aug 17, 2001  12:55 -0500, Mark H. Wood wrote:
> > Regarding the need to do more than just zero unwanted data, I note that
> > there is a U.S. DOD MIL-SPEC (no, I do not know the number) which defines
> > a sequence of patterns to be used for erasing magnetic media.
> 
> In the Usenix paper quoted earlier in this thread (I believe) it was
> stated that the MIL-SPEC document was actually bogus.  REAL secure
> deletion requirements were much more strict (something like 15 passes of
> various random and non-random patterns vs. 7 passes of alternating all 0
> and all 1 data), but the US government made it think that the MIL-SPEC
> requirements were enough, so that naive users would follow it, still
> leaving enough trace data on the disk for the government to retrieve it.

Actually, it does exist as part of the rainbow series under object reuse.
I have a copy of the current renewed memo draft + addendum (this year) for
purging.

No change.

> Still, even a single pass of zero writes is enough to prevent 99.9%
> of attackers from getting the data back.

Absolutely - the only people that can still retrieve data are the data
recovery companies out there (even fire doesn't fully erase the data unless
above 2-3,000 degrees). Tunneling magnetic microscopes are amazing at
data retrieval. Polishing off the top layer even allows reading some data
recorded many times earlier, though the newer thin film surfaces make this
harder.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
