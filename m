Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUJBNfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUJBNfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUJBNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:35:30 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:62091 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265943AbUJBNfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:35:20 -0400
Date: Sat, 2 Oct 2004 14:35:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Windows Logical Disk Manager error
In-Reply-To: <200410021114.40621@senat>
Message-ID: <Pine.LNX.4.60.0410021434130.23495@hermes-1.csi.cam.ac.uk>
References: <200409231254.12287@senat> <1096641835.17297.45.camel@imp.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410020041030.14363@hermes-1.csi.cam.ac.uk> <200410021114.40621@senat>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-1337128112-1096724115=:23495"
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-1337128112-1096724115=:23495
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 2 Oct 2004, Marcin [iso-8859-2] Gibu=B3a wrote:
> > I should add an AFAIK here.  I am by no means familiar (enough) with EV=
MS,
> > LVM1/2, and the kernel Device Mapper itself, to be able to tell if ther=
e
> > isn't some clever way of making it work with existing drivers and tools=
=2E..
>=20
> Good news, when I did the following:
>=20
> # dmsetup create test
> 0 54138987 linear /dev/sda1 0
> 54138987 40965687 linear /dev/sda3 0
>=20
> # mount /dev/mapper/test /mnt/d
> # ls /mnt/d
>=20
> ... it worked!
> (the same with sda4 + sda2 volume, i've taken numbers from ldminfo output=
)
>=20
> Maybe it's worth to update Documentation/filesystems/ntfs.txt :)

Great stuff!  Well done.  Thanks for letting me know.  It is definitely=20
time for an update of Documentation/filesystems/ntfs.txt.  (-:

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
--1870869256-1337128112-1096724115=:23495--
