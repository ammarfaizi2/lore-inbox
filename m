Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWA0FYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWA0FYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 00:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWA0FYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 00:24:54 -0500
Received: from h80ad2572.async.vt.edu ([128.173.37.114]:52916 "EHLO
	h80ad2572.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750741AbWA0FYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 00:24:53 -0500
Message-Id: <200601270524.k0R5OIS8019541@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jerome.lacoste@gmail.com, rlrevell@joe-job.com, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) 
In-Reply-To: Your message of "Thu, 26 Jan 2006 15:03:11 +0100."
             <43D8D69F.nailE2XAJ2XIA@burner> 
From: Valdis.Kletnieks@vt.edu
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner> <43D7B5BE.60304@gmx.de> <43D89B7C.nailDTH38QZBU@burner> <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com>
            <43D8D69F.nailE2XAJ2XIA@burner>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1138339457_2915P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Jan 2006 00:24:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1138339457_2915P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jan 2006 15:03:11 +0100, Joerg Schilling said:
> jerome lacoste <jerome.lacoste=40gmail.com> wrote:

> >   ssh user=40host cdrecord dev=3D/dev/cdrw /path/to/file.iso
>=20
> On the vast majority of OS this does not work.

OK.. If =22vast majority=22 is the proper way to decide this issue..

.. What does WinXP call the CD writer device?

What's wrong with this picture?  Maybe =22vast majority=22 is the wrong c=
riteria...

'cdrecord -scanbus' tells me I'm supposed to use 'dev=3D0,1,0', which has=
 *zero*
meaning to me, since my laptop has no SCSI in it.  Fortunately, I also ha=
ve a
/dev/hdb, and 'dev=3D/dev/hdb' works the way one would expect if they wer=
en't
attached to a 1986-style naming scheme for some transport mechanism that =
isn't
present on my hardware.

And you know what? I really don't give a flying <fornicate> in a rolling =
donut
what FreeBSD calls the device. If I did, I'd have installed FreeBSD.  But=
 I
installed a Fedora distro of Linux, and the only sane naming scheme is th=
e
one that Fedora uses...


--==_Exmh_1138339457_2915P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD2a6BcC3lWbTT17ARArkpAKC90JBwqaIVZFXrMRRThWzeieHnPwCdGNn5
bVzkvRUqzG0pGyZmYtK/1D0=
=Ba3Q
-----END PGP SIGNATURE-----

--==_Exmh_1138339457_2915P--
