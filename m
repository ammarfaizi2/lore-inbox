Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTBTL0V>; Thu, 20 Feb 2003 06:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBTL0V>; Thu, 20 Feb 2003 06:26:21 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:34575 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S265174AbTBTL0U>;
	Thu, 20 Feb 2003 06:26:20 -0500
Date: Thu, 20 Feb 2003 12:36:24 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Message-ID: <20030220113624.GP351@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030220062323.GX351@lug-owl.de> <Pine.LNX.3.96.1030220060638.14551A-101000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kKNbsfnwzLokd41"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030220060638.14551A-101000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7kKNbsfnwzLokd41
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-02-20 06:23:46 -0500, Bill Davidsen <davidsen@tmr.com>
wrote in message <Pine.LNX.3.96.1030220060638.14551A-101000@gatekeeper.tmr.=
com>:
> On Thu, 20 Feb 2003, Jan-Benedict Glaw wrote:
> > On Wed, 2003-02-19 15:39:44 -0500, Bill Davidsen <davidsen@tmr.com>
> > > If you have simple needs that's fine. I build for multiple groups of
> > > machines, and with a working mkinitrd I can just build a file for the=
 boot
> > > controller on each type of machine, and only build a single kernel wh=
ich
> > > will run anywhere with the proper initrd file.
> >=20
> > I do it the other way around - I've collected a number of .config files
> > (one for each machine) which includes everything the machine needs to
> > *boot*.
>=20
> But... if you have it in .config, then you have to rebuild the kernel each
> time. Maybe on an Alpha that doesn't matter, on anything I use a kernel

Guess, I do rebuilds nearly every time Linus releases a new full kernel
or one of his bk snapshots. So that doesn't really matter...

At times, even cross compiles succeed. On a dual Athlon (1.4GHz each),
building kernels doesn't really take thaaaaat long:-) Esp. if you can
keep all the kernel sources and a dozend compilers in memory:-P

> >          Any additional features (LVM/DM, filesystems, iptables, ...)
> > ships as modules. Things which require a distinct order are placed into
> > /etc/modules (Debian's list of modules which need to be loaded in given
> > order), all the rest is done via alias/install lines in
> > modules.conf/modprobe.conf.
> >=20
> > This is, you do keep a machine's local config in its initrd, I do keep
> > it on the machine itself.
>=20
> Okay, now I see what you are doing, I guess you just have enough system
> power to invest the time and disk space in building a kernel for each
> config. When there was a working mkinitrd I was happily able to use fewer
> of my resources to generate boot setups for all my systems, at least of a
> given arch.

This reminds me that I wanted to have a look at an additional feature -
building the kernel _not_ within its source tree. So I wouldn't need to
place 10 copies of the kernel onto disk / into memory...

Haven't I seen patches flyin' around? Anyone?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--7kKNbsfnwzLokd41
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+VL23Hb1edYOZ4bsRAsIwAJ9Qu35L6WGphMDXa90RoDjQ0jVyHACcDR3E
Ke6oH2sIAZ4OhPQ4lvGO108=
=JFfE
-----END PGP SIGNATURE-----

--7kKNbsfnwzLokd41--
