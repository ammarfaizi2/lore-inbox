Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286285AbSAAPWQ>; Tue, 1 Jan 2002 10:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSAAPWG>; Tue, 1 Jan 2002 10:22:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53005 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S281932AbSAAPV5>;
	Tue, 1 Jan 2002 10:21:57 -0500
Date: Tue, 1 Jan 2002 15:21:56 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual athlon XP 1800 problems
Message-ID: <20020101152156.GB12799@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.17 (i686)
X-Uptime: 15:09:18 up 4 days, 12:34,  9 users,  load average: 2.00, 2.01, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 06:12:16PM -0800, ccroswhite@get2chip.com wrote:

> I am having problems with dual athlons and more than 512M RAM.  I have
> compiled several kernels with either ATHLON, 1386, i686 support with the
> same affect, I get a kernel that will fail to boot properly.  Sometimes
> I get a kernel panic that outs to kdb, sometimes I get a freeze, and
> sometimes I get failed to mount root partition, but never has this
> kernel successfully come up.  I am quite certain it is not the memory or
> the system ( I can get windblows 2k to run successfully with upto 3.5G
> RAM).
> 
> Here is the configuration:
> 
> Tyan S2460
> Dual Athlon XP 1800
> 512M DDR DIMMS (also used 128, 256, and 1G)
> Western Digital 20G Drive

I have a similar system running fine.  It has a Tyan S2460, a pair of
Athlon MP 1800s, 512M (2x256) and a pair of IBM 60G drives.

I haven't seen any signs of kernel instability. However:

  1) When I first got it I had the BIOS do some very odd things; at one
  point the CMOS got cleared and then everything worked from there on
  in.  So a good CMOS clean could be in order. I had to use the Debian
  safe boot set prior to this.

  2) Are you saying the problem only affects greater than 512M ? I only
  have the 512M so don't know - but it is probably worth booting with
  mem=512M as an option with more RAM in and see if it is stable.

  3) The guys who put the machine together had lots of problems getting
  it stable; the type of RAM they used was critical; it was stable
  enough for them to boot NT and get it through a lot of tests before
  they hit problems.

  4) COOL IT - these things generate tons of heat (mine run at 75degC
  normal operation). I have it in a big Supermicro 760 case with damn
  big fans on.

  5) I bought Athlon MPs because I didn't want the hastle of knowing
  whether XPs would work or not.  Now sure, it could be AMD just trying
  to squeeze some more money out of us; but it is entirely possible that
   a) the chips could be different,  b) that the critical timing path in
  the device could be in the cache snooping/consistency stuff (that
  stuff is probably pretty hairy!).  I mean there must be a reason why
  it took them a month and a half longer to release the Athlon MP 1.9GHz
  than the XP 1.9GHz.

  6) I'm currently on 2.4.17 and have used most of the later 2.4.1x's on
  it.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
