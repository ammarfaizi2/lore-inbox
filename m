Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130109AbRBHGfl>; Thu, 8 Feb 2001 01:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129959AbRBHGfb>; Thu, 8 Feb 2001 01:35:31 -0500
Received: from [203.36.158.121] ([203.36.158.121]:50833 "EHLO
	piro.kabuki.eyep.net") by vger.kernel.org with ESMTP
	id <S129558AbRBHGf2>; Thu, 8 Feb 2001 01:35:28 -0500
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
From: Daniel Stone <daniel@kabuki.eyep.net>
To: Chris Mason <mason@suse.com>
Cc: David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
In-Reply-To: <479040000.981564496@tiny>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 08 Feb 2001 17:34:44 +1100
Mime-Version: 1.0
Message-Id: <E14QkfM-0004EL-00@piro.kabuki.eyep.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Feb 2001 11:48:16 -0500, Chris Mason wrote:
> 
> 
> On Wednesday, February 07, 2001 08:38:54 AM -0800 David Rees
> <dbr@spoke.nols.com> wrote:
> 
> > On Wed, Feb 07, 2001 at 10:47:09AM -0500, Chris Mason wrote:
> >> 
> >> Ok, how about we list the known bugs:
> >> 
> >> zeros in log files, apparently only between bytes 2048 and 4096 (not
> >> reproduced yet).
> > 
> > Could this bug be related to the reported corruption that people with
> > new VIA chipsets have been also reporting on ext2?  It seems similar
> > because of the location of the corruption:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=98147483712620&w=2
> > 
> > Anyway, it can't hurt to ask the bug reported if they're using a
> > newer VIA chipset and see if they will upgrade their BIOS which seems
> > to fix the problem.
> 
> I'd love to blame this on VIA problems, but people are seeing it on other
> chipsets too ;-)  
> 
> People who report this aren't seeing general corruption, just zeros in
> files of specific sizes.  So, it really should be a reiserfs bug.

I run Reiser on all but /boot, and it seems to enjoy corrupting my
mbox'es randomly.
Using the old-style Reiser FS format, 2.4.2-pre1, Evolution, on a CMD640
chipset with the fixes enabled.
This also occurs in some log files, but I put it down to syslogd
crashing or something.

d

-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
