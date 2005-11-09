Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbVKIAOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbVKIAOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbVKIAOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:14:21 -0500
Received: from zlynx.org ([199.45.143.209]:43020 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S1030440AbVKIAOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:14:20 -0500
Subject: Re: typedefs and structs
From: Zan Lynx <zlynx@acm.org>
To: David Gibson <dwg@au1.ibm.com>
Cc: linas <linas@austin.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <20051108235759.GA28271@localhost.localdomain>
References: <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
	 <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com>
	 <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com>
	 <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com>
	 <20051107204136.GG19593@austin.ibm.com>
	 <1131412273.14381.142.camel@localhost.localdomain>
	 <20051108232327.GA19593@austin.ibm.com>
	 <20051108235759.GA28271@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DoEz994RyBYnVPghOvkN"
Date: Tue, 08 Nov 2005 17:13:48 -0700
Message-Id: <1131495228.12797.67.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DoEz994RyBYnVPghOvkN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-09 at 10:57 +1100, David Gibson wrote:
> On Tue, Nov 08, 2005 at 05:23:27PM -0600, Linas Vepstas wrote:
[snip]
> > The ampersand says "pass argument by reference (so as to get arg passin=
g
> > efficiency) but force coder to write code as if they were passing by va=
lue"
> > As a result, it gets difficult to pass null pointers (for reasons
> > similar to the difficulty of passing null pointers in Java (and yes,
> > I loathe Java, sorry to subject you to that))  Anyway, that's a C++ tri=
ck=20
> > only; I wish it was in C so I could experiment more and find out if I=20
> > like it or hate it.
>=20
> I hate it: it obscures the fact that it's a pass-by-reference at the
> callsite, which is useful information.  Although this is, admittedly,
> the least confusing use of C++ reference types.

I agree with you about that one.  It's yet another thing for C
programmers to have to learn to watch for C++ doing behind your back.

However, it isn't any worse than having an ordinary C pointer to some
struct.  If the pointer was passed to the current function from above,
and you're passing it to another function below, you really don't know
what's going to happen to the structure unless you go look.  Just like
the C++ reference, the C pointer doesn't get an address-of operator to
remind you.
--=20
Zan Lynx <zlynx@acm.org>

--=-DoEz994RyBYnVPghOvkN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDcT86G8fHaOLTWwgRAiYnAJ425SV4gyJ/gnrRrP/mLqYh4o2ApgCdF7Hs
rtRLUoY2K7LsxYXoArfvqdo=
=VLcK
-----END PGP SIGNATURE-----

--=-DoEz994RyBYnVPghOvkN--

