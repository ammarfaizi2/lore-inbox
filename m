Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVDGHoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVDGHoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVDGHoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:44:25 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:22748 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261889AbVDGHoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:44:19 -0400
Date: Thu, 7 Apr 2005 09:44:08 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050407074407.GA25194@vagabond>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 06, 2005 at 08:42:08 -0700, Linus Torvalds wrote:
> PS. Don't bother telling me about subversion. If you must, start reading
> up on "monotone". That seems to be the most viable alternative, but don't
> pester the developers so much that they don't get any work done. They are
> already aware of my problems ;)

I have looked at most systems currently available. I would suggest
following for closer look on:

1) GNU Arch/Bazaar. They use the same archive format, simple, have the
   concepts right. It may need some scripts or add ons. When Bazaar-NG
   is ready, it will be able to read the GNU Arch/Bazaar archives so
   switching should be easy.
2) SVK. True, it is built on subversion, but adds all the distributed
   features necessary. It keeps mirror of the repository localy (but can
   mirror only some branches), but BitKeeper did that too. It just hit
   1.0beta1, but the development is progressing rapidly. There was
   a post about ability to track changeset dependencies lately on their
   mailing-list.

I have looked at Monotone too, of course, but I did not find any way for
doing cherry-picking (ie. skipping some changes and pulling others) in
it and I feel it will need more rework of the meta-data before it is
possible. As for the sqlite backend, I'd not consider that a problem.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCVOTHRel1vVwhjGURAi9QAKCbDO1komd7YkcDgj/WqLLsOL+dzgCgvHpZ
3HwSeiOpvVHASq4elDHBKn0=
=C1RL
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
