Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTEJVRr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 17:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTEJVRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 17:17:46 -0400
Received: from polaris.galacticasoftware.com ([206.45.95.222]:31104 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id S264513AbTEJVRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 17:17:45 -0400
From: "Adam Majer" <adamm@galacticasoftware.com>
Date: Sat, 10 May 2003 16:25:48 -0500
To: Bernhard Kaindl <bk@suse.de>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ptrace secfix does NOT work... :(
Message-ID: <20030510212548.GA1371@galacticasoftware.com>
References: <Pine.LNX.4.44.0305082310230.12720-200000@wotan.suse.de> <20030510205249.GA1179@galacticasoftware.com> <20030510211154.GA4559@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20030510211154.GA4559@nevyn.them.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2003 at 05:11:54PM -0400, Daniel Jacobowitz wrote:
> On Sat, May 10, 2003 at 03:52:49PM -0500, Adam Majer wrote:
> > On Fri, May 09, 2003 at 12:05:52AM +0200, Bernhard Kaindl wrote:
> > > Hello,
> > >=20
> > > The attached patch cleans up the too restrictive checks which were
> > > included in the original ptrace/kmod secfix posted by Alan Cox
> > > and applies on top of a clean 2.4.20-rc1 source tree.
> >=20
> > But the ptrace hole is _NOT_ fixed... :(
>=20
> This is the exploit which makes itself suid.  Did you leave it suid
> before retesting it?

RIGHT..!!! :) Opps. That's why it "worked"... Never mind. 2.4.20-rc2 is
fixed.

- Adam

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+vW5c73/bNdaAYUURArOQAKCCZIBTi88vhdDf9fUUnXMYkak16gCgld22
ACIMHEkukZMEHHudnI5g8TM=
=a8lZ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
