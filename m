Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbVF3Uow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbVF3Uow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbVF3UnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:43:16 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:55214 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263154AbVF3UkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:40:02 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 30 Jun 2005 21:39:47 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
cc: Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
In-Reply-To: <20050630193320.GA1136@fargo>
Message-ID: <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
 <20050630193320.GA1136@fargo>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-364448724-1120163987=:29755"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-364448724-1120163987=:29755
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 30 Jun 2005, David [utf-8] G=F3mez wrote:
> On Jun 30 at 02:29:48, Robert Love wrote:
> > > I just patched 2.6.12 kernel with the inotify latest patch
> > > (inotify-0.23-rml-2.6.12-14.patch). Inotify is working ok with the te=
st program
> > > provided in inotify-utils but... I can no longer mount my IDE cdrom d=
evices
> > > :(. Each time i try to mount a disc, the mount proccess get stuck in =
D state. I
> > > don't see what's the relation between inotify and IDE devices, but if=
 i switch
> > > back to the unpatched 2.6.12, mounting works again.
> >=20
> > Very weird.
> >=20
> > Did everything work with an earlier inotify?
> >=20
> > Does wchan show anything useful (ps -ewo user,pid,command,wchan)?
>=20
> I tested it again, wchan says "inode_wait"...

Do you have any ntfs volumes mounted by any chance?=20

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
--1870869256-364448724-1120163987=:29755--
