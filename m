Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284376AbRLENBu>; Wed, 5 Dec 2001 08:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284382AbRLENBb>; Wed, 5 Dec 2001 08:01:31 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:28430 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S284379AbRLENB1>;
	Wed, 5 Dec 2001 08:01:27 -0500
Date: Wed, 5 Dec 2001 13:37:20 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-0.9.16 against linux-2.4.17-pre2
Message-ID: <20011205133720.D4916@paradigm.rfc822.org>
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au> <20011205133204.C4916@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <20011205133204.C4916@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2001 at 01:32:04PM +0100, Florian Lohoff wrote:
> It seems something broken between 2.4.15-pre2 and this update - I am
> seeing filesystem corruption:
>=20
> Procmail moans about "locked" mailboxes - Opening them shows that
> the last mail originates about 4 hours ago although there are coming
> mails every minute.
>=20
> procmail: Extraneous locallockfile ignored
> procmail: Error while writing to "countpl/20011205"
> procmail: Truncated file to former size
> procmail: Error while writing to "archive/received-200112"
> procmail: Truncated file to former size
> From flo@mediaways.net  Wed Dec  5 13:25:37 2001
>  Subject: Cron <nwmgmt@mgr1> /aol/bin/count.pl
>    Folder: /home/flo/Mail/inbox
>=20
> (flo@ping)~# ls -la Mail/countpl/20011205 Mail/archive/received-200112
> -rw-------    1 flo      flo      51200000 Dec  5 13:25 Mail/archive/rece=
ived-200112
> -rw-------    1 flo      flo      51200000 Dec  5 13:25 Mail/countpl/2001=
1205
>=20
> The last lines of the countpl/20011205 file contain 0 - Cut'n'pasted
> from "most".

Hand me the brown paperbag and let me die in shame :) Postfix the=20
ulimit tweaker bit me again ....

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8DhUAUaz2rXW+gJcRAlRFAKC8MD2HlK5+imRtofFE+UxyRQoJcgCbB9lq
/0Js/Djv9pSaKH66yDsQVnw=
=Hu3L
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
