Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270151AbUJTJtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270151AbUJTJtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270305AbUJTJtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:49:14 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:46025 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S270151AbUJTJr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:47:57 -0400
Date: Wed, 20 Oct 2004 11:46:38 +0200
From: Martin Waitz <tali@admingilde.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@karaya.com>,
       linux-kernel@vger.kernel.org
Subject: Re: generic hardirq handling for uml
Message-ID: <20041020094638.GH3618@admingilde.org>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@karaya.com>,
	linux-kernel@vger.kernel.org
References: <20041020001124.GA29215@admingilde.org> <20041020031826.GA9966@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <20041020031826.GA9966@taniwha.stupidest.org>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Oct 19, 2004 at 08:18:26PM -0700, Chris Wedgwood wrote:
> > -void free_irq(unsigned int irq, void *dev_id)
> [...]
> > -			free_irq_by_irq_and_dev(irq, dev_id);

> that is actually needed and missing from the generic code, if you run
> w/o this you will get funnies won't you?

ups, I must have missed that.
Well the system booted but I haven't done stress tests yet.

I guess I'll use your patch for further tests :)

--=20
Martin Waitz

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBdjP9j/Eaxd/oD7IRAjuPAJ9ABNY7VhvsAhNidBPZuHeBjidbXACeMkSN
HrL3jvQXucInAZ6pqx+HZjQ=
=fmls
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
