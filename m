Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272630AbTG3B6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272647AbTG3B6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:58:09 -0400
Received: from niobium.golden.net ([199.166.210.90]:31964 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP id S272630AbTG3B6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:58:07 -0400
Date: Tue, 29 Jul 2003 21:57:56 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS weirdness in 2.6.0-test1
Message-ID: <20030730015756.GA2137@linux-sh.org>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030725151127.GA2947@linux-sh.org> <16161.25923.623651.618044@charged.uio.no> <20030726015007.GA18944@linux-sh.org> <16166.46256.737464.27553@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <16166.46256.737464.27553@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2003 at 07:53:52PM +0200, Trond Myklebust wrote:
> > NFS: server cheating in read reply: count 1526 > recvd 1000
> > NFS: server cheating in read reply: count 4096 > recvd 1000
> > NFS: server cheating in read reply: count 1583 > recvd 1000
>=20
> Does the following patch fix it?
>=20
Yes, this seems to work fine. I've been running this for awhile now
under relative load, and haven't seen any data corruption.

Thanks!


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/JyYj1K+teJFxZ9wRAiAmAJ4gCe973AjdFnr64AeERqxjV2g//QCdF4PO
6O/ZayTaMSHXR/yYLNOi7Fw=
=v2Mq
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
