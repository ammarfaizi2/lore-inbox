Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVCAIYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVCAIYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVCAIYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:24:48 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:40617 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261287AbVCAIXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:23:11 -0500
Date: Tue, 1 Mar 2005 09:22:54 +0100
From: martin f krafft <madduck@madduck.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050301082254.GA4402@piper.madduck.net>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Pavel Machek <pavel@suse.cz>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050227174309.GA27265@piper.madduck.net> <20050228135604.GA6364@piper.madduck.net> <200502281533.01621.rjw@sisk.pl> <20050228144506.GA11125@piper.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <<20050228144723.GA3384@elf.ucw.cz>
X-OS: Debian GNU/Linux 3.1 kernel 2.6.10-9-amd64-k8 x86_64
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Pavel Machek <pavel () ucw ! cz>
> > > Could you, please, verify that you don't need to load any
> > > modules from initrd for your swap partition to work?  It won't
> > > work if you do.
> >=20
> > this makes perfect sense to me when you talk about resuming.
> > does it also apply to suspending?
>=20
> As kernel is the same for suspend and resume... Yes, it seems it
> makes sense.

But before the suspend, the IDE modules are loaded, so the swap
drive is accessible, no? Or are IDE modules (yes, they are modules
here) unloaded just before writing to swap?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
man muss noch chaos in sich haben
um einen tanzenden stern zu geb=E4hren.
                                                -- friedrich nietzsche

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCJCZeIgvIgzMMSnURAv+ZAJ4qqLKgKeNazu1tQDRVS31wxwfyQgCdFwht
d9RQ1gszQC+MbDA9xbd1nsM=
=K1PC
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
