Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRKSLil>; Mon, 19 Nov 2001 06:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278163AbRKSLib>; Mon, 19 Nov 2001 06:38:31 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:4837 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S278085AbRKSLiR>; Mon, 19 Nov 2001 06:38:17 -0500
Date: Mon, 19 Nov 2001 12:26:20 +0100
From: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Weird PCMCIA behavior
Message-ID: <20011119122619.E3353@online.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011118180656.A18252@temp123.org> <3BF84297.7FB77B3B@mandrakesoft.com> <20011118182903.A18291@temp123.org> <3BF847D1.54532522@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <3BF847D1.54532522@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: "debian SID Gnu/Linux 2.4.15-pre6 on i586"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 18, 2001 at 06:44:17PM -0500, Jeff Garzik wrote:
> Nope.  CardBus looks like hotplug PCI to the kernel, so all normal PCI
> drivers automagically work as CardBus drivers.  You actually need no
> userspace tools at all..

In my undertanding, if you compile drivers for your cardbus and for
attached peripherals as modules (and that make sense for cardbus
hardware), then you need the 'hotplug' userspace tool.

This tool is informed by the kernel that a new device is in and then is
responsible to insmod the correct driver(s) (mainly by looking in
modules.pcimap and friends) and to setup things like setup a network
when a network card is inserted ...

Is that wrong ?

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE7+Oxbj0UvHtcstB4RAiSTAJ99q+Yys5Iyy2JNjr1I6D/pfsJ1gACfcG77
WhTsKUWWyWQddbEiFbG2HD0=
=ASZ0
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
