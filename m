Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbREMKnq>; Sun, 13 May 2001 06:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbREMKn1>; Sun, 13 May 2001 06:43:27 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:14824 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261391AbREMKnY>; Sun, 13 May 2001 06:43:24 -0400
Message-Id: <5.1.0.14.2.20010513105120.00ac37e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 13 May 2001 11:44:26 +0100
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux support for Microsoft dynamic disks?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010512203445.A4194@vger.timpanogas.org>
In-Reply-To: <5.1.0.14.2.20010513000214.00ab3810@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010513000214.00ab3810@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:34 13/05/2001, Jeff V. Merkey wrote:
>On Sun, May 13, 2001 at 12:06:03AM +0100, Anton Altaparmakov wrote:
> > Is anyone working on supporting the dynamic disk format introduced with
> > Windows 2000? If not, does anyone have the specs / any detailed info on 
> the
> > on disk structures involved?
>
>What is your specific question?

My question is quite generic: What is the on disk layout of Win2k's dynamic 
disk, i.e. Logical Disk Manager (LDM) database structures? - The article 
"Inside Storage Managment, Part 2" by Mark Russinovich in Windows 2000 
magazine (full text available freely at: 
http://www.win2000mag.com/Articles/Index.cfm?ArticleID=8303) describes in 
detail the logical layout of the LDM database, but it doesn't cover enough 
detail to go off and implement it in Linux (without a certain amount of 
reverse engineering).

Linux needs to understand the LDM database in order to support dual-boot 
Win2k (or XP) and Linux configurations where there are one or more dynamic 
disks present in the system and the user wants to access their NTFS 
partitions residing on the dynamic disk(s) from Linux.

Just saying "Don't use dynamic disks if you want to use Linux" is IMHO a 
Bad Thing(TM) as a user might have bought a computer with Win2k 
preinstalled on a dynamic disk or, even worse, might have been using Win2k 
only previously, and then the user wants to also install Linux on it. In 
these cases the user would have to reformat the whole system and start from 
scratch unless Linux supports dynamic disks... Reinstalling Windows is a 
major PITA considering the number of reboots required and how slow Win2k 
boots. I recently upgraded a Win98 machine in my lab to Win2k and it took 
me around 5 hours to do with god knows how many reboots in between and 
constant user intervention required. Ugh!

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

