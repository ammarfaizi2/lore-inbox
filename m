Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSKTVIa>; Wed, 20 Nov 2002 16:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSKTVIa>; Wed, 20 Nov 2002 16:08:30 -0500
Received: from evrtwa1-ar9-4-65-243-140.evrtwa1.dsl-verizon.net ([4.65.243.140]:60578
	"EHLO erping.omgwallhack.org") by vger.kernel.org with ESMTP
	id <S262580AbSKTVIZ>; Wed, 20 Nov 2002 16:08:25 -0500
Subject: Re: Prism 2.5 Wavelan chipset
From: Jules Kongslie <chatos@omgwallhack.org>
To: Karen Shaeffer <shaeffer@neuralscape.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021119153059.A5143@synapse.neuralscape.com>
References: <20021119153059.A5143@synapse.neuralscape.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bmBgfy7y2guL8aaJeQMR"
Organization: 
Message-Id: <1037826932.7092.6.camel@cassius.omgwallhack.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Nov 2002 13:15:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bmBgfy7y2guL8aaJeQMR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-11-19 at 15:30, Karen Shaeffer wrote:
> Hi folks,
>=20
> I have an IBM A31 with the pci bus Prism 2.5 Wavelan chipset (rev 01) tha=
t
> supports 802.11b wireless. I've googled around for quite awhile but am no=
t
> convinced I have answered my questions.

I've got the same machine. Nice, isn't it?

> I have wireless up and running on the laptop with a 2.4.19 kernel. It's a
> red hat 8.0 distribution on the computer. But there is some indication fr=
om
> my google searches that this Prism 2.5 based system won't perform well wi=
th
> the mainstream kernel's orinoco driver. Folks suggest the wlan-ng driver =
from=20
>=20
> http://www.linux-wlan.com/linux-wlan/

That's what I do. The linux-wlan-ng prism_pci driver is much stabler on
my machine than the in-kernel code. The only problem is that, depending
on the kernel version you're using, you might have to make small changes
to the code so that it's using the same version of the wireless
extensions.

> I'd like to stick with the main kernel code. I see in the kernel archives
> that there are related patches going into the 2.5.x kernel. Which kernel
> version is best suited for my needs?=20

I have a fine time with 2.4.19-ac4 and linux-wlan-ng 0.1.16-pre1. If you
want to use the in-kernel code, I'd suggest using the newest 2.5 you can
get working -- but you won't have a very easy time with it. The kernel
code seems to have a tendency to drop quite a few packets.

> Finally, I have installed a pci to pcmcia converter and an orinoco gold
> pcmcia card on a pc that I want to use to establish an access point with.
> Does the kernel currently support this? If so, what version?

That it typically called a "PLX" card, and both the kernel orinoco
drivers and the linux-wlan-ng drivers support them. Again, I suggest the
linux-wlan-ng modules above the kernel code.

> Thank you for any comments.
>=20
> cheers,
> Karen

--=20
Jules Kongslie <chatos@omgwallhack.org>

--=-bmBgfy7y2guL8aaJeQMR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92/t0jaoVo7RzSSwRAtG8AJ920dCd1YD4EzPdJylsFtSS7FX5cwCgzg7W
ORFkhx10rQL94oFCx6itKOI=
=WJIJ
-----END PGP SIGNATURE-----

--=-bmBgfy7y2guL8aaJeQMR--
