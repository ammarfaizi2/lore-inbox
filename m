Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318565AbSHGL5l>; Wed, 7 Aug 2002 07:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318588AbSHGL5k>; Wed, 7 Aug 2002 07:57:40 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:16055 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S318565AbSHGL5i>;
	Wed, 7 Aug 2002 07:57:38 -0400
Date: Wed, 7 Aug 2002 14:05:06 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dax Kelson <dax@gurulabs.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
Message-ID: <20020807140506.A12417@crystal.2d3d.co.za>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Dax Kelson <dax@gurulabs.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208062318350.4696-100000@mooru.gurulabs.com> <Pine.LNX.3.95.1020807070841.28061A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1020807070841.28061A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Aug 07, 2002 at 07:18:17 -0400
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 1:55pm  up 7 days, 19:12, 10 users,  load average: 0.02, 0.07, 0.03
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard!

This whole argument is useless anyway. The ethtool API already allows
userland apps to change the eeprom, so you can already change the MAC
address (which I also believe is the way it should be, because that allows
manufacturers to program the MAC address without requiring additional
drivers).

People don't like to break their hardware for the fun of it. You don't see
people reprogramming their memory eeproms using the i2c code, but the
functionality is there. I think ripping out all kinds of functionality just
because there is a slight chance of some stupid person trashing his/her
hardware is unproductive and contrary to the spirit of open and free softwa=
re.

> > > If you let a user write to this area, you will allow the user
> > > to destroy the connectivity on a LAN.
> > >=20
> > > Because of this, there is no such thing as 'unused eeprom space' in
> > > the Ethernet Controllers. Be careful about putting this weapon in
> > > the hands of the 'public'. All you need is for one Linux Machine
> > > on a LAN to end up with the same IEEE Station Address as another
> > > on that LAN and connectivity to everything on that segment will
> > > stop. You do this once at an important site and Linux will get a
> > > very black eye.
> >=20
> > Dick, this "weapon" has been the in the hands of admins and evil-doers =
for=20
> > YEARS!
> >=20
> > It is called /sbin/ifconfig
> >=20
> > With this evil command nearly any NIC can masquerade as any one of
> > ~281474976710656 possible IEEE Station Addresses. This weapon of
> > destruction has seen wide spread proliferation across most Unix varient=
s.
> > Human sacrifice, dogs and cats living together, mass hysteria!
> >=20
> > Err, no wait.
> >=20
> > The sky is not falling, you protest too much.
> >=20
> > Dax Kelson
> >=20
>=20
> That capability is not permanent. If you let users write to the
> SEEPROM, permanently changing the IEEE Station Address, you have
> let users permanently break their network boards. I do protest
> when this capability is in the kernel.
>=20
> Anybody, who knows how can, write a driver that can destroy their
> disk drives, their modems, their audio boards, their screen-cards,
> their motherboards, ...the list goes on..., because EEPROMS are
> being used now days. But, you don't put that capability in the
> kernel as a default.
>=20
> If you do, you get complaints from those who have had the misfortune of
> being interrogated by lawyers.
>=20
> Also, if you want to destroy Ethernet, mucking with the MAC address
> is an easy way to do it.

--=20

Regards
 Abraham

Luck can't last a lifetime, unless you die young.
		-- Russell Banks

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9UQzyzNXhP0RCUqMRAkA/AJ0XeMXP6yceSc3eTqDLxk8thd6XnwCdHwKJ
vg9JEsDG5ghnj3mGTd6OlgE=
=LVm1
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
