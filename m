Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUJQMIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUJQMIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 08:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUJQMIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 08:08:18 -0400
Received: from admingilde.org ([213.95.21.5]:2265 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S269050AbUJQMIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 08:08:15 -0400
Date: Sun, 17 Oct 2004 14:07:28 +0200
From: Martin Waitz <tali@admingilde.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041017120728.GC10532@admingilde.org>
Mail-Followup-To: Gerd Knorr <kraxel@bytesex.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	penguinppc-team@lists.penguinppc.org
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <87y8i8p1jq.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <87y8i8p1jq.fsf@bytesex.org>
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
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:041017:kraxel@bytesex.org:c2c57b235565f2ce
X-Hashcash: 0:041017:penguinppc-team@lists.penguinppc.org:b4e7e57fb3618ca3
X-Hashcash: 0:041017:linux-fbdev-devel@lists.sourceforge.net:11b9b3a8c0ae4578
X-Hashcash: 0:041017:linux-kernel@vger.kernel.org:20f5bbafcd47a311
X-Spam-Score: -11.1 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Fri, Oct 15, 2004 at 03:13:13PM +0200, Gerd Knorr wrote:
> You have a application running which uses the framebuffer device, then
> suspend with that app running.  You'll have to restore the state of
> the device _before_ restarting all the userspace proccesses, otherwise
> the app will not be very happy.

As long as the app only interfaces with the framebuffer device and not
directly with the hardware it won't notice.
The apps data will simply not show up on the screen until the
usermode helper finishes.

--=20
Martin Waitz

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcmCAj/Eaxd/oD7IRApmhAJ45kTqnLsgLQHd8x9hUTFZmCxAHYwCggy7v
Qh14l7v0bNmkxsgj9b2qazQ=
=61cb
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

