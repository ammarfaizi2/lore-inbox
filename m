Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293635AbSCSEFv>; Mon, 18 Mar 2002 23:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293642AbSCSEFl>; Mon, 18 Mar 2002 23:05:41 -0500
Received: from runyon.sfbay.redhat.com ([205.180.230.5]:42669 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S293635AbSCSEF1>;
	Mon, 18 Mar 2002 23:05:27 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
From: Ulrich Drepper <drepper@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: martin.wirth@dlr.de, pwaechtler@loewe-komp.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020319142842.0d9291c2.rusty@rustcorp.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-X0SC+Xq0obMic1jWcTOl"
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 18 Mar 2002 20:05:22 -0800
Message-Id: <1016510722.2194.101.camel@myware.mynet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X0SC+Xq0obMic1jWcTOl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-03-18 at 19:28, Rusty Russell wrote:

> What do you WANT in a kernel primitive then?  Given that we now have mute=
xes,
> what else do we need to make pthreads relatively painless?

I think wrt to the mutexes only wake-all is missing.  I don't think that
semaphore semantic is needed in the kernel.


> Look, here is an example implementation.  Please suggest:
> 1) Where this is flawed,
> 2) Where this is suboptimal,
> 3) What kernel primitive would help to resolve these?

I'll look at this a bit later.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-X0SC+Xq0obMic1jWcTOl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8lrkC2ijCOnn/RHQRAlmAAKCFCfLE8PViVZ7PLJbVi655M6NBugCfWrWs
Ffwv34UNO8d2D4fJxOEKcXs=
=zRE8
-----END PGP SIGNATURE-----

--=-X0SC+Xq0obMic1jWcTOl--

