Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSK0IiB>; Wed, 27 Nov 2002 03:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSK0IiB>; Wed, 27 Nov 2002 03:38:01 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:49425 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261669AbSK0Ih7>;
	Wed, 27 Nov 2002 03:37:59 -0500
Date: Wed, 27 Nov 2002 11:44:25 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fbdev 2.5.49 BK fixes.
Message-ID: <20021127084425.GA488@pazke.ipt>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20021122100215.GA4998@pazke.ipt> <Pine.LNX.4.44.0211262306070.30451-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211262306070.30451-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2002 at 11:22:07PM +0000, James Simmons wrote:
>=20
> > > Hm. Strange. It should work. Can you get serial console working?=20
> >=20
> > Forgot to mention, I've seen message:
> > 	fbcon_setup: No support for fontwidth 8
> > in /var/log/dmesg.=20
> >=20
> > I found this printk() in fbcon_setup(), but i can't even imagine=20
> > why it happens.
>=20
> Perfect. I found the problem and I'm about to commit to BK. I posted the=
=20
> latest patch against 2.5.49 at
>
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>=20
I see some harmless crap slipped into the patch again :))

Add these file into /home/jsimmons/dontdiff:
	vmlinux.lds.s
	gen_init_cpio
	initramfs_data.cpio.gz

I'll test the patch this eveninig.

> > I understand this situation perfectly, looks like it's almost common for
> > developers working in "not so importatnt for servers" subsystems :(
>=20
> :-( Some day that attitude will change.
>=20

Lets hope so.

> P.S
>=20
>     Several drivers have been ported but not all. NVIDIA is still broken=
=20
> but I will fix it tonight.

I can test the fix on my riva128.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE95IXpBm4rlNOo3YgRAobFAJ9PurjKzqC8np1ylYe5Yq2PHBVmjwCgiiOB
un07qb8i/PSq90GznFA+pmM=
=Wfam
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
