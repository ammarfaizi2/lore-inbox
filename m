Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293130AbSBWMmZ>; Sat, 23 Feb 2002 07:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSBWMmP>; Sat, 23 Feb 2002 07:42:15 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:4058 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S293130AbSBWMmM>; Sat, 23 Feb 2002 07:42:12 -0500
Date: Sat, 23 Feb 2002 07:42:10 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
To: "Dave Rattay [ITeX]" <Dave.Rattay@itexinc.com>
cc: <linux-kernel@vger.kernel.org>,
        ITeX Tech Support <techsupport@itexinc.com>
Subject: RE: Dlink DSL PCI Card
In-Reply-To: <E788BA1D236784409F3F7138F1EABFDDE4E2@iteusa-nt.itexinc.com>
Message-ID: <Pine.LNX.4.33.0202230732040.15938-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There oughta be a page somewhere on "How to Sell your Product in the Linux
Market".

On Fri, 22 Feb 2002, Dave Rattay [ITeX] wrote:
>    I definitely agree that our worlds do not match.  While I would hate
> to lose any customers there are some things that can not be avoided.
> There are many things to be taken into consideration when we make our
> drivers.  One the vast majority of our customers use Windows and
> therefore we must devote most of our time there.

Understood.

>                                                   Second when a new OS
> comes out from Microsoft (such as XP) we are given beta copies 6 months
> in advance so that our drivers hit the market along side the new OS
> release.  This just doesn't happen with Linux.

Sure it does.  It happens right here on LKML and some other lists.  You
can get early-release images of Linux 2.5 right now.  The distribution
builders won't pick up 2.5 for many months.

>                                                 I agree that this would
> be much simpler if the source code was released and we had "help" in
> driver development but as I said that just can't happen, end of story.
> Now as to specs for the board itself you can check with sales because I
> am not even sure what our policy is on that and I wish you luck in those
> regards.

Board spec.s are largely irrelevant.  It's *chip* spec.s that driver
writers need most.  There's no such thing as board drivers for Linux, but
there are a number of chipset drivers.  For example, under Windows there's
a separate driver for each company's NE2000 clone, but under Linux the ne
driver handles them all.  Board-level differences are usually dismissed as
"quirks", if they are significant at all.

(Stores need to understand this too.  A lot of sales have gone to one
rather than another because store B told me what chipset was used in a
board-level product, and store A would not.)

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Our lives are forever changed.  But *that* is exactly as it always was.

