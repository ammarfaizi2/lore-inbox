Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281711AbRKQHX7>; Sat, 17 Nov 2001 02:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281713AbRKQHXt>; Sat, 17 Nov 2001 02:23:49 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:4736 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281711AbRKQHXk>; Sat, 17 Nov 2001 02:23:40 -0500
Message-ID: <002601c16f38$aa3d7290$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] NetWare File System Module Version NWFS v4.0 Posted
Date: Sat, 17 Nov 2001 00:22:50 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NetWare File System NWFS v4.0 module driver and utility sources has
posted at ftp.timpanogas.org/nwfs/nwfs.tar.gz and
ftp.utah-nac.org:/nwfs/nwfs.tar.gz.  This version has been tested on Linux
2.4.14 running the RedHat SeaWolf version 7.1 Release.  Hard Links are
disabled and so is the page cache.  Hard Links will be allowed in a future
version.
Those folks who need to perform NetWare to Linux migrations can download
NWIMAGE and other useful server migration tools from ftp.utah-nac.org and
ftp.timpanogas.org.  NWIMAGE runs under DOS, W2K and Linux and allows a
server administrator to remote image NetWare Volumes onto a networked master
archive server, then restore entire system configurations onto newly
installed Linux and W2K servers (preferably Lunux).  :-)

A Kernel Patch incorporating NWFS into Linux 2.4.15/16 as a compatibility
file system is under construction.

Do-na-da Go-hv-e

Wa-do

Jeff V. Merkey
TRG/Utah NAC
Waya Ge-tlv-hv-s-di

BUILD METHOD USING THE BUILD SCRIPT
-----------------------------------

NOTE:  The new build procedure allows you to simply type

#
# ./build <option>
#

from the directory where you install the NWFS sources.  This
newer model auto detects modversioning, smp, version, etc.  There is
an assumption made that a symbolic link to /usr/src/linux ->
exists that points to your Linux build area.  Some of the
newer Red Hat kernels no longer use this syntax.  For the
NWFS build to work properly, you will need to have a
pre-configured Linux source tree present with a symbolic
link to the /usr/src/linux directory.

Simply type ./build for a list of build options.




