Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272373AbTGaGHD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272395AbTGaGHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:07:03 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:31441 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272373AbTGaGHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:07:00 -0400
Date: Thu, 31 Jul 2003 08:06:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
Message-ID: <20030731060659.GK1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <200307302252.h6UMq7aw024159@harpo.it.uu.se> <1059607019.14771.117.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1G7eoSzW1hxPALpv"
Content-Disposition: inline
In-Reply-To: <1059607019.14771.117.camel@w-jstultz2.beaverton.ibm.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1G7eoSzW1hxPALpv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-07-30 16:16:59 -0700, john stultz <johnstul@us.ibm.com>
wrote in message <1059607019.14771.117.camel@w-jstultz2.beaverton.ibm.com>:
> On Wed, 2003-07-30 at 15:52, Mikael Pettersson wrote:
> > On 30 Jul 2003 13:08:44 -0700, john stultz <johnstul@us.ibm.com> wrote:

> Regardless, as you've demonstrated, it seems 486s just can't keep up w/
> HZ=3D1000. Maybe we need to look into some sort of processor specific HZ
> config option?

I'd like to see that. Eventually, I'll post some patch to do that, but
first, I need to make Debian to support i386 again (since libstdc++5 in
unstable is now compiled for i486, some apps (apt-get is one of
those...) will SIGILLed to death). I do have some of those boxes (Am386
with SIMM RAM, i386SX-16 with SIPP modules + single ICs :)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--1G7eoSzW1hxPALpv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KLIDHb1edYOZ4bsRAsrGAJ9kxhvqP8NQ2MJ5cZzB1tKnYTlDhgCdGtrv
3OCmBli9N/1yE4fOeWq0Srg=
=Bsni
-----END PGP SIGNATURE-----

--1G7eoSzW1hxPALpv--
