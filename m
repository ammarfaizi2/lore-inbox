Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270684AbTGNRSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270679AbTGNRQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:16:10 -0400
Received: from screech.rychter.com ([212.87.11.114]:1975 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S270684AbTGNRPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:15:21 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
 enhancements
References: <1057963547.3207.22.camel@laptop-linux>
	<20030712140057.GC284@elf.ucw.cz>
	<200307121734.29941.dtor_core@ameritech.net>
	<20030712225143.GA1508@elf.ucw.cz>
	<20030713133517.GD19132@mail.jlokier.co.uk>
	<20030713193114.GD570@elf.ucw.cz>
	<1058130071.1829.2.camel@laptop-linux>
	<20030713210934.GK570@elf.ucw.cz>
	<1058147684.2400.9.camel@laptop-linux>
	<20030714131132.GD221@elf.ucw.cz>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Mon, 14 Jul 2003 10:30:51 -0700
Message-ID: <m2llv1t3qs.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Pavel" =3D=3D Pavel Machek <pavel@suse.cz> writes:
 Pavel> Hi!
 >> Having listened to the arguments, I'll make pressing Escape to
 >> cancel the suspend a feature which defaults to being disabled and
 >> can be enabled via a proc entry in 2.4. I won't add code to poll for
 >> ACPI (or APM) events :>

 Pavel> At least no new proc entry, please. Make it depend on
 Pavel> sysrq_enabled and disable it completely if sysrq support is not
 Pavel> compiled in.

Pavel, I disagree. This is important functionality. I *do* want to abort
suspends by pressing 'Esc'.

I do not believe that hiding this gives you any extra security, and I do
not believe that having it in is any kind of a problem. None of your
arguments against it convinced me.

Please do not try to hide it and obscure it any more than it already is
(Nigel has made this default to off for some reason).

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EujMLth4/7/QhDoRAnNiAJ4jQR2pzEaAUltP4xGlDadY+D2AggCgv37i
mdUKV+x5i53Udi0gjL/UrwU=
=PpHL
-----END PGP SIGNATURE-----
--=-=-=--
