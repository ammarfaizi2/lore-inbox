Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310288AbSCABOI>; Thu, 28 Feb 2002 20:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310294AbSCABKo>; Thu, 28 Feb 2002 20:10:44 -0500
Received: from netmail.netcologne.de ([194.8.194.109]:26653 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S310290AbSCABHx>; Thu, 28 Feb 2002 20:07:53 -0500
Message-Id: <200203010107.AUI38794@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.18-jp6 #3 Thu Feb 28 23:09:31 CET 2002 i686 unknown
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Kernel patch set 2.4.18-jp6
Date: Fri, 1 Mar 2002 02:05:18 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel patch set jp6 of the Linux kernel 2.4.18

Jörg Prante <joerg@infolinux.de>

http://infolinux.de/jp6

What is it?

The -jp kernels are development kernels and for testing purpose only. They 
will appear regularly two or three times a month. Their purpose is to provide 
a service for developers who can't keep up to date with the latest kernel and 
patch versions, but want to test new features and evaluate enhancements that 
are not to be expected for inclusion into the mainstream 2.4 kernel.

You are missing a patch? Patches will be added by request.

I use the-jp kernel on my Dell Inspiron to get more experience on kernel 
hacking. It's a 2.4 patch set because I want to keep my data.

Overview

The -jp6 patch set contains

rmap 12f
--------        
a sophisticated reverse mapping VM 
Rik van Riel
http://www.surriel.com/patches

sched O(1) K3  
-------------
a fast task scheduler
Ingo Molnar
http://people.redhat.com/mingo

preempt        
-------
full preempting kernel tasks for low latency
Robert Love
http://www.tech9.net/rml/linux

ide    
---        
IDE enhancements 
Andre Hedrick
http://www.kernel.org/pub/linux/kernel/people/hedrick/

patch-int 
---------       
international cryptographic API patch
Herbert Valerio Riedel et.al.
http://www.kernel.org/pub/linux/kernel/people/hvr/

freeswan 1.95  
-------------
free IPsec implementation 
John Gilmore et.al.
http://www.freeswan.org

freeswan x.509 patch
--------------------
Andreas Steffen et.al
http://www.strongsec.com/freeswan/

grsec 1.9.4
-----------
great security patch
Brad Spengler et.al.
http://www.grsecurity.net

XFS (CVS 27 Feb 2002)
--------------------- 
high-performance file system
Stephen Lord et.al.
ftp://oss.sgi.com/projects/xfs/download/patches/2.4.18

kdb 2.1        
-------
SGI kernel debugger
Keith Owens et.al.
http://oss.sgi.com/projects/kdb/

JFS 1.0.15 
----------     
IBM journal file system
Steve Best et.al
http://oss.software.ibm.com/developerworks/oss/jfs/

Dell Boot
---------
Boot time ioremap and early dmi scan
Mikael Pettersson
http://www.csd.uu.se/~mikpe/linux/kernel-patches/2.4/

TIOCGDEV
--------
new ioctl to return the console mapping
Kurt Garloff
http://banyan.dlut.edu.cn/news/121600/0116.html

loop crypto device/twofish
--------------------------
from older version of the international crypto patch

Software RAID enhancements
--------------------------
patch set to manage multiple RAID devices (span chunks, MD partitioning)
Neil Brown
http://cgi.cse.unsw.edu.au/~neilb/patches/linux-stable/

i2c 2.6.2
---------
Hardware monitoring
Alexander Larsson et.al.
http://www.netroedge.com/~lm78/

lm_sensors 2.6.2
----------------
Hardware monitoring
Alexander Larsson et.al.
http://www.netroedge.com/~lm78/

Credits go to all the people who created the patches, working hard on
improving the quality.

Installation

* untar the 2.4.18 kernel sources from http://kernel.org to /usr/src/linux
* untar the patch set in your favorite directory
* cd into this directory and apply the patch set with the 'addpatches' script
* compile and install the kernel

Feel free to send me a feedback. Please CC, I am not subscribed to lkml.

Enjoy!

Jörg Prante <joerg@infolinux.de>
Software Developer
Bonn, Germany
