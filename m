Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264892AbSJWMZq>; Wed, 23 Oct 2002 08:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSJWMZp>; Wed, 23 Oct 2002 08:25:45 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:12806 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S264892AbSJWMZo>;
	Wed, 23 Oct 2002 08:25:44 -0400
Date: Wed, 23 Oct 2002 14:31:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols problem
Message-ID: <20021023123153.GB24969@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021023122549.57302.qmail@web40603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20021023122549.57302.qmail@web40603.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-10-23 13:25:49 +0100, Cathal Daly <cdaly24@yahoo.co.uk>
wrote in message <20021023122549.57302.qmail@web40603.mail.yahoo.com>:
> it. I am trying to load an e1000 driver as a module
> but I am getting unresolved symbols. The hash values
> at the end of the exported symbols do not match the
> corresponding hash values in the /proc/ksyms file in
> the running kernel. I gather that this is because
> module versioning is turned on in the kernel. I can't
> compile the driver against the kernel as I don't have
> the correct kernel sources. Is there any possible way
> to get the network driver to load into this kernel
> image without the kernel sources. I imagine the hash
> values from /proc/ksyms and the driver unresolved
> symbols will have to match but how can this be done. I

By recompiling the whole kernel, inclusive e1000. There's no way loading
the module while not risking an Oops or other bad things. Linux tries to
maintain source compatibility, but there's no binary compatibility (as
you obviously see:-)

Do a fresh compile and that'll succeed...

MfG, JBG


--=20
   - Eine Freie Meinung in einem Freien Kopf f=FCr
   - einen Freien Staat voll Freier B=FCrger
   						Gegen Zensur im Internet
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9tpa5Hb1edYOZ4bsRAnoPAJ4luSQ9h0H8GAZ7vNy/KD4uvqmkOwCdHG6m
pwfmg5/spPyX3L7l6Wq3mdg=
=UerY
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
