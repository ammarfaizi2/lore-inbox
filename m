Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270796AbTGPJAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 05:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbTGPJAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 05:00:08 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:16512 "EHLO
	hera.eugeneteo.net") by vger.kernel.org with ESMTP id S270796AbTGPJAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 05:00:00 -0400
Date: Wed, 16 Jul 2003 17:14:50 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Supphachoke Suntiwichaya <mrchoke@opentle.org>
Cc: Eugene Teo <eugene.teo@eugeneteo.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre6 + alsa 0.9.5 + i810 not work
Message-ID: <20030716091450.GA2578@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <3F150561.5040903@opentle.org> <20030716081350.GA8976@eugeneteo.net> <3F150E84.60209@opentle.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <3F150E84.60209@opentle.org>
X-Operating-System: Linux 2.6.0-test1-mm1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<quote sender=3D"Supphachoke Suntiwichaya">
> Eugene Teo wrote:
>=20
> >>Intel 810 + AC97 Audio, version 0.24, 11:19:13 Jul 16 2003
> >>i810_rng: RNG not detected
> >
> >Looks like the same specs as I have for Fujitsu E-7010.
> >
> >Have you tried choosing (Y), instead of compiling it as modules?
> >
> >// Intel ICH (i8xx), SiS 7012, NVidia nForce Audio or AMD 768/811x
> >CONFIG_SOUND_ICH=3Dy=20
> >
> hmm... I think if say y I can't use ALSA ?

I guess so. Personally, I have not tried the ALSA drivers. However,
=66rom what I heard from my buddy who is also using the same laptop
as I do, the ALSA driver for this soundcard don't work very well if
you play DVD, doesn't work well with swsusp, and it seems to "scratch"
if there is heavy traffic on the NIC. I have been using OSS drivers
for this, and I have not experienced any problems at all.

Eugene
--=20
Eugene TEO @ Linux Users Group, Singapore <eugeneteo@lugs.org.sg>
GPG FP: D851 4574 E357 469C D308  A01E 7321 A38A 14A0 DDE5=20
main(i){putchar(182623909>>(i-1)*5&31|!!(i<7)<<6)&&main(++i);}


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FReKcyGjihSg3eURAmQIAJ40x8bPrT9/WRmZibja0lG70gURKwCfX5ER
8Vlrn7IwrXO39RallyRBfvA=
=nml9
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
