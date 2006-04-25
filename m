Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWDYT1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWDYT1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWDYT1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:27:35 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:49104 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S932103AbWDYT1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:27:34 -0400
Date: Tue, 25 Apr 2006 12:27:32 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060425192732.GG6819@suse.de>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
	Chris Wright <chrisw@sous-sol.org>,
	James Morris <jmorris@namei.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <1145862899.3116.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <1145862899.3116.3.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2006 at 09:14:58AM +0200, Arjan van de Ven wrote:
> does apparmor at least (offer) to kill the app when this happens?
> (rationale: the app is hijacked, better kill it before it goes to do
> damage)

We have considered offering a "kill the process on failure" configuration
option; we certainly wouldn't want to force it on people, who might
simply be stopping their application from doing something annoying.

However, the code as currently posted, does not offer this feature.

Thanks for the suggestion

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFETngk+9nuM9mwoJkRAvPcAKCk6BTqSKlL0ul9Cj8Lx3A+V0s/bQCgjQ5o
F9xqP8Ucl13VL/NENUGvxCk=
=e3t7
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
