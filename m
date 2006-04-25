Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWDYRnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWDYRnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDYRnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:43:21 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:57534 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S1751414AbWDYRnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:43:20 -0400
Date: Tue, 25 Apr 2006 10:43:17 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "Theodore Ts'o" <tytso@mit.edu>,
       Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060425174317.GD6819@suse.de>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Stephen Smalley <sds@tycho.nsa.gov>, Theodore Ts'o <tytso@mit.edu>,
	Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
	James Morris <jmorris@namei.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <20060424070324.GA14720@thunk.org> <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil> <20060424235215.GA5893@thunk.org> <1145983533.21399.56.camel@moss-spartans.epoch.ncsc.mil> <1145983961.3114.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <1145983961.3114.32.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 25, 2006 at 06:52:40PM +0200, Arjan van de Ven wrote:
> a scary angle is that a compromised "confined" process can still
> reconfigure all your networking to the point that it can forward and NAT

If you have decided to allow the process to use CAP_NET_ADMIN by adding
the text "capability net_admin," to the profile in question, I fail to
see how this is "scary" -- in fact, this is exactly what you have chosen
to allow this process to do.

One of our developers has a profile set of 827 profiles that we use for
testing system functionality and our tools; twenty of those profiles have
"capability net_admin" granted. The other 807 profiles do not have the
ability to reconfigure the network at will.

I hope this clears up your concern. Thanks Arjan


--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFETl+1+9nuM9mwoJkRAl2aAJ4twiAdENFvXadQsBHBcgPliaZVfgCdHjXe
TNlNzh1uTtn0t65NeN5R5u8=
=Dk9S
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
