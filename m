Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpOXL+KaBmxI8QAqmq9VIx7wOmw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 23:25:50 +0000
Message-ID: <040101c415a4$e5cdb4e0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Subject: Re: [PATCH] Simplify node/zone field in page->flags
From: "Martin Schlemmer" <azarah@nosferatu.za.org>
Reply-To: <azarah@nosferatu.za.org>
To: <Administrator@osdl.org>
Cc: "Jesse Barnes" <jbarnes@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
        "Linux Kernel Mailing Lists" <linux-kernel@vger.kernel.org>,
        <mbligh@aracnet.com>
In-Reply-To: <3FF9E64D.5080107@us.ibm.com>
References: <3FE74B43.7010407@us.ibm.com> <20031222131126.66bef9a2.akpm@osdl.org> <3FF9D5B1.3080609@us.ibm.com> <20040105213736.GA19859@sgi.com>  <3FF9E64D.5080107@us.ibm.com>
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YkDoCQlgaJq7NRG8nrT5"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 16:45:44 +0100
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:45:45.0578 (UTC) FILETIME=[E64C0CA0:01C415A4]

This is a multi-part message in MIME format.

--=-YkDoCQlgaJq7NRG8nrT5
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-06 at 00:33, Matthew Dobson wrote:
> Jesse Barnes wrote:
> > On Mon, Jan 05, 2004 at 01:22:57PM -0800, Matthew Dobson wrote:
> >=20
> >>Jesse had acked the patch in an earlier itteration.  The only thing=20
> >>that's changed is some line offsets whilst porting the patch forward.
> >>
> >>Jesse (or anyone else?), any objections to this patch as a superset of=20
> >>yours?
> >=20
> >=20
> > No objections here.  Of course, you'll have to rediff against the
> > current tree since that stuff has been merged for awhile now.  On a
> > somewhat related note, Martin mentioned that he'd like to get rid of
> > memblks.  I'm all for that too; they just seem to get in the way.
> >=20
> > Jesse
> >=20
>=20
> Yeah... didn't actually attatch the patch to that last email, did I?=20
> Brain slowly transitioning back into "on" mode after a couple weeks=20
> solidly in the "off" position.
>=20

Get this with gcc-3.3.2 cvs:

--
include/linux/mm.h: In function `page_nodenum':
include/linux/mm.h:337: warning: right shift count >=3D width of type
include/linux/mm.h:337: warning: suggest parentheses around + or -
inside shift
--

Think we could get those () in to make it more clear and the compiler
happy?


Thanks,

--=20
Martin Schlemmer

--=-YkDoCQlgaJq7NRG8nrT5
Content-Transfer-Encoding: 7bit
Content-Type: application/pgp-signature;
	name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+fH/qburzKaJYLYRAt+YAKCJmCt7KcI3ttikeBuT9jf/wJCK1QCgg8Ii
NRAXwbf3JRkoRiQ7FJmJ4LM=
=ivBO
-----END PGP SIGNATURE-----

--=-YkDoCQlgaJq7NRG8nrT5--
