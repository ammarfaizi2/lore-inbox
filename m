Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131794AbRAJFIm>; Wed, 10 Jan 2001 00:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132917AbRAJFIh>; Wed, 10 Jan 2001 00:08:37 -0500
Received: from clueserver.org ([206.163.47.224]:45073 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S131794AbRAJFI1>;
	Wed, 10 Jan 2001 00:08:27 -0500
Date: Tue, 9 Jan 2001 21:18:15 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Crawford <billc@netcomuk.co.uk>, linux-kernel@vger.kernel.org,
        crawford@goingware.com
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
In-Reply-To: <E14GD0W-0008AA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101092052220.14572-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Alan Cox wrote:

> >  The Mesa package in Red Hat 7 won't do DRI with recent XFree86 CVS.
> 
> Yep. Its Mesa 3.3/DRI 1.0. XFree86 CVS is Mesa 3.4/DRI 2.0. That has several
> advantages including mostly working on Matrox cards which 1.0 never did (for
> me anyway) and handling things that Mesa 3.3 tried to allocate the odd gig
> of ram for and then exploded.
> 
> With the CVS stuff the 2.4 kernel should work out of the box. You need -ac for
> some ALi AGP chipsets.

My experiences with the Matrox G400 has been similar.

With 4.0.1 and the Matrox drivers, I could get DRI to work... For a while
and then the whole thing would lock tight as a drum, kernel and all.

The Matrox drivers on their ftp site will not even build with
XFree86 4.0.2. 

XFree86 4.0.2 with 2.4.0-test 12 no longer locks up on some GL games.
(Heavy Gear II, Quake III, and Heretic 2 all work well.) The only
exception I can find is Descent 3 which has a nasty visual smearing
problem that makes it unplayable. (Not certain why. Have not pressed the
issue with Loki yet.) Xinerama has an odd problem, which Keith Packard is
looking into. (When he gets back from Hawaii.) Xinerama is usable, but has
some ugly screen artifacts on the second screen.

The other big difference between 4.0.1 under the 2.2.17 with back-ported
AGP and the 4.0.2 on 2.4.0-test 12 is that I now get a contant frame rate.
On the earlier version, the framerate could bounce around 25% of the total
frames with the Mesa gears test.  The new version I see a varience of
about 2 frames or so! VERY steady.

I will be testing the performance under 2.4.0 final sometime later
tonight, after I am done with the project I am currently working on.  (One
of those "I have an idea and must test it now" kinda days.  So far, the
code has all worked...)  

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
