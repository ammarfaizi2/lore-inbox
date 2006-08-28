Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWH1HZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWH1HZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWH1HZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:25:05 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:26037 "EHLO
	mail.arcor.de") by vger.kernel.org with ESMTP id S932265AbWH1HZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:25:03 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: Linux v2.6.18-rc5
Date: Mon, 28 Aug 2006 09:24:47 +0200
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Perkel <marc@perkel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACurrid@nvidia.com, len.brown@intel.com
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <Pine.LNX.4.64.0608272246350.27779@g5.osdl.org> <20060828061302.GA45823@muc.de>
In-Reply-To: <20060828061302.GA45823@muc.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6989448.DmivDvtaWP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608280924.47968.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6989448.DmivDvtaWP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 28 August 2006 08:13 schrieb Andi Kleen:
> On Sun, Aug 27, 2006 at 10:52:06PM -0700, Linus Torvalds wrote:
> > On Sun, 27 Aug 2006, Marc Perkel wrote:
> > > You might want to look at this bug.
> > >
> > > http://bugzilla.kernel.org/show_bug.cgi?id=3D6975
> > >
> > > The current kernel doesn't run on Asus Motherboards that use the new
> > > AM2 CPUs.
>
> That sounds like a overly broad statement. How do you know
> it affects all Asus boards and not just your specific BIO version?
>
> > > Should this be addressed before 2.6.18 is finished?
> >
> > Hmm. Can you verify that the system boots fine if you get rid of
> > acpi_skip_timer_override as per the hint from Prakash Punnoor?
>
> We already should disable it on NF5 automatically. Timer override was all
> broken on NF3/NF4, but apparently works on NF5 again.
>
> But the check relies on HPET being present. Maybe Asus "forgot"
> to set up the HPET table again and the test fails.

At least my dmesg says nothing about hpet and thus wan't to enable the quir=
k.=20
It is a nforce430 (thus nf4) chipset, though. You can find my bootlog here:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115545986619977&w=3D2

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart6989448.DmivDvtaWP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE8po/xU2n/+9+t5gRAvGgAJ94e2A3nmUD7LOOSbSHAViM5l5SAwCgrYe5
6OV/4MvikC6N1nFCgY/kC8M=
=wx7U
-----END PGP SIGNATURE-----

--nextPart6989448.DmivDvtaWP--
