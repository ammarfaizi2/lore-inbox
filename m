Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUI3P4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUI3P4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269304AbUI3P4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:56:17 -0400
Received: from mx.stud.uni-hannover.de ([130.75.176.3]:65185 "EHLO
	studserv.stud.uni-hannover.de") by vger.kernel.org with ESMTP
	id S269309AbUI3PyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:54:05 -0400
Date: Thu, 30 Sep 2004 17:53:55 +0200
From: Ingo Saitz <Ingo.Saitz@stud.uni-hannover.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Message-ID: <20040930155355.GA12072@schwan.subspace.exe>
References: <20040929105508.GA3506@daedalus.andrew.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <415BB625.9000403@andrew.cmu.edu>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Report: BAYES_10,MY_MTPARENS,USER_IN_WHITELIST_TO,V_10_RND_SMALL_WORDS,V_9_RND_SMALL_WORDS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2004-09-30 7:30:45 James Bruce <bruce () andrew ! cmu ! edu> wrote:

> Some people believe bz2 to be buggy or otherwise less tolerant of=20
> corruption.

Maybe this was true for a very early version of bzip2, but not any
longer.

The opposite is true. .bz2 contains a checksum for each block and a
running checksum (just watch bzip2 -vv file). In case of corruption you
can recover all compressed blocks but the corrupt one with bzip2recover.

Or maybe they just got bad RAM, which would show easier with bz2, since
it uses more memory for decompression than gzip.

    Ingo
--=20
A million monkeys can write Shakespeare,
but it only takes one to mess up an election.
	-- seen on Slashdot about Diebold Voting Machines

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXCwT4XrXtQkN2NURAi9wAJ93QB5zv0JJDA6NZby+bbuMAmNnEQCfSRkk
q/rrWYh6FiV+UVqdL8+of2E=
=FXC3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
