Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTBNQqa>; Fri, 14 Feb 2003 11:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTBNQqa>; Fri, 14 Feb 2003 11:46:30 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:27146 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S261364AbTBNQq2>;
	Fri, 14 Feb 2003 11:46:28 -0500
Date: Fri, 14 Feb 2003 11:56:19 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.60
Message-ID: <20030214165619.GA1178@babylon.d2dc.net>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com> <20030211151615.GA1310@babylon.d2dc.net> <20030211144724.25de5820.akpm@digeo.com> <20030211145415.71ccf594.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20030211145415.71ccf594.akpm@digeo.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2003 at 02:54:15PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@digeo.com> wrote:
> >
> > "Zephaniah E\. Hull" <warp@mercury.d2dc.net> wrote:
> > >
> > > Interesting BUG() on boot up.
> > >=20
> >=20
> > The EATA driver's locking in there is so wrong I don't know how to begi=
n to
> > describe it ;)  Looks like a misguided cli() conversion.
> >=20
> > Does this get you up and running?
> >=20
>=20
> This one is better.

Sorry it took so long, but this patch seems to work perfectly.

Do you need anything from me to get it into Linus' tree?

Zephaniah E. Hull.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

>> Bloody hell.  If I were as stupid as everyone else, I'd kill myself this
>> _morning_.
>No you wouldn't.  You'd be too stupid to know how.

And that's why sysadmins perform a necessary public service, helping
lusers who can't find Darwin with both hands and a roadmap.
  -- Alan J Rosenthal, Graham Reed, and Anthony de Boer in the SDM.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+TR+zRFMAi+ZaeAERAtm0AJ4zlrRKnoVZBWdahIqaXXnXIiUWHQCeJ8L1
HVkkBYrYQxJlkOLczbjUBhA=
=Emb4
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
