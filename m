Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267689AbTBUUn3>; Fri, 21 Feb 2003 15:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTBUUn3>; Fri, 21 Feb 2003 15:43:29 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:51985 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S267689AbTBUUn2>;
	Fri, 21 Feb 2003 15:43:28 -0500
Date: Fri, 21 Feb 2003 15:53:33 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: John Bradford <john@grabjohn.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
Message-ID: <20030221205333.GA1684@babylon.d2dc.net>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200302212013.h1LKD6Cu014437@turing-police.cc.vt.edu> <200302212040.h1LKejY3001679@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <200302212040.h1LKejY3001679@81-2-122-30.bradfords.org.uk>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

</lurk>

On Fri, Feb 21, 2003 at 08:40:45PM +0000, John Bradford wrote:
> > RFC3168 section 6.1.1.1 says this:
> >=20
> >    A host that receives no reply to an ECN-setup SYN within the normal
> >    SYN retransmission timeout interval MAY resend the SYN and any
> >    subsequent SYN retransmissions with CWR and ECE cleared.  To overcome
> >    normal packet loss that results in the original SYN being lost, the
> >    originating host may retransmit one or more ECN-setup SYN packets
> >    before giving up and retransmitting the SYN with the CWR and ECE bits
> >    cleared.
> >=20
> > Supporting this would make using ECN a lot less painful - currently, if
> > I want to use ECN by default, I get to turn it off anytime I find an
> > ECN-hostile site that I'd like to communicate with.
>=20
> Linux shouldn't encourage the use of equipment that violates RFCs, in
> this case, RFC 739.

Linux shouldn't encourage the use of equipment that attempts to emulate
<insert thing here> but screws it up.
>=20
> The correct way to deal with it, is to contact the maintainers of the
> site, and ask them to fix the non conforming equipment.

The correct way to deal with it, is to contact the manufactures of the
equipment.
>=20
> If the problem is caused upstream, by equipment out of the
> site's maintainers' control, it is their responsibility to contact the
> relevant maintainers, or change their upstream provider.

If the hardware is provided by people upstream, and is out of the
control of the sysadmin's control, it is their responsibility to contact
the relevant people, or change hardware providers.

Oh, look, does that mean that we can now remove all the work arounds in
the various network, ide, etc drivers?

No, I believe Linus has stated many times that Linux is not a research
project, it is meant to actually be USED.

<lurk>

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

I am an "expert".  Fear me, for I will wreak untold damage upon anything
I can get my grubby hands on.
  -- Matt McLeod on ASR.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+VpHNRFMAi+ZaeAERAnlqAKCr8Dwv79cn6yZ4W5C2/RRap+wfYQCeNwTp
D66ZhoeOAhZBsoepbJuRbRE=
=fAcM
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
