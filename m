Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSKVTff>; Fri, 22 Nov 2002 14:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbSKVTff>; Fri, 22 Nov 2002 14:35:35 -0500
Received: from ppp-217-133-217-73.dialup.tiscali.it ([217.133.217.73]:8335
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S265236AbSKVTfe>; Fri, 22 Nov 2002 14:35:34 -0500
Subject: Re: 2.5.48-bk4 still impossible to mount root.
From: Luca Barbieri <ldb@ldb.ods.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>, rgooch@atnf.csiro.au,
       viro@math.psu.edu
In-Reply-To: <3DDE67DB.C66E43D3@aitel.hist.no>
References: <3DDE67DB.C66E43D3@aitel.hist.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-V/Ny4hherPtb0t6Tf59e"
Organization: 
Message-Id: <1037994156.11829.9.camel@home.ldb.ods.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 22 Nov 2002 20:42:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V/Ny4hherPtb0t6Tf59e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-11-22 at 18:22, Helge Hafting wrote:
> None of the 2.5.48- bk or mm kernels lets me mount root,
> while 2.5.47 works fine.

You have to use the long devfs name, e.g. rather than /dev/hda1 use
/dev/ide/host0/bus0/target0/lun0/part1.

I don't know whether this is change is intentional or not or which
changeset is responsible.


--=-V/Ny4hherPtb0t6Tf59e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA93oisdjkty3ft5+cRAgOCAJ9oq/FS3i0h21k3nuREqkQI7MBW2QCfUK/v
YbWNaZ6yhk1c6blrBPsCfsA=
=9ljB
-----END PGP SIGNATURE-----

--=-V/Ny4hherPtb0t6Tf59e--
