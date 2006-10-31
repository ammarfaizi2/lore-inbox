Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423408AbWJaRCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423408AbWJaRCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423676AbWJaRCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:02:18 -0500
Received: from fysh.org ([83.170.75.51]:2993 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S1423408AbWJaRCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:02:16 -0500
Date: Tue, 31 Oct 2006 17:02:09 +0000
From: Athanasius <link@miggy.org>
To: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Subject: CONFIG_USB_USBNET and mii_* (was Re: Linux 2.6.19-rc4)
Message-ID: <20061031170209.GN21200@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, toralf.foerster@gmx.de,
	netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	greg@kroah.com, akpm@osdl.org, zippel@linux-m68k.org,
	dbrownell@users.sourceforge.net
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2006 at 08:27:17PM -0800, Linus Torvalds wrote:
> Before I forget, I'd like to thank Adrian Bunk for his regressions=20
> listings, and ask people who are involved with those (both on the blamer=
=20
> and blamee sides) to follow them, and keep making sure that we get them=
=20
> resolved - if only by reminding people about the issues, and testing that=
=20
> things that are claimed to be resolved really are.

  In that light, although it's not being counted as a regression, my
report about CONFIG_USB_USBNET stuff starting to make use of mii_* stuff
in 19-rc3, without making SURE it's available is still outstanding,
unfixed, in 19-rc4 (checked just now by untarring a fresh 2.6.18 copy,
applying the rc4 patch, copying in the known-broken .config from rc3,
make oldconfig, then my usual make bzImage && make modules).
  I've pootled around 'make menuconfig' as well, 'N' and then re-Y/M'ing
USBNET things and it has no effect on the PHYLIB stuff.

  I know patches were flying around in the discussion, have none of them
been shaken down sufficiently for inclusion or has the final patch
simply not been pushed to/seen by Linus yet?

  'Ironically' I don't actually _use_ the usbnet stuff, I'd only enabled
it in case my gf pestered me to test her bluetooth dongle for some
reason.  Thus I'm only likely to keep tabs on this if I specifically
think to, it won't show up in my normal usage patterns.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFR4GQIr2uvLNOS8MRAv2pAJ4jiQktkev8xwk/+J1IaPl49c4L9QCcCYUO
ecvhd1uCu+fW56rEkZ8oQIA=
=QlQn
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
