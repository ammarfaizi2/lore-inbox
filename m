Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbTBTGNU>; Thu, 20 Feb 2003 01:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBTGNU>; Thu, 20 Feb 2003 01:13:20 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:56080 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S264907AbTBTGNT>;
	Thu, 20 Feb 2003 01:13:19 -0500
Date: Thu, 20 Feb 2003 07:23:23 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Message-ID: <20030220062323.GX351@lug-owl.de>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <20030219195543.GW351@lug-owl.de> <Pine.LNX.3.96.1030219153452.11297B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z1Pli9ypV4pBfZC4"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030219153452.11297B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z1Pli9ypV4pBfZC4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-19 15:39:44 -0500, Bill Davidsen <davidsen@tmr.com>
wrote in message <Pine.LNX.3.96.1030219153452.11297B-100000@gatekeeper.tmr.=
com>:
> On Wed, 19 Feb 2003, Jan-Benedict Glaw wrote:
> > On Wed, 2003-02-19 13:00:39 -0500, Bill Davidsen <davidsen@tmr.com>
> > > Be aware that for Redhat and SuSE distributions (and mandrake??) "make
> > > install" will fail because mkinitrd doesn't know about the new modules
> > > format.
> > >=20
> > > So you can give up using modules for anything you want to use to boot,
> >=20
> > Which is what I prefer - I personally don't like initrd and I don't use
> > it.
>=20
> If you have simple needs that's fine. I build for multiple groups of
> machines, and with a working mkinitrd I can just build a file for the boot
> controller on each type of machine, and only build a single kernel which
> will run anywhere with the proper initrd file.

I do it the other way around - I've collected a number of .config files
(one for each machine) which includes everything the machine needs to
*boot*. Any additional features (LVM/DM, filesystems, iptables, ...)
ships as modules. Things which require a distinct order are placed into
/etc/modules (Debian's list of modules which need to be loaded in given
order), all the rest is done via alias/install lines in
modules.conf/modprobe.conf.

This is, you do keep a machine's local config in its initrd, I do keep
it on the machine itself.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--z1Pli9ypV4pBfZC4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+VHRaHb1edYOZ4bsRApXeAJ9Yuzuc3zjKVHgQv5hYX0iiyzMJKgCePQFh
GubR3CE852uWIayoMSc63hY=
=pwbf
-----END PGP SIGNATURE-----

--z1Pli9ypV4pBfZC4--
