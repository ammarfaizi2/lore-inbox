Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263176AbVCKFTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbVCKFTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbVCKFTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:19:16 -0500
Received: from faye.voxel.net ([69.9.164.210]:11757 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S263176AbVCKFTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:19:00 -0500
Subject: 2.6.10-as7
From: Andres Salomon <dilinger@debian.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XiqgrcpQLK8KcL0wTSjG"
Date: Fri, 11 Mar 2005 00:18:59 -0500
Message-Id: <1110518340.8577.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XiqgrcpQLK8KcL0wTSjG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

2.6.10-as is now in purely maintenance mode; that is, I'll only include
security fixes or quick things that people send me (that don't require
much effort on my part :).  This includes the security fix from
2.6.11.2.  I'll have 2.6.11-as1 soon, after I sync up w/ Debian stuff
and go through about 800 more changesets.  We'll see where 2.6.x.y goes
from there; if feeding patches is easy, then there won't be much need
for -as; otherwise, I'll continue doing it as a vendor base (at least
one person who does vendor kernels has expressed the opinion that they'd
prefer 2.6.x.y to be a bit more liberal than it currently is).

Also, note the email address; I'm trying to phase out usage of my
voxel.net address, as I no longer work there.


The -as tree is intended to include only security and bugfixes, from
various sources.  I do not include hardware driver updates
(specifically, anything that changes how the hardware registers
themselves are probed/poked), large subsystem updates, cleanups, and so
on; only fixes that will not contain regressions.  The hope is that
vendors/distributors can use this tree as a base for their kernels.  It
is also what I'd want a 2.6.x.y tree to have.

The kernel patches can be grabbed from here:
http://www.acm.cs.rpi.edu/~dilinger/patches/2.6.10/as7/

86f79bd2e50963829da3c0456804df0f  ChangeLog
e852090bafa5ea4ff7c6b922d33ec1e7  linux-2.6.10-as7.tar.gz
8ca1ac89c1eac2111f146cc21d6193c2  patch-2.6.10-as7.gz

Changes from 2.6.10-as6:

2005-03-10 21:51:49 GMT	Andres Salomon <dilinger@voxel.net>	patch-155

    Summary:
      tag 2.6.10-as7
    Revision:
      linux--dilinger--0--patch-155

   =20
   =20

    modified files:
     000-extraversion.patch


2005-03-10 21:50:21 GMT	Andres Salomon <dilinger@voxel.net>	patch-154

    Summary:
      144-sys_epoll_wait_int_overflow.patch
    Revision:
      linux--dilinger--0--patch-154

    [SECURITY] sys_epoll_wait contains an integer overflow; see
    http://seclists.org/lists/fulldisclosure/2005/Mar/0293.html for
additional
    details.
   =20
   =20

    new files:
     .arch-ids/144-sys_epoll_wait_int_overflow.patch.id
     144-sys_epoll_wait_int_overflow.patch


2005-03-10 21:46:21 GMT	Andres Salomon <dilinger@voxel.net>	patch-153

    Summary:
      143-sysfs_write_file_signedness_problem.patch
    Revision:
      linux--dilinger--0--patch-153

    [SYSFS] sysfs_write_file assigns the result of fill_write_buffer
(which is
    signed and returns negative upon error) to an unsigned int.
Clearly, bad
    and wrong..
   =20

    new files:
     .arch-ids/143-sysfs_write_file_signedness_problem.patch.id
     143-sysfs_write_file_signedness_problem.patch


--=20
Andres Salomon <dilinger@debian.org>

--=-XiqgrcpQLK8KcL0wTSjG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCMSpD78o9R9NraMQRArJEAKCLYJeduavu6PiCfEQSPWHDfO0x+wCglgIH
P4Sh3qzIj79agjMmd4RXUc8=
=lP5x
-----END PGP SIGNATURE-----

--=-XiqgrcpQLK8KcL0wTSjG--

