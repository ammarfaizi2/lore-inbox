Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQK3VQA>; Thu, 30 Nov 2000 16:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129815AbQK3VPu>; Thu, 30 Nov 2000 16:15:50 -0500
Received: from ns.snowman.net ([63.80.4.34]:520 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S129480AbQK3VPp>;
	Thu, 30 Nov 2000 16:15:45 -0500
Date: Thu, 30 Nov 2000 15:43:28 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Jeroen Geusebroek <Jeroen.Geusebroek@osc.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 & Eepro(10)
Message-ID: <20001130154328.W26953@ns>
Mail-Followup-To: Jeroen Geusebroek <Jeroen.Geusebroek@osc.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <NCBBJKHJIKHIFECNNOAMKEDLDLAA.Jeroen.Geusebroek@osc.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4dbYIUm7Fhfg+fSv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NCBBJKHJIKHIFECNNOAMKEDLDLAA.Jeroen.Geusebroek@osc.nl>; from Jeroen.Geusebroek@osc.nl on Thu, Nov 30, 2000 at 09:13:32PM +0100
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 8:28am  up 89 days, 12:22,  4 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4dbYIUm7Fhfg+fSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Jeroen Geusebroek (Jeroen.Geusebroek@osc.nl) wrote:
>=20
> I'm having troubles with the eepro driver included in kernel 2.2.17.
> It stops sometimes with no apparent reason. The one thing i noticed
> is that it seems to have a lot of carrier problems(998!)
>=20
> This is part of the result from ifconfig:
>=20
> eth1      Link encap:Ethernet  HWaddr 00:AA:00:A6:05:01 =20
>           inet addr:24.132.xx.xxx  Bcast:24.132.xx.xxx  Mask:255.255.254.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:248714 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:64711 errors:1925 dropped:0 overruns:0 carrier:998
>           collisions:832 txqueuelen:100=20
>           Interrupt:10 Base address:0x230

	I have similar problems, though I don't have any carrier problems:

eth0      Link encap:Ethernet  HWaddr 00:A0:C9:66:12:9B =20
          inet addr:xx.xx.xx.xx  Bcast:xx.xx.xx.xx  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:214835 errors:0 dropped:0 overruns:0 frame:0
          TX packets:33050 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          Interrupt:9 Base address:0xe0e0=20

	Seems to just drop out when there hasn't been any activity for
a while for me though.  Give it about 10-15 seconds and it comes back.

> Needless to say i didn't have this problem with previous kernels
> (including 2.2.16).

Linux junior 2.2.17-raid #1 Wed Nov 8 07:48:57 EST 2000 i686 unknown

	I didn't run this machine very long w/ 2.2.16 so I don't really
know if previous versions had the same problem.  If I have some time,
perhaps over the weekend, I'll try and find out.

		Stephen

--4dbYIUm7Fhfg+fSv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6JrvwrzgMPqB3kigRAmxxAJ9sR6BxBh9d7OUkOBC4gCInai1aIQCZASaa
wG1KwKM2kX3w3rRK8LRITQA=
=fHB2
-----END PGP SIGNATURE-----

--4dbYIUm7Fhfg+fSv--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
