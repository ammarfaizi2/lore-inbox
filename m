Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbRFZPV0>; Tue, 26 Jun 2001 11:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbRFZPVQ>; Tue, 26 Jun 2001 11:21:16 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:29659 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264983AbRFZPVE>; Tue, 26 Jun 2001 11:21:04 -0400
Date: Tue, 26 Jun 2001 16:21:02 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
Message-ID: <20010626162102.F7663@redhat.com>
In-Reply-To: <20010626102303.K7663@redhat.com> <Pine.LNX.4.21.0106261027350.850-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="mi2hulEOATkNQ14l"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106261027350.850-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Jun 26, 2001 at 10:30:41AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mi2hulEOATkNQ14l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2001 at 10:30:41AM -0300, Marcelo Tosatti wrote:

> > - change parport_pc so that it doesn't request parport_serial at
> >   init.  In this case, how will parport_serial get loaded at all?
> >   Perhaps with some recommended /etc/modules.conf lines (perhaps
> >   parport_lowlevel{1,2,3,...})?
>=20
> I think this is sane. This is how it works for parport_pc.

Right.  Actually, setting an alias of parport_lowlevel to
parport_serial would cause the right things to happen I think.

Tim.
*/

--mi2hulEOATkNQ14l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7OKhdONXnILZ4yVIRAoGZAKCfa4/KVFa2FI1+qVXC6p2AFSnfRwCdGZE1
roMOJ58G273O0CJHu9iiAko=
=jU81
-----END PGP SIGNATURE-----

--mi2hulEOATkNQ14l--
