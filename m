Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbTAORzH>; Wed, 15 Jan 2003 12:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTAORzH>; Wed, 15 Jan 2003 12:55:07 -0500
Received: from dialin-145-254-149-038.arcor-ip.net ([145.254.149.38]:39552
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S266936AbTAORzF>; Wed, 15 Jan 2003 12:55:05 -0500
Date: Wed, 15 Jan 2003 14:32:17 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.21pre2 trident / ali5451
Message-ID: <20030115133217.GA814@schottelius.org>
References: <20021228021630.GA324@schottelius.org> <20030114231141.GF15211@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20030114231141.GF15211@fs.tum.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.54
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adrian Bunk [Wed, Jan 15, 2003 at 12:11:42AM +0100]:
> On Sat, Dec 28, 2002 at 02:16:30AM +0000, Nico Schottelius wrote:
> > trident.o doesn load anymore...
> > while trying to insert it, the whole system hangs.
> >=20
> > flapp:/home/user/nico/ccc/video # modprobe trident
> > /lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: init_module: N=
o such device
> > Hint: insmod errors can be caused by incorrect module parameters, inclu=
ding invalid IO or IRQ parameters.
> >       You may find more information in syslog or the output from dmesg
> > /lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: insmod /lib/mo=
dules/2.4.21-pre2/kernel/drivers/sound/trident.o failed
> > /lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: insmod trident=
 failed
> >...
> > In 2.4.19 it worked, in 2.5.53 the alsa device works, but trident not, =
again.
>=20
> Did 2.4.20 work?

yes, afai can remember. I turned to 2.5.series very early, because of the
ide driver problem in 2.4.19/20.

> If not, please undo the changes below in 2.4.20 (pipe this mail to
> "patch -p1 -R") and check whether this modified 2.4.20 works for you.

can you send me plain modified 2.4.20 trident.c, so I can simlpt insert it
into 2.4.21pre3 ?

Nico

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+JWLhtnlUggLJsX0RAkgFAKCgeWCS1FZ5emjg7YLbh9/33BnzugCdEQro
EPFJDn1Xu9Hb7IWygIPdigg=
=OC2P
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
