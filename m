Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318771AbSG0PRg>; Sat, 27 Jul 2002 11:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318772AbSG0PRg>; Sat, 27 Jul 2002 11:17:36 -0400
Received: from durandal.simons-rock.edu ([64.210.108.44]:49882 "HELO
	durandal.simons-rock.edu") by vger.kernel.org with SMTP
	id <S318771AbSG0PRf>; Sat, 27 Jul 2002 11:17:35 -0400
Date: Sat, 27 Jul 2002 11:20:53 -0400 (EDT)
From: Marshal Newrock <marshal@simons-rock.edu>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: HTP372 on K7RA-RAID / kernel 2.4.19rc3
In-Reply-To: <Pine.NEB.4.44.0207260858290.15439-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0207271112540.12906-100000@minerva.simons-rock.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Adrian Bunk wrote:

> On Wed, 24 Jul 2002, Marshal Newrock wrote:
>
> > HPT372 IDE RAID chip on an Abit K7RA-RAID
> > running a freshly installed Gentoo (has gcc-2.95)
> > kernel 2.4.19rc3, using devfs.
> > Western Digital 40GB ATA100 drive on /dev/hde, one partition, ext2
> > filesystem.
> >
> > The system has no problem recognizing the HPT372, and can see the drive
> > and partitions.  I can generally mount it (mount /dev/hde1 /mnt), and 'ls
> > /mnt' lists the directories.  'ls -l /mnt' will give an 'input/output
> > error' for each directory.  Sometimes the ls or mount will hang, and I
> > have to kill the login from another shell.
> >
> > Right now, I have the drive connected as /dev/hdc (replacing the CD
> > drives), and working fine.
>
> The -ac kernels contain some IDE updates including updates to hpt366.c
> (AFAIR the HPT372 isn't really supported in 2.4.19-rc3). Could you try
> whether 2.4.19-rc3-ac3 (apply [1] on top of 2.4.19-rc3 and run
> "make clean oldconfig dep bzImage modules") fixes your problem?

The HPT372 seems to work fine with 2.4.19-rc3-ac3.

Thanks.

-- 
Marshal Newrock, Simon's Rock College of Bard
Caution: product may be hot after heating

