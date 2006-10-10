Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWJJQjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWJJQjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWJJQjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:39:42 -0400
Received: from lug-owl.de ([195.71.106.12]:27062 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030192AbWJJQjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:39:41 -0400
Date: Tue, 10 Oct 2006 18:39:40 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jan Kara <jack@suse.cz>
Cc: Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061010163940.GJ30283@lug-owl.de>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <20061009224050.GD30283@lug-owl.de> <20061010131603.GL23622@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IxJdV6DzbRx1uFDf"
Content-Disposition: inline
In-Reply-To: <20061010131603.GL23622@atrey.karlin.mff.cuni.cz>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IxJdV6DzbRx1uFDf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-10 15:16:03 +0200, Jan Kara <jack@suse.cz> wrote:
> > Is this possibly related to the issues that are discussed in another
> > thread? We're seeing problems while unlinking large files (usually get
> > it within some hours with 200MB files, but couldn't yet reproduce it
> > with 20MB.)
>   I don't think this is related (BTW: I've run your test for 5 hours
> without any luck ;( Maybe I'll try again for some longer time...).

Looking at it, I also think it's a different thing.  Just to add, I
couldn't make it bug with a 10 MB file in a day, but it failed again
using a 100MB file.

So file size seems to matter somehow.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                           Wenn ich wach bin, tr=C3=A4ume ic=
h.
  the second  :

--IxJdV6DzbRx1uFDf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFK8zMHb1edYOZ4bsRAl4+AJ4i62GYqsRrYEK4p2Cwx4aL/Hs3cACfeR0F
LO72Ug72yIV5n2TcIBQ+QvA=
=Sq9F
-----END PGP SIGNATURE-----

--IxJdV6DzbRx1uFDf--
