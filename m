Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269842AbUJSRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269842AbUJSRFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269818AbUJSRDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:03:48 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:28086 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S269688AbUJSQ6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:58:24 -0400
Date: Tue, 19 Oct 2004 18:57:20 +0200
From: Martin Waitz <tali@admingilde.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Gerd Knorr <kraxel@bytesex.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041019165720.GF3618@admingilde.org>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Gerd Knorr <kraxel@bytesex.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	penguinppc-team@lists.penguinppc.org
References: <416E6ADC.3007.294DF20D@localhost> <20041018121033.GB5106@bytesex> <20041018202147.GA28720@hh.idb.hist.no> <200410182242.04749.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <200410182242.04749.oliver@neukum.org>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2004 at 10:42:04PM +0200, Oliver Neukum wrote:
> Am Montag, 18. Oktober 2004 22:21 schrieb Helge Hafting:
> > > On first access only, and even that only if the driver doesn't map the
> > > pages at mmap() time already. ?Not a single fb driver seems to map the
> > > pages lazy today, grepping in drivers/video for nopage handles shows
> > > nothing. ?I'm not sure you can actually do that for iomem mappings.
> > >=20
> > Isn't it possible for the driver to unmap the mapping when
> > suspending? ?Then you're guaranteed to get that first access.
>=20
> But what would you do then? Block everything that is using a terminal?

yes

but that wouldn't last long if you run the userspace helper as soon
as you are finished resuming.

One 'only' needs a method to give feedback while loading the image...
I guess we have to rely on the firmware here.
(Eighter it already sets an useable mode or provides a function that
can display test)

--=20
Martin Waitz

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBdUdvj/Eaxd/oD7IRAqujAJoDEg5BLRKM51a58fZPgqcOdZZu2QCfRCoI
rVob2PU1RxE+a6bZQzT29CE=
=SVtM
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
