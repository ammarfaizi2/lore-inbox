Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285130AbSAAV06>; Tue, 1 Jan 2002 16:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285589AbSAAV0t>; Tue, 1 Jan 2002 16:26:49 -0500
Received: from [64.169.83.2] ([64.169.83.2]:17156 "EHLO mail.get2chip.com")
	by vger.kernel.org with ESMTP id <S285130AbSAAV03>;
	Tue, 1 Jan 2002 16:26:29 -0500
Message-ID: <3C322981.22DB1336@get2chip.com>
Date: Tue, 01 Jan 2002 13:26:25 -0800
From: ccroswhite@get2chip.com
Reply-To: ccroswhite@get2chip.com
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: (forw) [gilbertd@treblig.org: Re: Dual athlon XP 1800 problems]]
Content-Type: multipart/mixed;
 boundary="------------5EC81ADBB0F20EB5CE3BB17C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5EC81ADBB0F20EB5CE3BB17C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------5EC81ADBB0F20EB5CE3BB17C
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Message-ID: <3C322663.88C901B1@get2chip.com>
Date: Tue, 01 Jan 2002 13:13:07 -0800
From: ccroswhite@get2chip.com
Reply-To: ccroswhite@get2chip.com
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
CC: linuix-kernel@vger.kernel.org
Subject: Re: (forw) [gilbertd@treblig.org: Re: Dual athlon XP 1800 problems]
In-Reply-To: <20020101152452.GC12799@gallifrey>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A point of clarification,  the computer will boot if the memory is less than or equal
to 512M RAM.    With this in mind, are there any other clues as to what could be
happening?

TIA,
Chris Croswhite

"Dr. David Alan Gilbert" wrote:

> Hi,
>   I sent this to the linux-kernel list, but forgot to CC you on it - so
> here it is.
>
> Dave
> ----- Forwarded message from "Dr. David Alan Gilbert" <gilbertd@treblig.org> -----
>
> Date: Tue, 1 Jan 2002 15:21:56 +0000
> To: linux-kernel@vger.kernel.org
> User-Agent: Mutt/1.3.24i
> From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
> Subject: Re: Dual athlon XP 1800 problems
>
> On Mon, Dec 31, 2001 at 06:12:16PM -0800, ccroswhite@get2chip.com wrote:
>
> > I am having problems with dual athlons and more than 512M RAM.  I have
> > compiled several kernels with either ATHLON, 1386, i686 support with the
> > same affect, I get a kernel that will fail to boot properly.  Sometimes
> > I get a kernel panic that outs to kdb, sometimes I get a freeze, and
> > sometimes I get failed to mount root partition, but never has this
> > kernel successfully come up.  I am quite certain it is not the memory or
> > the system ( I can get windblows 2k to run successfully with upto 3.5G
> > RAM).
> >
> > Here is the configuration:
> >
> > Tyan S2460
> > Dual Athlon XP 1800
> > 512M DDR DIMMS (also used 128, 256, and 1G)
> > Western Digital 20G Drive
>
> I have a similar system running fine.  It has a Tyan S2460, a pair of
> Athlon MP 1800s, 512M (2x256) and a pair of IBM 60G drives.
>
> I haven't seen any signs of kernel instability. However:
>
>   1) When I first got it I had the BIOS do some very odd things; at one
>   point the CMOS got cleared and then everything worked from there on
>   in.  So a good CMOS clean could be in order. I had to use the Debian
>   safe boot set prior to this.
>
>   2) Are you saying the problem only affects greater than 512M ? I only
>   have the 512M so don't know - but it is probably worth booting with
>   mem=512M as an option with more RAM in and see if it is stable.
>
>   3) The guys who put the machine together had lots of problems getting
>   it stable; the type of RAM they used was critical; it was stable
>   enough for them to boot NT and get it through a lot of tests before
>   they hit problems.
>
>   4) COOL IT - these things generate tons of heat (mine run at 75degC
>   normal operation). I have it in a big Supermicro 760 case with damn
>   big fans on.
>
>   5) I bought Athlon MPs because I didn't want the hastle of knowing
>   whether XPs would work or not.  Now sure, it could be AMD just trying
>   to squeeze some more money out of us; but it is entirely possible that
>    a) the chips could be different,  b) that the critical timing path in
>   the device could be in the cache snooping/consistency stuff (that
>   stuff is probably pretty hairy!).  I mean there must be a reason why
>   it took them a month and a half longer to release the Athlon MP 1.9GHz
>   than the XP 1.9GHz.
>
>   6) I'm currently on 2.4.17 and have used most of the later 2.4.1x's on
>   it.
>
> Dave
>  ---------------- Have a happy GNU millennium! ----------------------
> / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
>
> ----- End forwarded message -----
>  ---------------- Have a happy GNU millennium! ----------------------
> / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/


--------------5EC81ADBB0F20EB5CE3BB17C--

