Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284357AbRLCIve>; Mon, 3 Dec 2001 03:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284477AbRLCIui>; Mon, 3 Dec 2001 03:50:38 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:36773
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284581AbRLCB2L>; Sun, 2 Dec 2001 20:28:11 -0500
Date: Sun, 2 Dec 2001 20:19:46 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011202201946.A7662@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Dec 03, 2001 at 12:06:12PM +1100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> Linus, the time has come to convert the 2.5 kernel to kbuild 2.5.  I
> want to do this in separate steps to make it easier for architectures
> that have not been converted yet.
> 
> 2.5.1           Semi-stable kernel, after bio is working.
> 
> 2.5.2-pre1      Add the kbuild 2.5 code, still using Makefile-2.5.
>                 i386, sparc, sparc64 can use either kbuild 2.4 or 2.5,
>                 2.5 is recommended.
>                 ia64 can only use kbuild 2.5.
>                 Other architectures continue to use kbuild 2.4.
>                 Wait 24 hours for any major problems then -
> 
> 2.5.2-pre2      Remove kbuild 2.4 code, rename Makefile-2.5 to Makefile.
>                 i386, ia64, sparc, sparc64 can compile using kbuild 2.5.
>                 Other architectures cannot compile until they convert
>                 to kbuild 2.5.  The kbuild group can help with the
>                 conversion but without access to a machine we cannot
>                 test other architectures.  Until the other archs have
>                 been converted, they can stay on 2.5.2-pre1.
> 
> Doing the change in two steps provides a platform where both kbuild 2.4
> and 2.5 work.  This allows other architectures to parallel test the old
> and new kbuild during their conversion, I found that ability was very
> useful during conversion.
> 
> The CML1 to CML2 conversion comes later, either in 2.5.3 or 2.5.4.
> 
> Linus, is this acceptable?

The schedule I heard from Linus at the kernel summit was that both changes 
were to go in between 2.5.1 and 2.5.2.   I would prefer sooner than later 
because I'm *really* *tired* of maintaining a parallel rulebase.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A ``decay in the social contract'' is detectable; there is a growing
feeling, particularly among middle-income taxpayers, that they are not
getting back, from society and government, their money's worth for
taxes paid. The tendency is for taxpayers to try to take more control
of their finances ..
	-- IRS Strategic Plan, (May 1984)
