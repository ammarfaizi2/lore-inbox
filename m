Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbRBVS4G>; Thu, 22 Feb 2001 13:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130707AbRBVSz4>; Thu, 22 Feb 2001 13:55:56 -0500
Received: from mcdc-us-smtp5.cdc.gov ([198.246.97.21]:47631 "EHLO
	mcdc-us-smtp5.cdc.gov") by vger.kernel.org with ESMTP
	id <S130109AbRBVSzj>; Thu, 22 Feb 2001 13:55:39 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2049E810D@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: trouble with 2.4.2 just released
Date: Thu, 22 Feb 2001 13:55:28 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two boxes that I immediately
tried upgrading the OS on.  In both
cases I use a script to automate the
build with a saved off .config file.
simplified ..
 untar linux tar ball
 cp config.blat linux/.config
 cd linux
 make oldconfig
 make menuconfig
 cp .config ../config.blat
 make bzImage
 make modules
 make modules_install
 ... copy files around ...
 lilo

On one box the build completed but 
with half a dozen C warnings and
a block of assembler warnings (RH7).  
These will always leave a sys admin 
nervous about running a kernel.

On the other box I have yet to get a
successful build (using a .config that
runs 2.4.2-pre4 fine).  ld complains
about a missing binary file.

ld: cannot open binary: no such file or directory

email be directly at xxh1@cdc.gov if
someone has a specific question re how
the kernel broke or if they want a copy
of my .config file

Note I'm running debian unstable/woody
on the system that's failing to build 
2.4.2, but this same system handled 
2.4.2-pre4 albeit with the warnings fine.

Also, feel free to throw the standard
idiot questions at me, I may have made
an idiot mistake.  My /usr partition
that has /usr/src/linux tree has 4G
avail, so I'm not running out of drive
space.  I'm running the script as root.
I tried both bz2 and gz versions of tarball.
... what am I missing ... ?

Heitzso
xxh1@cdc.gov
