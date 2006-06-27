Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWF0MQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWF0MQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWF0MQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:16:11 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16512 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751187AbWF0MQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:16:09 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend2][ 1/2] [Suspend2] Disable load updating during suspending.
Date: Tue, 27 Jun 2006 22:16:03 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net> <20060626163852.10345.788.stgit@nigel.suspend2.net> <20060627120740.GA3019@elf.ucw.cz>
In-Reply-To: <20060627120740.GA3019@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2712489.l7IdYqonDV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606272216.07960.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2712489.l7IdYqonDV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 22:07, Pavel Machek wrote:
> Hi!
>
> > Suspend2 uses the cpu very intensively, with the result that the load
> > average can be quite high when a cycle has just completed. This in turn
> > can cause problems with mail delivery and other activities that suspend
> > activities when the load average gets too high. To avoid this, we suspe=
nd
> > updates of the load average while the freezer is on.
>
> If we want to do this at all... why not simply set load average to
> zero when resume is done?
>
> After all, system probably was completely idle for quite a while :-).

Yeah, that's a possibility. Neither seems inherently better to me. Maybe=20
others will come up with an argument for one or the other?

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2712489.l7IdYqonDV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoSGHN0y+n1M3mo0RAqaRAKDULP6oQ70faCfOUg1Sh9y1xnFHwwCg0OvX
RLdTyEmpy6/RoRMBLxa1ZEg=
=GlCc
-----END PGP SIGNATURE-----

--nextPart2712489.l7IdYqonDV--
