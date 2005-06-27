Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVF0IdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVF0IdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVF0IdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:33:06 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:25778 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261954AbVF0Ic0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:32:26 -0400
Date: Mon, 27 Jun 2005 10:32:19 +0200
From: Harald Welte <laforge@netfilter.org>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Bart De Schuymer <bdschuym@telenet.be>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, Patrick McHardy <kaber@trash.net>,
       rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050627083219.GZ19928@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Bart De Schuymer <bdschuym@pandora.be>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bart De Schuymer <bdschuym@telenet.be>, netfilter-devel@manty.net,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	ebtables-devel@lists.sourceforge.net,
	Patrick McHardy <kaber@trash.net>, rankincj@yahoo.com
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au> <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de> <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net> <1119293193.3381.9.camel@localhost.localdomain> <42B74FC5.3070404@trash.net> <1119338382.3390.24.camel@localhost.localdomain> <42B82F35.3040909@trash.net> <20050622214920.GA13519@gondor.apana.org.au> <1119507800.3387.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yPlaimQd/TpiYx8R"
Content-Disposition: inline
In-Reply-To: <1119507800.3387.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Thu, Jun 23, 2005 at 06:23:20AM +0000, Bart De
	Schuymer wrote: > Op do, 23-06-2005 te 07:49 +1000, schreef Herbert Xu:
	> > Longer term though we should obsolete the ipt_physdev module. The >
	> rationale there is that this creates a precedence that we can't > >
	possibly maintain in a consistent way. For example, we don't have > > a
	target that matches by hardware MAC address. If you wanted to > > do
	that, you'd hook into the arptables interface rather than deferring > >
	iptables after the creation of the hardware header. > > Iptables also
	sees purely bridged packets and at least for these packets > the
	physdev module is useful and harmless. I think removing physdev >
	alltogether is a bit drastic. > > I wonder what flood of messages from
	angry users the removal of the > physdev functionality for routed
	packets will stirr. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yPlaimQd/TpiYx8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2005 at 06:23:20AM +0000, Bart De Schuymer wrote:
> Op do, 23-06-2005 te 07:49 +1000, schreef Herbert Xu:
> > Longer term though we should obsolete the ipt_physdev module.  The
> > rationale there is that this creates a precedence that we can't
> > possibly maintain in a consistent way.  For example, we don't have
> > a target that matches by hardware MAC address.  If you wanted to
> > do that, you'd hook into the arptables interface rather than deferring
> > iptables after the creation of the hardware header.
>=20
> Iptables also sees purely bridged packets and at least for these packets
> the physdev module is useful and harmless. I think removing physdev
> alltogether is a bit drastic.
>=20
> I wonder what flood of messages from angry users the removal of the
> physdev functionality for routed packets will stirr.

I have to agree with Bart.  I don't know any bridging-packetfilter setup
that doesn't use ipt_physdev in FORWARD :(

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--yPlaimQd/TpiYx8R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCv7mTXaXGVTD0i/8RAg0EAKCTW0QG12/GR10fDDOxvKztUN6xrgCcCht6
3rJMrMz7GlsShew+mQXMtgU=
=iQ8I
-----END PGP SIGNATURE-----

--yPlaimQd/TpiYx8R--
