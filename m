Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317881AbSGPP3m>; Tue, 16 Jul 2002 11:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317882AbSGPP3l>; Tue, 16 Jul 2002 11:29:41 -0400
Received: from ns.snowman.net ([63.80.4.34]:3595 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S317881AbSGPP3k>;
	Tue, 16 Jul 2002 11:29:40 -0400
Date: Tue, 16 Jul 2002 11:32:30 -0400
From: Stephen Frost <sfrost@snowman.net>
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Using large amounts of memory in the kernel
Message-ID: <20020716153230.GE653@ns>
Mail-Followup-To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <03781128C7B74B4DBC27C55859C9D73809840661@es06snlnt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ohz8t0v+ZTQEWKa"
Content-Disposition: inline
In-Reply-To: <03781128C7B74B4DBC27C55859C9D73809840661@es06snlnt>
User-Agent: Mutt/1.4i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 11:32:13 up 14 days, 13:57, 10 users,  load average: 1.04, 1.05, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Ohz8t0v+ZTQEWKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Shipman, Jeffrey E (jeshipm@sandia.gov) wrote:
> I've got a hash table of packet manipulation information
> I need to use inside of a module in my kernel. The problem
> is that this hash table is around 2MB. I'm trying to figure
> out ways to shrink this table, but I'm coming up short on
> ideas. What would be a good way to be able to allocate enough
> memory to store all of this information?

At a guess I'd say vmalloc...

	Stephen

--1Ohz8t0v+ZTQEWKa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9NDyOrzgMPqB3kigRAq+2AKCWc/35ESoR3z8+YPZRfNEsI0fwHgCcDni6
HGeKNNbKpJKYvhUAw1iQ5KI=
=bYi5
-----END PGP SIGNATURE-----

--1Ohz8t0v+ZTQEWKa--
