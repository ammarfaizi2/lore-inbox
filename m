Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUE1JTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUE1JTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUE1JTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:19:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:54476 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266014AbUE1JTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:19:08 -0400
Date: Fri, 28 May 2004 11:19:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6: future of UMSDOS?
Message-ID: <20040528091907.GQ1912@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040527202837.GV16099@fs.tum.de> <20040528090345.6C6913F04@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jsA7DMDlpH4lpqAu"
Content-Disposition: inline
In-Reply-To: <20040528090345.6C6913F04@latitude.mynet.no-ip.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jsA7DMDlpH4lpqAu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-28 11:03:44 +0200, aeriksson@fastmail.fm <aeriksson@fastmai=
l.fm>
wrote in message <20040528090345.6C6913F04@latitude.mynet.no-ip.org>:
> Adrian Bunk wrote:
> > On Mon, May 24, 2004 at 10:19:09AM -0700, Mark Beyer - Contractor wrote:
> UMSDOS as-is, no not really, but I would like to see it ported to run
> on top of smb. Being able to have an smb equivalent to nfsroot would
> be really cool for disk space limited laptops and the like where you
> want to run e.g. colinux. All you'd need is a vmlinuz file, a small
> initrd file, and you're set to go. No need for
> filesystems-on-big-files and such workarounds...

Well, I've done something like that in userspace. For mass installations
(hundreds to thousands of machines with no interaction, while only a
Windows machine is available in each location ...), I boot off with
kernel + ramdisk (containing needed device nodes and the minimal set of
smbfs binaries to mount the server), then symlinking everything from the
servers into my ramdisk.

This approach is somewhat limited (eg. it needs to fit on a single
floppy for re-installing a totally crashed box) because smbfs binaries
are somewhat large (if you don't cut them down manually:), but it works,
at least for installation.

I guess that UMSDOS' approach *could* in theory be made to work with any
filesystem capable of storing plain files, but that'll need some work,
though:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--jsA7DMDlpH4lpqAu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtwQLHb1edYOZ4bsRAn7vAJ0XSTwoVltap5GkEOOFsAEfJXWSxQCdEWFR
8nvOXO3yuNB3FZTFdso3pVk=
=Eig3
-----END PGP SIGNATURE-----

--jsA7DMDlpH4lpqAu--
