Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131175AbRCMWBK>; Tue, 13 Mar 2001 17:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbRCMV6U>; Tue, 13 Mar 2001 16:58:20 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:30115 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131196AbRCMV5b>; Tue, 13 Mar 2001 16:57:31 -0500
Date: Tue, 13 Mar 2001 22:00:34 +0000 (GMT)
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Thomas Dodd <ted@cypress.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: new generic content schemes popping up everywhere...
In-Reply-To: <3AAE778B.8418D1E9@cypress.com>
Message-ID: <Pine.LNX.4.30.0103132154100.12219-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, Thomas Dodd wrote:

> Andre Hedrick wrote:
> > >From siliconvalley.com's GMSV column today:
> >    self-destruct if it's tampered with.  The utility is enabled
> >    with 11 layers of security defenses, all of which must be
> >    successfully navigated to disable the system.  These layers
> >    range from a series of forced reboots designed to thwart
> >    automated hacking tools to something called "the white screen
> >    of death" which destroys the software and all files stored
> >    inside it.  Infraworks CEO George Friedman says the
> >    application's system-level control is possible largely because
> >    it is firmly anchored into users' C drives during
> >    installation.  "We're fairly deep in the operating system,"
>
> Not much help if you put the disk in another box without their
> system installed (or mount in linux/BSD/MacOS) to break the
> encryption/controls. Once that's done, A floppy based OS
> and tool could break open the files on a disk, when their
> apps aren't running.
>
> If it can be decrypted "legally" it can
> be done "illegally" too.

Indeed. The whole concept is fatally flawed; probably the biggest
challenge facing a cracker attacking this system is choosing which of the
many avenues to start with :-)

1. The drivers. I really like displaying audio and video via my hard
drive, so I use drivers which do that...

2. Debugger: I'll stick a breakpoint in a suitable point, so just after
decryption the program is frozen and dumped to disk. Ooh look -
unencrypted content!

3. Rebuild the Windows kernel with the functions they rely on disabled.
When the kernel's out to get you, you're thoroughly screwed.

4. Run it under VMWare, and snapshot the screen with the content
displayed.

5. Don't buy this "protected" content crap, and watch their share price
go round the S-bend.

6. Run it under Wine, with a few API tweaks.


I'm sure there are plenty of other approaches, but this is rather OT for
lkml...


James.

