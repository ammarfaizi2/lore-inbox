Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129639AbRB0RYk>; Tue, 27 Feb 2001 12:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRB0RYa>; Tue, 27 Feb 2001 12:24:30 -0500
Received: from pucc.Princeton.EDU ([128.112.129.99]:51507 "EHLO
	pucc.Princeton.EDU") by vger.kernel.org with ESMTP
	id <S129639AbRB0RYX>; Tue, 27 Feb 2001 12:24:23 -0500
To: linux-kernel@vger.kernel.org
From: Neale.Ferguson@softwareAG-usa.com
Date: Tue, 27 Feb 2001 12:20:08 +0200
Subject: Jump start Linux on S/390
Message-Id: <20010227172424Z129639-406+313@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of hints courtesy of Lionel Dyck that may make life easier
for thos installing on bare iron or in an LPAR.

------------------------------------------------------------------------

This is a suggested method to Jump Start your Linux on S/390 or zSeries
experience:

1) Get yourself a copy of Linux for the Intel platform and install it on
your desktop pc in dual boot mode or get yourself a 2nd pc on which
to install it. Note this should be the same flavor Linux that you plan to
use of your S/390.
2) Create a userid other than root (generally recommended)
3) Once your pc is booted in Linux download the CD images for
the distribution that you have selected into a unique directory on your
system. While still in this directory issue these commands to first create
the mount points and then to mount the CD images in loopback mode.
(Thanks for Mark Post for this information)
a) mkdir /cd1
b) mkdir /cd2
c) mkdir /cd3
d) mount cd1.iso /cd1 -o loop -r
e) mount cd2.iso /cd2 -o loop -r
f) mount cd3.iso /cd3 -o loop -r
4) On your S/390 HMC select IPL from CDROM or Server (thanks
to Ross Waitman of IBM for this information).
a) Check to IPL from FTP Server and enter the IP address of your
      Linux pc.
b) Use the userid you created to acces these.

Note I havent tried this beyond (4) as I just learned this can be done.

























