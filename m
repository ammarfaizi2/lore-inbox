Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316208AbSEQN07>; Fri, 17 May 2002 09:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316206AbSEQN06>; Fri, 17 May 2002 09:26:58 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:42699 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S316190AbSEQN05>; Fri, 17 May 2002 09:26:57 -0400
Date: Fri, 17 May 2002 14:26:17 +0100
From: "J.P. Morris" <jpm@it-he.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Aralion and IDE blasphemy
Message-Id: <20020517142617.5b73a46d.jpm@it-he.org>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is probably approaching blasphemy, but has anyone ever considered
an emergency EIDE driver that uses the extended int13h calls?
I'm pretty sure there's a protected-mode BIOS interface in modern BIOSes
these days, so it shouldn't need to go down to real mode to make the
calls.

I have just purchased an IDE RAID controller to add tertiary and
quaternary IDE ports to my system for an extra CDROM drive.
I thought the days when you couldn't get Linux support for such things
were long gone, but sadly no.

The culprit is an ARALION ARS106S chipset card.  Interestingly it works
in DOS, and if the hard disks are attached to it, it will even boot
up to LILO, but then the kernel dies because it can't find the HDDs.
(On their web page message board, some guy asks for the specs but is
 helpfully pointed to an obsolete binary module for RedHat 7.1.)

If there was Linux support for BIOS-based EIDE controllers, it should
in theory work, if slowly.

Alternatively, can anyone suggest a cheap tertiary EIDE card suitable
for CDROM or hard disks that Linux can support?

-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  jpm@it-he.org
Fun things to do with the Ultima games            http://www.it-he.org
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)
