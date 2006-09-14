Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWINPwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWINPwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWINPwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:52:04 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:37073 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750899AbWINPwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:52:01 -0400
Date: Thu, 14 Sep 2006 11:51:59 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 1/11] LTTng-core 0.5.108 : build
Message-ID: <20060914155159.GD29906@Krystal>
References: <20060914034030.GB2194@Krystal> <20060914074922.GR17042@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-30200-1158249119-0001-2"
Content-Disposition: inline
In-Reply-To: <20060914074922.GR17042@admingilde.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:46:57 up 22 days, 12:55,  8 users,  load average: 0.16, 0.17, 0.17
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-30200-1158249119-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Martin Waitz (tali@admingilde.org) wrote:
> hoi :)
>=20
> On Wed, Sep 13, 2006 at 11:40:30PM -0400, Mathieu Desnoyers wrote:
> > 1- LTTng menu options and Makefiles
>=20
> adding Makefiles before the needed .c files breaks bisecting.
>=20
Ok, next time I will send the patches in a different order.
(meanwhile, you can apply this patch at the end)

> > (do not enable blktrace for now : kernel/relay.o is disabled)
>=20
> If kernel/relay.c becomes obsolete, then perhaps this should be a separate
> patch, removing it entirely.
>=20

No, it is not. It's a temporary solution only used because relayfs has been=
 such
a moving target lately that I decided to wait for things to settle down bef=
ore
switching. I plan to switch to the new relay.o and use DebugFS for filesyst=
em. I
just haven't done the change yet.

Mathieu


> --=20
> Martin Waitz


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-30200-1158249119-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFCXqfPyWo/juummgRApZmAKCdpBr2R+cuEVxTxzUEmBxIMLhGDwCfRCDI
PB7a6hugWXk8lrijdj7Y5TU=
=JtAA
-----END PGP SIGNATURE-----

--=_Krystal-30200-1158249119-0001-2--
