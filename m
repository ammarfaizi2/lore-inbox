Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUDNPRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUDNPPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:15:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53934 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264265AbUDNPN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:13:28 -0400
Date: Wed, 14 Apr 2004 17:12:55 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Shielded CPUs
Message-ID: <20040414151255.GA3234@devserv.devel.redhat.com>
References: <1081953482.11976.0.camel@laptop.fenrus.com> <Pine.LNX.4.33L2.0404141111290.20579-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0404141111290.20579-100000@rtlab.med.cornell.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Wed, Apr 14, 2004 at 11:11:47AM -0400, Calin A. Culianu wrote:
> On Wed, 14 Apr 2004, Arjan van de Ven wrote:
> 
> > On Wed, 2004-04-14 at 16:23, Calin A. Culianu wrote:
> > > This might be a bit off-topic (and might belong in the rtlinux mailing
> > > list), but I wanted people's opinion on LKML...
> > >
> > > There's an article in the May 2004 Linux Journal about some CPU affinity
> > > features in Redhawk Linux that allow a process and a set of interrupts to
> > > be locked to a particular CPU for the purposes of improving real-time
> > > performance.
> >
> > well you can do both of those already in 2.6 and in all recent vendor
> > 2.4's that I know of..... no patches needed.
> 
> 
> Cool.. it's still not, strictly speaking, _hard_ realtime, though, is it?
> Simply really good soft-realtime, right?

yep. Hard real time means you need to get a hard RT OS code. Simple as that.
And you'll always see that those cores are kept relatively small so that the
vendor can basically prove it's RT correctness.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAfVT3xULwo51rQBIRArBuAJoCmUMfYlZfEux5kL2ota1JBvNnUQCeNWcg
o6jNPRXSSHqywmY+aS3igOU=
=Pd6w
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
