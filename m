Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271350AbRHQUKA>; Fri, 17 Aug 2001 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRHQUJu>; Fri, 17 Aug 2001 16:09:50 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59894 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271559AbRHQUJg>; Fri, 17 Aug 2001 16:09:36 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 17 Aug 2001 14:09:43 -0600
To: "Mark H. Wood" <mwood@IUPUI.Edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 not NULLing deleted files?
Message-ID: <20010817140831.H17372@turbolinux.com>
Mail-Followup-To: "Mark H. Wood" <mwood@IUPUI.Edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010817020241.C32617@turbolinux.com> <Pine.LNX.4.33.0108171243410.392-100000@mhw.ULib.IUPUI.Edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108171243410.392-100000@mhw.ULib.IUPUI.Edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2001  12:55 -0500, Mark H. Wood wrote:
> Regarding the need to do more than just zero unwanted data, I note that
> there is a U.S. DOD MIL-SPEC (no, I do not know the number) which defines
> a sequence of patterns to be used for erasing magnetic media.

In the Usenix paper quoted earlier in this thread (I believe) it was
stated that the MIL-SPEC document was actually bogus.  REAL secure
deletion requirements were much more strict (something like 15 passes of
various random and non-random patterns vs. 7 passes of alternating all 0
and all 1 data), but the US government made it think that the MIL-SPEC
requirements were enough, so that naive users would follow it, still
leaving enough trace data on the disk for the government to retrieve it.

Still, even a single pass of zero writes is enough to prevent 99.9%
of attackers from getting the data back.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

