Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSFBVcd>; Sun, 2 Jun 2002 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFBVcc>; Sun, 2 Jun 2002 17:32:32 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:2036 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S314396AbSFBVca>;
	Sun, 2 Jun 2002 17:32:30 -0400
Date: Sun, 2 Jun 2002 23:31:52 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: SMB filesystem
Message-ID: <20020602213151.GD14126@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3CFA875D.1050300@linkvest.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2002 at 11:00:13PM +0200, Jean-Eric Cuendet wrote:
> I'm thinking of implementing an smb filesystem, the way AFS implement=20
> the AFS client fs kernel driver.
> - Mount the smb filesystem on /smb (done at boot time)
> - Every user has list dir access on /smb
> - There, you see each workgroup/domain available on the network
> - Then in each domain, a list of machines
> - Then in each machine, a list of shares
> - Then a list of files/dirs
[...]
> Thanks for comments/ideas.

Can this be done with autofs in userspace?  It works for NFS, just cd to
/autofs-mountpoint/hostname.

Marius Gedminas
--=20
Any sufficiently advanced Operating System is indistinguishable from Linux.
		-- Jim Dennis

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8+o7HkVdEXeem148RAvDLAKCPALQXFk6Bk/86Yv3BwpcAxbyZPACghlGl
HDwZvLQ2ebqoIFzgX11Vuqo=
=vAQX
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
