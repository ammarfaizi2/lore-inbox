Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWIWMNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWIWMNa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIWMNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:13:30 -0400
Received: from lug-owl.de ([195.71.106.12]:1928 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750770AbWIWMN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:13:29 -0400
Date: Sat, 23 Sep 2006 14:13:27 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Joerg Roedel <joro-lkml@zlug.org>
Cc: Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Message-ID: <20060923121327.GH30245@lug-owl.de>
Mail-Followup-To: Joerg Roedel <joro-lkml@zlug.org>,
	Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060923120704.GA32284@zlug.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
Content-Disposition: inline
In-Reply-To: <20060923120704.GA32284@zlug.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-09-23 14:07:04 +0200, Joerg Roedel <joro-lkml@zlug.org> wrote:
> This patchset is the resubmit of the Ethernet over IPv4 tunnel driver
> for Linux.  I want to thank all reviewers for their annotations and
> helpfull input.  This version contains some major changes to the driver.
> It uses an own device type now (ARPHRD_ETHERIP). This fixes the problem
> that EtherIP devices could not be safely differenced from Ethernet
> devices. This change also required some other changes. First a second
> patch to the bridge code is included to allow the use of EtherIP devices
> in a bridge.  The third patch includes the necessary changes to iproute2
> (support of the new ARPHRD and general tunnel configuration support for
>  EtherIP).

I haven't seen the first submission, but is this driver really needed?
Can't this be done with creating two tap interfaces on both endpoints
and bridge them with a local ethernet device using userland software?

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:         Alles wird gut! ...und heute wirds schon ein bi=C3=9F=
chen besser.
the second  :

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFFSTnHb1edYOZ4bsRArbeAJ9nes60mAhOlF3paoQ7GWIxNvEX8QCfY9Hn
6fsq1lzih0u6BKOUvmG6heE=
=iHe0
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
