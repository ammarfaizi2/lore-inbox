Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316067AbSEZNUn>; Sun, 26 May 2002 09:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316072AbSEZNUm>; Sun, 26 May 2002 09:20:42 -0400
Received: from ppp-217-133-218-67.dialup.tiscali.it ([217.133.218.67]:130 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S316067AbSEZNUl>;
	Sun, 26 May 2002 09:20:41 -0400
Subject: Re: How to send GnuPG signed mail to linux-kernel and maintainers?
From: Luca Barbieri <ldb@ldb.ods.org>
To: Dave Jones <davej@suse.de>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020526145018.H16102@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-/j5PveOR0GKatHV4j7Ar"
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 May 2002 15:20:34 +0200
Message-Id: <1022419234.4072.46.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/j5PveOR0GKatHV4j7Ar
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-05-26 at 14:50, Dave Jones wrote:
> On Sun, May 26, 2002 at 02:29:07PM +0200, Luca Barbieri wrote:
>  > Not using digital signatures is obviously not an option since there is
>  > no way to prove that a message was not authentic (if it contains a
>  > trojan patch, for example). 
> 
> Just because a patch has been signed does not mean it somehow manages
> to bypass peer review.
> 
> If the patch is correct, it gets applied. If it's not obviously correct,
> it gets reviewed by someone more familiar with the code.
> 
> Some people have a hard enough time getting patches they believe are
> legitimate features/fixes past Al Viro, Dave Miller and the likes.
> The chances of a trojan patch getting past them is I would hope, extremely minimal.

Signing a patch and getting it applied are completely separate issues.
OTOH, if Linus or anyone else has a policy of dropping all mail using
non-plaintext encodings, sending it using such an encoding is a sure way
of preventing its application.

What I was trying to say is that someone might post a trojan patch with
my name and after it gets rejected, I might get accused of trying to get
it applied. And if the forger somehow manages to get it applied the
damage to me is even greater.

Another problem that arises from unsigned messages and people not
verifying signed ones is that someone may send a message pretending that
it is from a legitimate maintainer of a patchset (including you) and
announce a new version of the patchset with a changed URL.
If the patchset maintainer doesn't immediately notice the problem,
several people might apply the patchset, trusting the maintainer, before
the forgery is exposed.


--=-/j5PveOR0GKatHV4j7Ar
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA88OEidjkty3ft5+cRAqUGAJ0bAmiFfZOyqN0+tpnPePbJnvUjrwCgjPr0
jm+CyT7tRoMHsdzHZ9pxUj4=
=X4NY
-----END PGP SIGNATURE-----

--=-/j5PveOR0GKatHV4j7Ar--
