Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbUCJSk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUCJSk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:40:28 -0500
Received: from 68-184-155-122.cpe.ga.charter.com ([68.184.155.122]:29961 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S262764AbUCJSkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:40:16 -0500
Date: Wed, 10 Mar 2004 13:40:13 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Oracle SHM values?
Message-ID: <20040310184013.GB17760@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I have users who need this:
set the following in  /usr/src/linux/include/asm/shmparam.h                =
                                            =20
SHMMAX  128MB                                                              =
                                            =20
SHMMIN     1                                                               =
                                            =20
SHMMNI     100                                                             =
                                            =20
SHMSEG      10                                                             =
                                            =20
                                                                           =
                                            =20
and following in    /usr/src/linux/inlude/linux/sem.h                      =
                                            =20
                                                                           =
                                            =20
SEMMNI       100                                                           =
                                            =20
SEMMSL       60                                                            =
                                            =20
SEMMNS      110                                                            =
                                            =20
SEMOPM       100                                                           =
                                            =20
SEMVMX      32767                                                          =
                                            =20

then recompile and install.

Is there a way to pass these values via append, or anything other than
having a one-off custom kernel config?



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAT2EN8+1vMONE2jsRAmGqAJ9jf+sOta5xAetqj47VkpZd8Vw0SgCg6GRV
ODHesIMDBCvD4/oQQrzIV9g=
=DwyM
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
