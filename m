Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUDEP2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 11:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUDEP2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 11:28:41 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:34433 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S261225AbUDEP2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 11:28:39 -0400
Date: Mon, 5 Apr 2004 16:28:34 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Carlos Fernandez Sanz <cfs-lk@nisupu.com>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: 3com issues in 2.6.5
Message-ID: <20040405152834.GA11853@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Carlos Fernandez Sanz <cfs-lk@nisupu.com>,
	Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
References: <003301c41b18$38ff7f90$1530a8c0@HUSH> <20040405110541.B22980@animx.eu.org> <000401c41b1f$d2cf65c0$1530a8c0@HUSH>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <000401c41b1f$d2cf65c0$1530a8c0@HUSH>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 05, 2004 at 05:08:16PM +0200, Carlos Fernandez Sanz wrote:
> > > module with both interfaces up, but obviously as soon as I do that they
> > > dissapear - I assume this is the intended 2.6 behaviour).
> >
> > Let me ask you, are you noticing slowness sending or receiving?  I'm
> having
> 
> Yes, this is why I started to look at the problem.
> (slow as in 100 kb/s in a 100 Mbit/s LAN).

   I'm reasonably certain that there's something wrong somewhere with
the 2.6 network subsystem. I've been getting _very_ slow network
performance with a PCI natsemi card -- characterised by repeated
netdev watchdog timeouts under any load heavier than an ssh terminal
session.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
              --- w.w.w.  : England's batting scorecard ---              

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcXsissJ7whwzWGARAkukAJ9m7YvvIdOKKeJaFqrrrW+6rGylCACgk+0E
E2JTq7hOiMahKKyvotD8FfQ=
=A9B+
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
