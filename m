Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRAWKXc>; Tue, 23 Jan 2001 05:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAWKXX>; Tue, 23 Jan 2001 05:23:23 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:19837 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129725AbRAWKXN>; Tue, 23 Jan 2001 05:23:13 -0500
Date: Tue, 23 Jan 2001 12:22:44 +0200 (EET)
From: Heikki Lindholm <holindho@mail.niksula.cs.hut.fi>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Trever Adams <vichu@digitalme.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <Pine.LNX.4.32.0101230026490.7610-100000@asdf.capslock.lan>
Message-ID: <Pine.GSO.4.20.0101231211360.14550-100000@famine.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Mike A. Harris wrote:

> On Mon, 15 Jan 2001, Trever Adams wrote:
> 
> >I had a similar experience.  All I can say is windows 98
> >and ME seem to have it out for Linux drives running late
> >2.3.x and 2.4.0 test and release.  I had windows completely
> >fry my Linux drive and I lost everything.  I had some old
> >backups and was able to restore at least the majority of
> >older stuff.
> >
> >Sorry and good luck.
> 
> I don't see how Windows 9x can be at fault in any way shape or
> form, if you can boot between 2.2.x kernel and 9x no problem, but
> lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
> everything.  Windows does not touch your Linux fs's, so if there
> is a problem, it most likely is a kernel bug of some kind that
> doesn't initialize something properly.

I was the original complainer - and came to the same conclusion: that
windows wiped my stuff. I gathered it up from:

A. After booting to windows and back to 2.4.0 all was lost and the kernel
   couldn't even mount / and didn't even try /home, which was wiped, too
   (used 2.2 debian boot disks to verify that, at the time).
B. I rebuilt everything and am using 2.4.0 kernel now without any serious
   flaws (using VIA 868B UDMA33). And I'm definitely not trying to win 98
   again..
C. the wiped partition had TrueType(tm) fonts in lost+found. I can't
   think of any other reason for that except that they're from windows'
   swapping process.
...
Z. Windows 98 generally doesn't have very good architecture concerning
   drivers. It looks nice, but is a mess underneath (proved numerous times
   by trying to upgrade an old windows installation to a new machine).

-- hl


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
