Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRA3RpQ>; Tue, 30 Jan 2001 12:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131075AbRA3RpH>; Tue, 30 Jan 2001 12:45:07 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:27600 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S130706AbRA3RpA>; Tue, 30 Jan 2001 12:45:00 -0500
Date: Tue, 30 Jan 2001 12:44:58 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <200101272101.WAA27234@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.21.0101301241250.11300-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, Rogier Wolff wrote:
[snip]
> I may have missed too much of the discussion, but I thought that the
> idea was that some people noted that their POST-code-cards don't
> really work all that well when Linux is running because Linux keeps on
> sending garbage to port 0x80. 
> 
> You seem to state that if you want POST codes, you should find a
> different port, modify the code, test the hell out of it, and then
> submit the patch.
> 
> That is NOT the right way to go about this: Port 0x80 is RESERVED for
> POST usage, that's why it's always free. If people want to use it for
> the original purpose then that is a pretty damn good reason to bump
> the non-intended users of that port somewhere else. 
> 
> Now, we've found that small delays are reasonably well generated with
> an "outb" to 0x80. So, indeed changing that to something else is going
> to be tricky. 

So how bad would it be to give these people a place to leave the value
that they want to have displayed, and have the delay code write *that*
instead of garbage?

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
